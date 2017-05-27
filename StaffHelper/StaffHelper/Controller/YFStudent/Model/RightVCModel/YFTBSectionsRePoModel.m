//
//  YFTBSectionsRePoModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsRePoModel.h"
#import "YFButton.h"
#import "YFAppConfig.h"


#define YFHeadViewHeight 45.0


@implementation YFTBSectionsRePoModel
{
    BOOL _isShowAll;
}

-(NSUInteger)sectionCount
{
    if (_isShowAll || self.dataArray.count < 3)
    {
        return self.dataArray.count;
    }
    return 3;
}

-(CGFloat)headerHeight
{
    if (self.dataArray.count == 0) {
        return 0.0;
    }else
    {
      return YFHeadViewHeight;
    }
}

-(void)setStudentFilterRePeo
{
    _isShowAll = NO;
    
    self.textColor = YFCellTitleColor;
    self.xxOffset = XFrom6YF(14.0);
    self.font = [UIFont systemFontOfSize:15.0];
    self.headViewBaColor = [UIColor whiteColor];
    self.headReaHeight = YFHeadViewHeight;
    CGFloat headerHeight = YFHeadViewHeight;
    self.yyOffset = 0;
    
    CGFloat buttonWidth = 47.0;
    
    
    CGFloat   labelWidth = XFrom5YF(29.0);
    CGFloat   labelHeight = headerHeight;
    
    CGFloat   imageWidth = XFrom5YF(11.0);
    CGFloat   imageHeight = XFrom5YF(7.0);
    
    CGFloat    labelx = (buttonWidth - labelWidth - imageWidth)/ 2.0;
    CGFloat   labely = 0;
    
    CGFloat   imagex = (buttonWidth - labelWidth - imageWidth)/ 2.0 + labelWidth;
    CGFloat   imagey = (headerHeight - imageHeight)/ 2.0;
    
    
    YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(self.headerView.width * StudentRightShowScale - buttonWidth - XFrom6YF(14.0) - 3, 0, buttonWidth, headerHeight) imageFrame:CGRectMake(imagex, imagey, imageWidth, imageHeight) titleFrame:CGRectMake(labelx, labely, labelWidth, labelHeight)];
    
    [button setTitle:@"全部" forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:@"AllDownArrow"] forState:UIControlStateNormal];
    [button setTitleColor:RGB_YF(51, 51, 51) forState:UIControlStateNormal];
    [button setTitleColor:RGB_YF(24, 181, 83) forState:UIControlStateSelected];
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:button];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(XFrom6YF(14.0), 0, self.headerView.frame.size.width - XFrom6YF(14.0), 0.5)];
    
    lineView.backgroundColor = YFLineViewColor;
    [self.headerView  addSubview:lineView];
}

- (void)buttonAction:(UIButton *)button
{
    _isShowAll = !_isShowAll;
    
    if (_isShowAll)
    {
        [button setImage:[UIImage imageNamed:@"AllUpArrow"] forState:UIControlStateNormal];

    }else
    {
        [button setImage:[UIImage imageNamed:@"AllDownArrow"] forState:UIControlStateNormal];
    }
    
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView reloadData];
}


@end
