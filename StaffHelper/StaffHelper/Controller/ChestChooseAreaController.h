//
//  ChestChooseAreaController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "ChestArea.h"

@interface ChestChooseAreaController : MOViewController

@property(nonatomic,strong)ChestArea *area;

@property(nonatomic,copy)void(^chooseFinish)(ChestArea *area);

@end
