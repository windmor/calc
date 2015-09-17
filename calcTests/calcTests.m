//
//  calcTests.m
//  calcTests
//
//  Created by Liliya Sayfutdinova on 16/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CCParser.h"

@interface calcTests : XCTestCase
{
    CCParser* _parser;
}

@end

@implementation calcTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _parser = [[CCParser alloc] init];
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

- (void)testUndefSymbol
{
    NSString* inputStr = @"1+3-b";
    [_parser calculateString:inputStr
                withCallback:^(float response) {
                    NSLog(@"*** %.02lf", response);
                }
            andCallbackError:^(NSError *error) {
                NSLog(@"*** %@", error.userInfo[ERROR_MSG]);
            }];
}

- (void)testMissedLBR
{
    NSString* inputStr = @"1+3-(7+9";
    [_parser calculateString:inputStr
                withCallback:^(float response) {
                    NSLog(@"*** %.02lf", response);
                }
            andCallbackError:^(NSError *error) {
                NSLog(@"*** %@", error.userInfo[ERROR_MSG]);
            }];
}

- (void)testIncorrectExpression
{
    NSString* inputStr = @"1+3/-7";
    [_parser calculateString:inputStr
                withCallback:^(float response) {
                    NSLog(@"*** %.02lf", response);
                }
            andCallbackError:^(NSError *error) {
                NSLog(@"*** %@", error.userInfo[ERROR_MSG]);
            }];
}

- (void)testDivByZero
{
    NSString* inputStr = @"3/0";
    [_parser calculateString:inputStr
                withCallback:^(float response) {
                    NSLog(@"*** %.02lf", response);
                }
            andCallbackError:^(NSError *error) {
                NSLog(@"*** %@", error.userInfo[ERROR_MSG]);
            }];
}

@end


