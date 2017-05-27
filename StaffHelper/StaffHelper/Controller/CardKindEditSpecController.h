//
//  CardKindEditSpecController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Spec.h"

@interface CardKindEditSpecController : MOViewController

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,strong)Spec *spec;

@property(nonatomic,copy)void(^editFinish)();

@end
