//
//  YFTagPreDesCViewCell.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFTagPreDesCViewCell.h"

@implementation YFTagPreDesCViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.tagNameLabel];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (UILabel *)tagNameLabel
{
    if (!_tagNameLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        label.font = [UIFont systemFontOfSize:15];
        
        label.textColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0];;
        
        _tagNameLabel = label;
    }
    return _tagNameLabel;
}

@end
