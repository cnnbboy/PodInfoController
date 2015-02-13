/**
 VNQPodInfoController.m
 Pods

 Created by Joachim Schuster on 12.02.15.
  
 */

#import "VNQPodInfoController.h"
#import <YAML-Framework/YAMLSerialization.h>

NSString* const COCOAPODS_PODFILE_PODS = @"PODS";
NSString* const COCOAPODS_PODFILE_DEPENDENCIES = @"DEPENDENCIES";
NSString* const COCOAPODS_PODFILE_PODVERSION = @"COCOAPODS";

@implementation VNQPodInfoController

- (NSDictionary*)podfileAsDictionary {
  NSString* bundlePath = [[NSBundle mainBundle] pathForResource:@"PodInfoController" ofType:@"bundle"];
  NSBundle* bundle = [NSBundle bundleWithPath:bundlePath];
  NSString* filePath = [bundle pathForResource:@"Podfile" ofType:@"lock"];
  NSString* podfileText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
  
  NSMutableArray* yamlObjects = [YAMLSerialization objectsWithYAMLString:podfileText options:kYAMLReadOptionStringScalars error:nil];
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

@end
