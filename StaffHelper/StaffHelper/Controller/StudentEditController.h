//
//  StudentEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "StudentDetailInfo.h"

@interface StudentEditController : MOViewController

@property(nonatomic,strong)StudentDetailInfo *studentInfo;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,copy)void(^editFinish)();

@property(nonatomic,copy)void(^addFinish)();


@property(nonatomic,strong)Gym *gym;

@end
