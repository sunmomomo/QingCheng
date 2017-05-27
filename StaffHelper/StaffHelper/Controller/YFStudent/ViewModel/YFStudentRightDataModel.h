//
//  YFStudentRightDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"
#import "YFRespoDataArrayModel.h"

@interface YFStudentRightDataModel : YFDataBaseModel

/**
 * "" 全部，"0"是未分配销售， 具体 id 是某个销售的分配
 */
@property(nonatomic, copy)NSString *seller_id;


@property(nonatomic,strong)NSMutableArray *reArray;

@property(nonatomic, copy)NSString *searchStr;

@property(nonatomic,strong)NSMutableArray *oriArray;

// 是否是 筛选，筛选的话，接口不一样，分 全部数据，和筛选的数据
@property(nonatomic, assign)BOOL isFilter;

@property(nonatomic,assign)NSInteger dataPage;

@property(nonatomic,assign)YFRespoDataArrayModel *searchDataModel;



-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getOriginResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

// 搜索 推荐人
-(void)getResponseSearchDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
