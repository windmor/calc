//
//  CCParser.h
//  calc
//
//  Created by Liliya Sayfutdinova on 16/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ERROR_MSG @"error_msg"

typedef void (^completionBlockFloat)    (float response);
typedef void (^completionBlockError)    (NSError *error);

@interface CCParser : NSObject
{
    NSString * _errorMessage;
}
- (void)calculateString:(NSString*)exp
           withCallback:(completionBlockFloat)callback
       andCallbackError:(completionBlockError)callbackError;

@end
