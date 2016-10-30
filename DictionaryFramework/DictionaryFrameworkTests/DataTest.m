//
//  DataTest.m
//  DictionaryFramework
//
//  Created by msp on 16/10/30.
//  Copyright © 2016年 msp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataManagement.h"
@interface DataTest : XCTestCase

@end

@implementation DataTest

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
    Word * word = [[Word alloc] init];
    NSLog(@"%@",[@"hello" description] );
    word.translate = [@"hello" description];
    word.usphonetic = @"hello";
    word.ukphonetic = @"hello";
    word.word = @"hello";

    [[DataManagement instance] addIntoDataSource:word];
//    [[DataManagement instance] queryAllData];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
