/**
 @file VNQPodInfoController.h
 Pods

 Created by Joachim Schuster on 12.02.15.
 
 */

#import <Foundation/Foundation.h>

extern NSString* const COCOAPODS_PODFILE_PODS;
extern NSString* const COCOAPODS_PODFILE_DEPENDENCIES;
extern NSString* const COCOAPODS_PODFILE_PODVERSION;

@interface VNQPodInfoController : NSObject

- (NSDictionary*)podfileAsDictionary;

- (NSArray*)pods;
- (NSArray*)dependencies;
- (NSString*)podVersion;

@end
