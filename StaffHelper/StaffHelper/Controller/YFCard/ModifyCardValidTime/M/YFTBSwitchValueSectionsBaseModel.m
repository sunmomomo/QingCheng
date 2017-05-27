//
//  YFTBSwitchValueSectionsBaseModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSwitchValueSectionsBaseModel.h"

@implementation YFTBSwitchValueSectionsBaseModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.dataArray addObject:self.switModel];
    }
    return self;
}


- (NSUInteger)sectionCount
{
    if (self.switModel.on == NO) {
     
        return 1;
    }
    return self.dataArray.count;
}



- (YFDesSwitchCModel *)switModel
{
    if (_switModel == nil)
    {
        weakTypesYF
        _switModel =[YFDesSwitchCModel defaultWithYYModelDic:nil selectBlock:^(id model){
//            if (weakS.switModel.on == NO) {
//                weakS.switModel.edgeInsets  = UIEdgeInsetsMake(0,0, 0, 0);
//            }else
//            {
//                weakS.switModel.edgeInsets  = UIEdgeInsetsMake(0,15, 0, 15);
//            }

            [weakS changedSwith:weakS.switModel];
            [weakS.weakTableView reloadSections:[NSIndexSet indexSetWithIndex:weakS.indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    return _switModel;
}

- (void)changedSwith:(id)model
{
    
}


@end
