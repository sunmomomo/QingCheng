//
//  YFTBSwitchValueSectionsModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSwitchValueSectionsModel.h"

@implementation YFTBSwitchValueSectionsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.dataArray addObject:self.switModel];
        [self.dataArray addObject:self.inputModel];
    }
    return self;
}

- (NSUInteger)sectionCount
{
    if (self.switModel.on == NO) {
        self.switModel.edgeInsets  = UIEdgeInsetsMake(0,0, 0, 0);
        return self.dataArray.count - 1;
    }
    self.switModel.edgeInsets  = UIEdgeInsetsMake(0,15, 0, 15);

    return self.dataArray.count;
}

- (YFDesSwitchCModel *)switModel
{
    if (_switModel == nil)
    {
        
        weakTypesYF
        _switModel =[YFDesSwitchCModel defaultWithYYModelDic:nil selectBlock:^(id model){
            [weakS.weakTableView reloadSections:[NSIndexSet indexSetWithIndex:weakS.indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    return _switModel;
}

- (YFInputValueCModel *)inputModel
{
    if (!_inputModel)
    {
        _inputModel =  [YFInputValueCModel defaultWithYYModelDic:nil];
    }
    return _inputModel;
}



@end
