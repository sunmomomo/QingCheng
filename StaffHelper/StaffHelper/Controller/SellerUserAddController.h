//
//  SellerUserAddController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSellerFilterBaseVC.h"

#import "Seller.h"
@class UserChooseView;
@class MOTableView;
@interface SellerUserAddController : YFSellerFilterBaseVC

@property(nonatomic,strong)UserChooseView *chooseView;
@property(nonatomic,strong)MOTableView *tableView;
@property(nonatomic,strong)NSMutableArray *chooseArray;


@property(nonatomic,strong)Seller *seller;

@property(nonatomic,strong)Gym *gym;

-(void)checkFunc;

@end
