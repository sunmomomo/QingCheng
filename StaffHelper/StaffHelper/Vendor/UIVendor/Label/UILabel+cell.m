//
//  UILabel+cell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "UILabel+cell.h"

#import "YFAppUIConfig.h"

@implementation UILabel (cell)

+ (UILabel *)cellTitleLabelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.textColor = YFCellTitleColor;
    
    label.font = FontDetailTitleFY;
    
    label.numberOfLines = 0;

    return label;
}

+ (UILabel *)cellDesLabelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    label.textColor = YFCellSubHintGrayTitleColor;
    
    label.font = FontCellTitleValueFY;
    
    label.numberOfLines = 0;
    
    return label;
}


@end
