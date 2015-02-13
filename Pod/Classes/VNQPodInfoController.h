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

/**
 returns the raw PODS section of the Podfile.lock
 */
- (NSArray*)pods;

/**
 returns the raw DEPENDENCIES section of the Podfile.lock
 This is the representation of the Podfile specified pods.
 */
- (NSArray*)dependencies;

/**
 returns the version of the pod toolset used for the creation of that Podfile.lock
 */
- (NSString*)podVersion;

/**
 returns the DEPENDENCIES with the actual linked cocoapod versions
 This returns the specified pods with the actual version.
 */
- (NSArray*)dependenciesWithInstalledVersion;

/**
 returns the PODS traversed as a tree structure with the acutal linked cocoapod versions.
 */
- (NSArray*)podsAsTree;

@end
