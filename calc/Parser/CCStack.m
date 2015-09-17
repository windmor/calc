//
//  CCStack.m
//  calc
//
//  Created by Liliya Sayfutdinova on 16/09/15.
//  Copyright © 2015 Liliya. All rights reserved.
//

#import "CCStack.h"

@implementation CCStack

- (instancetype)init
{
    if (self = [super init]) {
        _arrContent = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push:(id)object
{
    [_arrContent addObject:object];
}

- (id)pop
{
    id returnObject = [_arrContent lastObject];
    if (returnObject) {
        [_arrContent removeLastObject];
    }
    return returnObject;
}

- (id)lastObject
{
    return [_arrContent lastObject];
}

- (int)count
{
    return (int)_arrContent.count;
}




@end
