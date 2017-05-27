//
//  EditTestController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/2.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "BodyTest.h"

#import "BodyTestInfo.h"

@interface EditTestController : MOViewController

@property(nonatomic,strong)Student *stu;

@property(nonatomic,strong)BodyTestInfo *testInfo;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,copy)void(^editFinish)(BodyTestInfo *testInfo);

@property(nonatomic,copy)void(^deleteTest)();

@end
