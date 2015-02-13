/**
 VNQPodInfoController.m
 Pods

 Created by Joachim Schuster on 12.02.15.
  
 */

#import "VNQPodInfoController.h"
#import <YAML-Framework/YAMLSerialization.h>
#import "VNQPodModel.h"

NSString* const COCOAPODS_PODFILE_PODS = @"PODS";
NSString* const COCOAPODS_PODFILE_DEPENDENCIES = @"DEPENDENCIES";
NSString* const COCOAPODS_PODFILE_PODVERSION = @"COCOAPODS";

@interface VNQPodInfoController ()

- (NSArray*)podsUserSpecified;

@end

@implementation VNQPodInfoController

- (NSDictionary*)podfileAsDictionary {
  NSString* bundlePath = [[NSBundle mainBundle] pathForResource:@"PodInfoController" ofType:@"bundle"];
  NSBundle* bundle = [NSBundle bundleWithPath:bundlePath];
  NSString* filePath = [bundle pathForResource:@"Podfile" ofType:@"lock"];
  NSString* podfileText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
  NSError* error;
  NSMutableArray* yamlObjects = [YAMLSerialization objectsWithYAMLString:podfileText options:kYAMLReadOptionStringScalars error:&error];
  NSDictionary* podfileDict = [yamlObjects firstObject];
  return podfileDict;
}

- (NSArray*)pods {
  return [[self podfileAsDictionary] objectForKey:COCOAPODS_PODFILE_PODS];
}

- (NSArray*)dependencies {
  return [[self podfileAsDictionary] objectForKey:COCOAPODS_PODFILE_DEPENDENCIES];
}

- (NSString*)podVersion {
  return [[self podfileAsDictionary] objectForKey:COCOAPODS_PODFILE_PODVERSION];
}

- (NSArray*)podsUserSpecified {
  NSArray* depenencies = [self dependencies];
  NSMutableArray* pods = [NSMutableArray arrayWithCapacity:[depenencies count]];
  for (NSString* rawPod in depenencies) {
    [pods addObject:[[VNQPodModel alloc] initWithString:rawPod]];
  }
  return pods;
}

- (NSArray*)dependenciesWithInstalledVersion {
  NSArray* pods = [self podsAsTree];
  NSMutableArray* podsWithVersion = [NSMutableArray arrayWithCapacity:[pods count]];
  for (VNQPodModel* pod in pods) {
    [podsWithVersion addObject:[pod nameAndVersion]];
  }
  return podsWithVersion;
}

- (NSArray*)podsAsTree {
  // convert the array of objects into nodes of type VNQPodModel
  NSArray* pods = [self pods];
  NSMutableArray* libs = [NSMutableArray array];
  for (id pod in pods) {
    if ([pod isKindOfClass:[NSString class]]) {
      [libs addObject:[[VNQPodModel alloc] initWithString:pod]];
      continue;
    }
    if ([pod isKindOfClass:[NSDictionary class]]) {
      [libs addObject:[[VNQPodModel alloc] initWithDictionary:pod]];
      continue;
    }
  }
  // replace reference objects with the concrete representation reference
  for (VNQPodModel* pod in libs) {
    for (NSUInteger index = 0; index < [pod.referencedPods count]; index++) {
      for (VNQPodModel* needle in libs) {
        if ([needle isEqual:pod.referencedPods[index]]) {
          [pod.referencedPods replaceObjectAtIndex:index withObject:needle];
        }
      }
    }
  }
  // filter the level one child nodes to match that one specified by the user in the Podfile
  NSArray* userSpecified = [self podsUserSpecified];
  NSMutableArray* result = [NSMutableArray arrayWithCapacity:[userSpecified count]];
  for (VNQPodModel* pod in libs) {
    for (VNQPodModel* userPods in userSpecified) {
      if ([pod isEqual:userPods]) {
        [result addObject:pod];
        break;
      }
    }
  }
  return result;
}


@end
