//
//  YFTBSectionsLineExEdgeDelegate.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsLineExEdgeDelegate.h"

#import "YFTBSectionsModel.h"

@implementation YFTBSectionsLineExEdgeDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[indexPath.section];
        
        NSArray *array = sectionModel.dataArray;
        if (array.count > indexPath.row)
        {
            
                YFBaseCModel * model = array[indexPath.row];
                
                [cell setSeparatorInset:model.edgeInsets];
                
                if ([cell respondsToSelector:@selector(setLayoutMargins:)])
                {
                    [cell setLayoutMargins:model.edgeInsets];
                }
        }
    }
}


@end
