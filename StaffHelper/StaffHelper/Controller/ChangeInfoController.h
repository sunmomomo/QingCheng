//
//  ChangeInfoController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "StaffUserInfo.h"

@interface ChangeInfoController : MOViewController

@property(nonatomic,strong)StaffUserInfo *userInfo;

@property(nonatomic,copy)void(^editFinish)();

@end
