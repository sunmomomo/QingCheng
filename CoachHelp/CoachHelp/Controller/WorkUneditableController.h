//
//  WorkUneditableController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Work.h"

@interface WorkUneditableController : MOViewController

@property(nonatomic,copy)void(^editFinish)(Work *work);

@property(nonatomic,strong)Work *work;

@end
