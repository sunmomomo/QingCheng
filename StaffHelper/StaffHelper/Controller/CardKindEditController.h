//
//  CardKindEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "CardKindInfo.h"

@interface CardKindEditController : MOViewController

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,copy)void(^editFinish)();

@property(nonatomic,strong)CardKind *cardKind;

@end
