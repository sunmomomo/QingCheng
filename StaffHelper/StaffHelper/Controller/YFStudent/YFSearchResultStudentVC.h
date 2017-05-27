//
//  YFSearchResultStudentVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

@interface YFSearchResultStudentVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, strong)UIView *tableFootView;

@property(nonatomic, strong)UILabel *tableFootLabel;

@property(nonatomic, copy)NSString *searStrDes;

@property(nonatomic,strong)Gym *gym;

- (void)hideSearchView;
- (void)showSearchView;

-(void)searchStrChangeYF:(NSString *)str;

- (void)setTableFootviewLabelNum:(NSInteger )count;

-(void)requestSearchWithStrYF:(NSString *)str;

@end
