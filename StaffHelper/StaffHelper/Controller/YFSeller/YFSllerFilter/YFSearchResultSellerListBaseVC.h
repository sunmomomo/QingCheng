//
//  YFSearchResultSellerListBaseVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "MOTableView.h"

@interface YFSearchResultSellerListBaseVC : MOViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, copy)NSString *searchStr;

@property(nonatomic,strong)MOTableView *tableView;


- (void)changeToFrame:(CGRect)frame;

@property(nonatomic,strong)Seller *seller;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Gym *gym;

- (instancetype)initWithFrame:(CGRect)frame;

@property(nonatomic,strong)NSArray *users;

- (void)creatUI;

- (void)setTableFootviewLabelNum:(NSInteger )count;

- (void)creatData;

- (NSMutableArray *)dealArray:(NSMutableArray *)array searStr:(NSString *)searStr;
@end
