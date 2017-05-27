//
//  YardEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Yard.h"

#import "YardListInfo.h"

@interface YardEditController : MOViewController

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Yard *yard;

@property(nonatomic,copy)void(^editFinish)();

@end
