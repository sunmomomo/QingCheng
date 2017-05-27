//
//  UIButton+Identifier.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "UIButton+Category.h"

#import <objc/runtime.h>

static void * IndexPathKey = (void *)@"IndexPathKey";

@implementation UIButton (Category)

@dynamic indexPath;

- (NSIndexPath*)indexPath
{
    return objc_getAssociatedObject(self, IndexPathKey);
}

- (void)setIndexPath:(NSIndexPath*)indexPath
{
    objc_setAssociatedObject(self, IndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
