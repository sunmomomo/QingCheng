//
//  YFTBSectionsDataSource.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBSectionsDataSource.h"
#import "YFTBSectionsModel.h"
#import "YFBaseCModel.h"

@implementation YFTBSectionsDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray().count > section)
    {
        YFTBSectionsModel *sectionModel = self.dataArray()[section];
        
        return sectionModel.sectionCount;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataArray().count;
}

#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray().count > indexPath.section)
    {
        YFTBSectionsModel *sectionModel= self.dataArray()[indexPath.section];
        sectionModel.indexPath = indexPath;
        sectionModel.weakTableView = tableView;
        NSArray *array  = sectionModel.dataArray;
        
        if (array.count > indexPath.row)
        {
            YFBaseCModel * model = array[indexPath.row];
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
    }
    
    return [self defaultCell:tableView];
    
}


@end
