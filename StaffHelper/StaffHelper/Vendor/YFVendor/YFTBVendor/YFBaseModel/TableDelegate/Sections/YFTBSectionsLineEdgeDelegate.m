//
//  YFTBSectionsLineEdgeDelegate.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsLineEdgeDelegate.h"
#import "YFTBSectionsModel.h"

@implementation YFTBSectionsLineEdgeDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[indexPath.section];
        
        NSArray *array = sectionModel.dataArray;
        if (array.count > indexPath.row)
        {
            if (array.count - 1 > indexPath.row)
            {
                YFBaseCModel * model = array[indexPath.row];
                
                [cell setSeparatorInset:model.edgeInsets];
                
                if ([cell respondsToSelector:@selector(setLayoutMargins:)])
                {
                    [cell setLayoutMargins:model.edgeInsets];
                }
            }
            else
            {
                [cell setSeparatorInset:UIEdgeInsetsZero];
                
                if ([cell respondsToSelector:@selector(setLayoutMargins:)])
                {
                    [cell setLayoutMargins:UIEdgeInsetsZero];
                }

            }
        }
    }
}

@end
