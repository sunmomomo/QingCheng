//
//  StudentSellerController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Student.h"

@interface StudentSellerController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Student *student;

@property(nonatomic,assign)BOOL isEdit;

@property(nonatomic,copy)void(^chooseFinish)(NSArray *sellers);

@property(nonatomic,copy)void(^editFinish)();

/**
 * YES 只能选 销售，NO 可以选择 销售 和教练 --------- 默认 NO
 */
@property(nonatomic, assign)BOOL isCanOnlyChooseSeller;

@end
