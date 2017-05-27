//
//  WorkEditController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Work.h"

@interface WorkEditController : MOViewController

@property(nonatomic,strong)Work *work;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,copy)void(^editFinish)(Work *work);

@end
