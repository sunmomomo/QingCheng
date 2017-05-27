//
//  YFTBSectionsTitleModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBSectionsTitleModel.h"
#import "YFAppConfig.h"


@implementation YFTBSectionsTitleModel
{
    UIView *_subHeadView;
    
    UILabel *_titleLabel;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.isAlwaysShowHeadView = NO;
    }
    return self;
}


-(UIView *)headerView
{
    if (_subHeadView == nil)
    {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, self.headReaHeight)];
        if (self.sectionTitle.length)
        {
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(self.xxOffset, self.yyOffset, headerView.frame.size.width - self.xxOffset * 2 , headerView.frame.size.height - self.yyOffset)];
            title.font = self.font;
            title.textAlignment = NSTextAlignmentLeft;
            title.text = self.sectionTitle;
            title.textColor = self.textColor;
            [headerView addSubview:title];
            title.backgroundColor = [UIColor clearColor];
            _titleLabel = title;
        }
        if (self.subViewOfHeaderView)
        {
            [headerView addSubview:self.subViewOfHeaderView];
        }
        headerView.backgroundColor = self.headViewBaColor;
        _subHeadView = headerView;
    }
    
    if (self.dataArray.count == 0 && self.isAlwaysShowHeadView == NO) {
        _subHeadView.hidden = YES;
    }else
    {
        _subHeadView.hidden = NO;
    }
    
    return _subHeadView;
}



-(UIFont *)font
{
    if (_font == nil)
    {
        _font = [UIFont systemFontOfSize:14];
    }
    return _font;
}
-(UIColor *)textColor
{
    if (_textColor == nil)
    {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

-(UIColor *)headViewBaColor
{
    if (_headViewBaColor == nil)
    {
        _headViewBaColor = [UIColor whiteColor];
    }
    return _headViewBaColor;
}

-(void)setStudentFilter
{
    self.textColor = RGB_YF(251, 80, 81);
    self.xxOffset = 17.0;
    self.font = [UIFont systemFontOfSize:13];
//    self.sectionTitle = @"A";
    self.headViewBaColor = RGB_YF(244, 244, 244);
    self.headReaHeight = 20.0;
    self.headerHeight = 20.0;
}

- (void)setFollowinFilter
{
    self.textColor = RGB_YF(151, 151, 151);
    self.xxOffset = 19.0;
    self.font = [UIFont systemFontOfSize:13];
    //    self.sectionTitle = @"A";
    self.headViewBaColor = RGB_YF(244, 244, 244);
    self.headReaHeight = 47.0;
    self.headerHeight = 47.0;
}

-(void)setGrayViewHeight:(CGFloat)height
{
    self.headViewBaColor = RGB_YF(244, 244, 244);
    self.headReaHeight = height;
    self.headerHeight = height;
}


- (void)setSectionTitle:(NSString *)sectionTitle
{
    _sectionTitle = sectionTitle;
    
    _titleLabel.text = _sectionTitle;
}

@end
