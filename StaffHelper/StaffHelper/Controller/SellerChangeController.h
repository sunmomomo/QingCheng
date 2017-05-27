//
//  SellerChangeController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Student.h"

#import "Seller.h"

@interface SellerChangeController : MOViewController

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,strong)Seller *seller;

@property(nonatomic,strong)Gym *gym;

/**
 * YES 只能选 销售，NO 可以选择 销售 和教练 --------- 默认 NO
 */
@property(nonatomic, assign)BOOL isCanOnlyChooseSeller;

@end
