//
//  YFTagColloectionViewCell.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFTagColloectionViewCell.h"

@implementation YFTagColloectionViewCell
{
    UIView *_lineView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self.contentView addSubview:self.deleteButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 18, (frame.size.height - 16) / 2.0, 0.5, 16)];
        lineView.backgroundColor = [UIColor colorWithRed:106.0/255.0 green:127.0/255.0 blue:164.0 / 255.0 alpha:1.0];
        [self.contentView addSubview:lineView];
        _lineView = lineView;
        
        self.backgroundColor = [UIColor colorWithRed:161.0/255.0 green:180.0/255.0 blue:214.0 / 255.0 alpha:1.0];
        

        self.tagNameLabel.backgroundColor = self.backgroundColor;
        
        [self.contentView addSubview:self.tagNameLabel];
        
        self.clipsToBounds = YES;
//        self.layer.masksToBounds = YES;
        
        self.layer.cornerRadius = self.frame.size.height * 0.5f;
        self.layer.borderColor = [UIColor colorWithRed:125/255.0 green:146/255.0 blue:179/255.0 alpha:1.0].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;

        DebugLogParamYF(@"------******---------00000");
    }
    return self;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 14, (self.frame.size.height - 12) / 2.0, 18, 12)];
        [button setImage:[UIImage imageNamed:@"SmsDelete"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        _deleteButton = button;
    }
    return _deleteButton;
}

- (UILabel *)tagNameLabel
{
    if (!_tagNameLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.deleteButton.frame.origin.x, self.frame.size.height)];
        
        label.font = [UIFont systemFontOfSize:13.0];
        
        label.textColor = [UIColor whiteColor];
        
        _tagNameLabel = label;
    }
    return _tagNameLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.deleteButton.frame = CGRectMake(self.frame.size.width - 24, (self.frame.size.height - 18) / 2.0, 28, 18);
    
    _lineView.frame = CGRectMake(self.frame.size.width - 18, (self.frame.size.height - 16) / 2.0, 0.5, 16);
    
    self.tagNameLabel.frame = CGRectMake(self.frame.size.height / 2.0, 0, _lineView.frame.origin.x - self.frame.size.height / 2.0, self.frame.size.height);
    
    [self.contentView bringSubviewToFront:self.deleteButton];
    
}

- (void)deleteAction:(UIButton *)sender
{
    if (self.deleteBlock) {
        self.deleteBlock(self.tagModel);
    }
}

@end
