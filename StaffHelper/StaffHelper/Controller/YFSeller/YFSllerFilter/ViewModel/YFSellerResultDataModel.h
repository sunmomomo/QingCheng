//
//  YFSellerResultDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

@interface YFSellerResultDataModel : YFDataBaseModel

// 选择会员，暂时在群发短信 时用，搜索全部会员
@property(nonatomic, assign)BOOL isChooseStudent;

@property(nonatomic,copy)NSString *searchStr;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, assign)BOOL isLoading;
@property(nonatomic, assign)BOOL isSuccess;

-(void)getResponseDatashowLoadingOn:(UIView *)superView Seller:(Seller *)seller andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getAddSellerResponseDatashowLoadingOn:(UIView *)superView Seller:(Seller *)seller andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getResponseDatashowLoadingOn:(UIView *)superView Coach:(Coach *)coach andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(void)getAddCoachResponseDatashowLoadingOn:(UIView *)superView Coach:(Coach *)coach andGym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
