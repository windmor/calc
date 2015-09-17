//
//  CCParser.m
//  calc
//
//  Created by Liliya Sayfutdinova on 16/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "CCParser.h"
#import "CCStack.h"

#define TOKEN_ADD '+'
#define TOKEN_SUB '-'
#define TOKEN_MUL '*'
#define TOKEN_DIV '/'

#define TOKEN_LBR '('
#define TOKEN_RBR ')'



@implementation CCParser

- (void)calculateString:(NSString*)exp
           withCallback:(completionBlockFloat)callback
       andCallbackError:(completionBlockError)callbackError
{
    _errorMessage = @"";
    float result = [self calculateRPNArray:[self getRPNFromString:exp]];
    if (_errorMessage.length == 0)
        callback(result);
    else
        callbackError([NSError errorWithDomain:@"CALC" code:0 userInfo:[NSDictionary dictionaryWithObject:_errorMessage forKey:ERROR_MSG]]);
}

//===================
// get RPN array
//===================

- (NSMutableArray*)getRPNFromString:(NSString*)inputStr
{
    NSMutableArray* arrRPN = [[NSMutableArray alloc] init];
    CCStack* stack = [[CCStack alloc] init];
    char c;
    bool newDigit = true, newOperation = false;
    
    for (int i = 0; i < inputStr.length; i++)
    {
        c = [inputStr characterAtIndex:i];
        
        if ([self isDigit:c]) // digit
        {
            if (newDigit)   [arrRPN addObject:[NSString stringWithFormat:@"%c", c]];
            else            arrRPN[arrRPN.count - 1] = [NSString stringWithFormat:@"%@%c", [arrRPN lastObject], c];
            newDigit = false;
            newOperation = false;
        }
        else if ([self isOperator:c]) // operator
        {
            if (newOperation) {
                _errorMessage = NSLocalizedString(@"ERROR_INCORRECT_EXP", nil);
                return nil;
            }
            if (c == TOKEN_SUB && newDigit) {
                [arrRPN addObject:@"0"];
            }
            while (stack.count > 0 &&
                   [self operatorPriority:c] <= [self operatorPriority:[[stack lastObject] charValue]])
            {
                [arrRPN addObject:[stack pop]];
            }
            [stack push:@(c)];
            newDigit = true;
            newOperation = true;
        }
        else if ([self isLBR:c]) // lbr
        {
            [stack push:@(c)];
            newDigit = true;
            newOperation = false;
        }
        else if ([self isRBR:c]) // rbr
        {
            while (stack.count > 0 &&
                   [[stack lastObject] charValue] != TOKEN_LBR)
            {
                [arrRPN addObject:[stack pop]];
            }
            if ([[stack lastObject] charValue] == TOKEN_LBR) {
                [stack pop];
            } else {
                _errorMessage = NSLocalizedString(@"ERROR_WHERE_IS_LBR", nil);
                return nil;
            }
            newDigit = true;
            newOperation = false;
        }
        else // error
        {
            _errorMessage = NSLocalizedString(@"ERROR_UNDEFINED_SYMBOL", nil);
            return nil;
        }
    }
    
    while (stack.count > 0) {
        [arrRPN addObject:[stack pop]];
    }
    
    return arrRPN;
}

//=====================
// calculate RPN array
//=====================

- (float)calculateRPNArray:(NSMutableArray*)arrRPN
{
    float res = 0;
    float div = 1;
    
    if (!arrRPN) return res;
    
    CCStack* stack = [[CCStack alloc] init];
    for (int i = 0; i < arrRPN.count; i++) {
        if ([arrRPN[i] isKindOfClass:[NSString class]]) {
            [stack push:@([arrRPN[i] floatValue])];
        } else {
            switch ([arrRPN[i] charValue]) {
                case TOKEN_ADD:
                    [stack push:@([[stack pop] floatValue] + [[stack pop] floatValue])];
                    break;
                case TOKEN_SUB:
                    [stack push:@(-[[stack pop] floatValue] + [[stack pop] floatValue])];
                    break;
                case TOKEN_MUL:
                    [stack push:@([[stack pop] floatValue] * [[stack pop] floatValue])];
                    break;
                case TOKEN_DIV:
                    div = [[stack pop] floatValue];
                    if (div != 0) {
                        [stack push:@([[stack pop] floatValue] / div)];
                    } else {
                        _errorMessage = NSLocalizedString(@"ERROR_DIVISION_BY_ZERO", nil);
                    }
                    break;
                default:
                    _errorMessage = NSLocalizedString(@"ERROR_INCORRECT_EXP", nil);
                    return res;
                    break;
            }
        }
    }
    
    if (stack.count == 1) res = [[stack pop] floatValue];
    else {
        _errorMessage = NSLocalizedString(@"ERROR_INCORRECT_EXP", nil);
    }
    
    return res;
}

//===================
// is digit
//===================

- (bool)isDigit:(char)d
{
    return isdigit(d);
}

//===================
// is operator
//===================

- (bool)isOperator:(char)d
{
    if (d == TOKEN_ADD ||
        d == TOKEN_SUB ||
        d == TOKEN_MUL ||
        d == TOKEN_DIV) return true;
    
    return false;
}

//===================
// is (
//===================

- (bool)isLBR:(char)d
{
    if (d == TOKEN_LBR) return true;
    
    return false;
}

//===================
// is )
//===================

- (bool)isRBR:(char)d
{
    if (d == TOKEN_RBR) return true;
    
    return false;
}

//========================
// get operator priority
//========================

- (int)operatorPriority:(char)d
{
    switch (d) {
        case TOKEN_LBR:
        case TOKEN_RBR:
            return 1;
            break;
        case TOKEN_ADD:
        case TOKEN_SUB:
            return 2;
            break;
        case TOKEN_MUL:
        case TOKEN_DIV:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}


@end
