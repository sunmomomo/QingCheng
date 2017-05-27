//
//  YFTBSingleSectionDelegate.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBSingleSectionDelegate.h"
#import "YFBaseCModel.h"

@implementation YFTBSingleSectionDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.row)
    {
        YFBaseCModel * model = self.dataArray()[indexPath.row];
        
        return model.cellHeight;
    }
    return 0.0;
}

@end
