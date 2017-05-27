//
//  TestShowController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/2.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "BodyTest.h"

@interface TestShowController : MOViewController

@property(nonatomic,strong)BodyTest *bodyTest;

@property(nonatomic,copy)void(^editFinish)();

@end
