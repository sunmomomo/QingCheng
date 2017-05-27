//
//  SummaryController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface SummaryController : MOViewController

@property(nonatomic,copy)NSString *placeholder;

@property(nonatomic,strong)NSString *text;

@property(nonatomic,copy)void(^summaryFinish)(NSString *summary);

@end
