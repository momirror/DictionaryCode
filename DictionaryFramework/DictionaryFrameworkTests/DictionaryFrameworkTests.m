//
//  DictionaryFrameworkTests.m
//  DictionaryFrameworkTests
//
//  Created by Spencer Mo on 10/31/16.
//  Copyright © 2016 Spencer Mo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataManagement.h"

@interface DictionaryFrameworkTests : XCTestCase

@end

@implementation DictionaryFrameworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSURL *modelURL = [bundle URLForResource:@"Word"withExtension:@"momd"];
    DataManagement * management = [DataManagement instance];
    Word * item = [[Word alloc] init];
    item.word = @"hello";
    item.ukphonetic = @"hello";
    item.usphonetic = @"hello";
    item.translate = @"hello";
    [management addIntoDataSource:item];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
