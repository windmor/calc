//
//  HMScrollView.m
//  BarnabasFund
//
//  Created by Admin on 11/03/15.
//  Copyright (c) 2015 HappyMexanik. All rights reserved.
//

#import "HMScrollView.h"

@implementation HMScrollView

//===================
// Set content size
//===================

- (void)setContentSize:(CGSize)aSize {
    if (aSize.height > 0 && aSize.width > 0)
        [super setContentSize:aSize];
}

@end
