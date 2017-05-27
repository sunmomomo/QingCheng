//
//  YFTBSectionLineEdgeDelegate.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionLineEdgeDelegate.h"

@implementation YFTBSectionLineEdgeDelegate


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.row)
    {
        YFBaseCModel * model = self.dataArray()[indexPath.row];

        if (self.dataArray().count - 1 == indexPath.row) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            {
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }

        }else
        {
            [cell setSeparatorInset:model.edgeInsets];
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)])
            {
                [cell setLayoutMargins:model.edgeInsets];
            }
        }
    }
}


@end
