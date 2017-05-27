//
//  YFTBSwitchValueSectionsBaseModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsModel.h"

#import "YFDesSwitchCModel.h"

@interface YFTBSwitchValueSectionsBaseModel : YFTBSectionsModel

@property(nonatomic, strong)YFDesSwitchCModel *switModel;

- (void)changedSwith:(id)model;

@end
