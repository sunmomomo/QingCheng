//
//  ChatChooseMemberController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface ChatChooseMemberController : MOViewController

@property(nonatomic,copy)void(^chooseFinish)(NSArray *members);

@end
