//
//  YFTagFooterCReusableView.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFTagFooterCReusableView.h"

@implementation YFTagFooterCReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, OnePX)];
        lineView.backgroundColor = YFGrayViewColor;
        [self addSubview:lineView];

    }
    return self;
}

@end
