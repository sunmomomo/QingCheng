//
//  StudentDetailController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Student.h"

@interface StudentDetailController : MOViewController

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)Gym *gym;

// 跳往 第几个 Tab项, 0 开始
@property(nonatomic,assign)NSUInteger selectIndex;


@property(nonatomic,copy)void(^editFinish)();


-(void)reloadStuInfo;

@end
