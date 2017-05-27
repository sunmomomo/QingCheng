//
//  YFTBStudentTBDelegate.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFTBStudentTBDelegate.h"

@implementation YFTBStudentTBDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 82.0, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 82.0, 0, 0)];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetXX = _header.height - self.needToTopView.height;
    
    if (offsetXX <= scrollView.contentOffset.y)
    {
        if ([self.needToTopView.superview isEqual:self.superViewOfNeedToTopView] == NO)
        {
            [self.needToTopView changeTop:64.0];
            [self.superViewOfNeedToTopView addSubview:self.needToTopView];
        }
    }else
    {
        if ([self.needToTopView.superview isEqual:_header] == NO)
        {
            [self.needToTopView changeTop:_header.height - self.needToTopView.height];
            [_header addSubview:self.needToTopView];
        }
    }
}



@end
