//
//  VNQPodInfoControllerTests.m
//  PodInfoController
//
//  Created by Joachim Schuster on 13.02.15.
//  Copyright (c) 2015 Joachim Schuster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VNQPodInfoController.h"

@interface VNQPodInfoControllerTests : XCTestCase

@end

@implementation VNQPodInfoControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadPodfile {
  [[[VNQPodInfoController alloc] init] podfileAsDictionary];
}

- (void)testDependenciesResolved {
  [[[VNQPodInfoController alloc] init] dependenciesWithInstalledVersion];
}

- (void)testPodsResolved {
//  [[[VNQPodInfoController alloc] init] topLevelPods];
}


- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
