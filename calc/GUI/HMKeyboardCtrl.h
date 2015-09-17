//
//  HMKeyboardViewController.h
//  RuNews
//
//  Created by Admin on 18/02/15.
//  Copyright (c) 2015 HappyMexanik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMKeyboardCtrl : UIViewController <UIScrollViewDelegate>
{
    UIScrollView* _sView;
    
    float _scrollViewContentHeight;
}

@property (weak, nonatomic) UITextField *activeField;
@property (weak, nonatomic) UITextView *activeView;

@property (weak, nonatomic) IBOutlet UIView *endView;

- (void)updateScrollViewHeight;

@end
