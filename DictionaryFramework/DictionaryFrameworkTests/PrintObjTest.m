//
//  PrintObjTest.m
//  DictionaryFramework
//
//  Created by Spencer Mo on 11/1/16.
//  Copyright © 2016 Spencer Mo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PrintObject.h"
#import "Word.h"

@interface PrintObjTest : XCTestCase{
    Word * _item;
}

@end

@implementation PrintObjTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _item = [[Word alloc] init];
}

- (void)testGetJson{
    
    NSError * error;
    NSData * data = [PrintObject getJSON:_item options:NSJSONWritingPrettyPrinted error:&error];
    XCTAssert(data,@"Get json data failed");
    XCTAssert(!error,@"Get json data failed");
}

- (void)testPrint{
    
    _item.word = @"china";
    _item.translate = @"中国";
    [PrintObject print:_item];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
