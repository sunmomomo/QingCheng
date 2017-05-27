//
//  WorkDetailController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Work.h"

@interface WorkDetailController : MOViewController

@property(nonatomic,strong)Work *work;

@property(nonatomic,copy)void(^editFinish)();

@end
