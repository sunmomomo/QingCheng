//
//  YFTBSectionsSignUpGroupModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsSignUpGroupModel.h"
#import "UIView+lineViewYF.h"


@implementation YFTBSectionsSignUpGroupModel
{
    UIView *_bottomLineView;
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionTitle =@"小组成员";
        self.headReaHeight = 58.0;
        self.headerHeight = 58.0;
        
        self.textColor = YFCellTitleColor;
        self.xxOffset = 15.0;
        self.font = [UIFont boldSystemFontOfSize:16];

        _bottomLineView = [self.headerView addLinewViewWithxOffset:15.0];
        
        [self.headerView addSubview:self.addButton];
        [self.headerView addSubview:self.deleteButton];
        
        self.isAlwaysShowHeadView = YES;
    }
    return self;
}

- (NSUInteger)sectionCount
{
    if (self.dataArray.count == 0)
    {
        _bottomLineView.frame = CGRectMake(0, self.headerView.height - OnePX, self.headerView.width, OnePX);
    }else
    {
        _bottomLineView.frame = CGRectMake(15, self.headerView.height - OnePX, self.headerView.width - 15, OnePX);

    }
     if (self.isShowAll == NO && self.dataArray.count > MaxShowGroupMemCountYF)
    {
        return MaxShowGroupMemCountYF;
    }
    return self.dataArray.count;

}

- (UIButton *)addButton
{
    if (!_addButton)
    {
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(Width(206), 12, Width(72),34)];
        
        [deleteButton setTitle:@"+ 添加" forState:UIControlStateNormal];
        
        [deleteButton setTitleColor:YFThreeChartDeColor forState:UIControlStateNormal];
        
        deleteButton.titleLabel.font = FontCurrencyTitleFY;
    
        deleteButton.layer.cornerRadius = 2;
        deleteButton.layer.borderColor = YFThreeChartDeColor.CGColor;
        deleteButton.layer.borderWidth = OnePX;
        
        _addButton = deleteButton;
    }
    return _addButton;
}



- (UIButton *)deleteButton
{
    if (!_deleteButton)
    {
        
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(Width(288), 12, Width(72),34)];
        
        [deleteButton setTitle:@"- 移除" forState:UIControlStateNormal];
        
        [deleteButton setTitleColor:YFCellTitleColor forState:UIControlStateNormal];
        
        deleteButton.titleLabel.font = FontCurrencyTitleFY;
        
        deleteButton.layer.cornerRadius = 2;
        deleteButton.layer.borderColor = YFCellTitleColor.CGColor;
        deleteButton.layer.borderWidth = OnePX;
        
        _deleteButton = deleteButton;

        
    }
    return _deleteButton;
}



@end
