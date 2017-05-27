//
//  CoachUserBatchEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSellerFilterBaseVC.h"

#import "Gym.h"

#import "StudentListInfo.h"

#import "MOTableView.h"

#import "UserChooseView.h"
@interface CoachUserBatchEditController : YFSellerFilterBaseVC

@property(nonatomic,strong)StudentListInfo *info;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UserChooseView *chooseView;

@property(nonatomic,strong)NSMutableArray *chooseArray;

@property(nonatomic, assign)BOOL isChooseStudent;

@property(nonatomic, copy)void(^chooseStudentsBlock)(NSMutableArray *);

/**
 * YES 展示已选中的View
 */
@property(nonatomic, assign)BOOL isShowSelectView;

-(void)checkFunc;
@end
