/**
 VNQPodModel.m
 Pods

 Created by Joachim Schuster on 13.02.15.
  
 */

#import "VNQPodModel.h"

@implementation VNQPodModel

- (instancetype)initWithString:(NSString*)rawPod {
  self = [super init];
  if (self) {
    self.name = [self getNameOfPod:rawPod];
    self.version = [self getVersionOfPod:rawPod];
  }
  return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict {
  self = [self initWithString:[[dict allKeys] firstObject]];
  if (self) {
    NSArray* rawRefrencedPods = [dict objectForKey:[[dict allKeys] firstObject]];
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:[rawRefrencedPods count]];
    for (NSString* rawPod in rawRefrencedPods) {
      [array addObject:[[VNQPodModel alloc] initWithString:rawPod]];
    }
    self.referencedPods = array;
  }
  return self;
}

- (NSString*)getNameOfPod:(NSString*)rawPod {
  return [[rawPod componentsSeparatedByString:@" ("] firstObject];
}

- (NSString*)getVersionOfPod:(NSString*)rawPod {
  NSString* versionPart = [[rawPod componentsSeparatedByString:@" ("] lastObject];
  return [versionPart stringByReplacingOccurrencesOfString:@")" withString:@""];
}

- (NSString*)nameAndVersion {
  return [NSString stringWithFormat:@"%@ (%@)", self.name, self.version];
}

- (BOOL)isEqual:(VNQPodModel*)otherPod {
  return [self.name isEqualToString:otherPod.name];
}

- (NSString*)description {
  NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
  [self addDescriptionToString:description indentLevel:0];
  return description;
}

- (void)addDescriptionToString:(NSMutableString*)string indentLevel:(NSUInteger)indentLevel {
  NSString* padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
  [string appendString:padding];
  [string appendFormat:@"%@, %@",self.name, self.version];
  
  for (VNQPodModel* referencedPod in self.referencedPods) {
    [string appendFormat:@"\n%@>",padding];
    [referencedPod addDescriptionToString:string indentLevel:indentLevel + 1];
  }
}

@end
