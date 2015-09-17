//
//  ViewController.m
//  calc
//
//  Created by Liliya Sayfutdinova on 16/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "ViewController.h"

#import "CCParser.h"

@interface ViewController ()
{
    CCParser* _parser;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _parser = [[CCParser alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCalculate:(id)sender
{
    //float res = [_parser calculateString:@"1+2*(-3)"];
    //float res = [_parser calculateString:@"-(9-3)+9"];
    NSString* inputStr = [_txtInput.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [_parser calculateString:inputStr
                withCallback:^(float response) {
                    _lblOutput.text = [NSString stringWithFormat:@"%.02lf", response];
                }
            andCallbackError:^(NSError *error) {
                _lblOutput.text = error.userInfo[ERROR_MSG];
            }];
    
}

@end
