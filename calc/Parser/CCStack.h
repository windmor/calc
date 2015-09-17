//
//  CCStack.h
//  calc
//
//  Created by Liliya Sayfutdinova on 16/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCStack : NSObject
{
    NSMutableArray* _arrContent;
}

- (void)push:(id)object;
- (id)pop;
- (int)count;
- (id)lastObject;

@end
