//
//  ViewController.h
//  calc
//
//  Created by Liliya Sayfutdinova on 16/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMKeyboardCtrl.h"

@interface ViewController : HMKeyboardCtrl

@property (weak, nonatomic) IBOutlet UITextField* txtInput;
@property (weak, nonatomic) IBOutlet UILabel* lblOutput;

@end

