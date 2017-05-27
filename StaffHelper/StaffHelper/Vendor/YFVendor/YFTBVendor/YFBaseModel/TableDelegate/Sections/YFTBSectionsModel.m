//
//  YFTBSectionsModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFTBSectionsModel.h"

@implementation YFTBSectionsModel


-(NSUInteger)sectionCount
{
    return  self.dataArray.count;
}

-(UIView *)headerView
{
    if (_dataArray.count) {
        _headerView.hidden = YES;
    }else
    {
        _headerView.hidden = NO;
    }
    return _headerView;
}



-(UIView *)footerView
{
    if ([self sectionCount] == 0)
    {
        return nil;
    }
    return _footerView;
}


-(CGFloat)footerHeight
{
    if (self.sectionCount == 0)
    {
        return 0;
    }
    return _footerHeight;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


@end
