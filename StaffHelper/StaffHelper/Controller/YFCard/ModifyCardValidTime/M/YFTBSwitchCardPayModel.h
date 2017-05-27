//
//  YFTBSwitchCardPayModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSwitchValueSectionsBaseModel.h"

#import "YFInputValueCModel.h"

#import "YFPayStyleModel.h"

#import "CardPayChooseView.h"

@interface YFTBSwitchCardPayModel : YFTBSwitchValueSectionsBaseModel

@property(nonatomic, strong)YFInputValueCModel *inputModel;

@property(nonatomic, strong)YFPayStyleModel *payModel;

@property(nonatomic,strong)CardPayChooseView *cardView;

@property(nonatomic,assign)PayWay payWay;

@end
