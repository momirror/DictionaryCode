//
//  DictionaryFrameworkTests.m
//  DictionaryFrameworkTests
//
//  Created by Spencer Mo on 10/31/16.
//  Copyright © 2016 Spencer Mo. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "DataManagement.h"

@interface DictionaryFrameworkTests : XCTestCase{
    DataManagement * _management;
}

@end

@implementation DictionaryFrameworkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _management = [DataManagement instance];
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
    
}

- (void)testAddData {
    
    Word * item = [[Word alloc] init];
    item.word = @"hello";
    item.ukphonetic = @"hello";
    item.usphonetic = @"hello";
    item.translate = @"hello";
    BOOL bResult = [_management addIntoDataSource:item];
    XCTAssert(bResult,@"Add data to coredata failed");
    
}

- (void)testBQueryWord{
    Word * item = [_management query:@"hello"];
    XCTAssert(item,@"Query word failed");
}

- (void)testCUpdateData {
    Word * item = [[Word alloc] init];
    item.word = @"hello";
    item.ukphonetic = @"hello1";
    item.usphonetic = @"hello";
    item.translate = @"hello";
    [_management update:item];
    Word * updatedItem = [_management query:item.word];
    XCTAssert([updatedItem.ukphonetic isEqualToString:@"hello1"],@"update word failed");

}

- (void)testDQuerryAllData{
    NSArray * allData = [_management queryAllData];
    XCTAssert(allData,@"Query all data failed");
}

- (void)testEDeleteData {
    Word * delWord = [[Word alloc] init];
    delWord.word = @"hello";
    XCTAssert([_management del:delWord],@"delete word failed");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
