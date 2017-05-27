//
//  YFTBSectionsDelegate.m
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBSectionsDelegate.h"
#import "YFTBSectionsModel.h"

@implementation YFTBSectionsDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[indexPath.section];
        if (sectionModel.dataArray.count > indexPath.row)
        {
            YFBaseCModel * model = sectionModel.dataArray[indexPath.row];
            
            return model.cellHeight;
        }
        
        return 0.0;
    }
    
    return 0.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.dataArray().count > section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[section];
        return sectionModel.footerView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataArray().count > section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[section];
        return sectionModel.headerView;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataArray().count > section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[section];
        return sectionModel.headerHeight;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.dataArray().count > section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[section];
        return sectionModel.footerHeight;
    }
    return 0.0;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[indexPath.section];
        
        NSArray *array = sectionModel.dataArray;
        if (array.count > indexPath.row)
        {
            YFBaseCModel * model = array[indexPath.row];
            [model tableView:tableView didSelectRowAtIndexPath:indexPath onVC:self.currentVC];
        }
    }
}



@end
