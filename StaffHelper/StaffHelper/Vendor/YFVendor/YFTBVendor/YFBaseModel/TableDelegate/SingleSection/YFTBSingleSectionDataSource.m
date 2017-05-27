//
//  YFTBSingleSectionDataSource.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBSingleSectionDataSource.h"
#import "YFBaseCModel.h"

@implementation YFTBSingleSectionDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray().count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.row)
    {
        YFBaseCModel * model = self.dataArray()[indexPath.row];
        
        YFBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellIdentifier];
        if (cell == nil)
        {
            cell = [model cellWithWeakVC:self.currentVC];
        }
        model.weakCell = cell;
        model.weakCell.currentVC = self.currentVC;
        [model bindCell:cell indexPath:indexPath];
        return cell;
    }
    
    return [self defaultCell:tableView];
    
}

@end
