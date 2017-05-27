//
//  YFOutRankTimeVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSliderPopViewVC.h"

#import "YFLastestTimeModel.h"

@interface YFOutRankTimeVC : YFSliderPopViewVC

@property(nonatomic, copy)void(^selectBlock)();

@property(nonatomic, strong)YFLastestTimeModel *selectModel;

@property(nonatomic, strong)NSDictionary *param;


@property(nonatomic, copy)NSString *footerDateStr;

@end
