/**
 @file VNQPodModel.h
 Pods

 Created by Joachim Schuster on 13.02.15.
 
 */

#import <Foundation/Foundation.h>

@interface VNQPodModel : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* version;

@property (nonatomic, strong) NSMutableArray* referencedPods;

- (instancetype)initWithString:(NSString*)rawPod;
- (instancetype)initWithDictionary:(NSDictionary*)dict;

- (NSString*)nameAndVersion;

- (BOOL)isEqual:(VNQPodModel*)otherPod;
@end
