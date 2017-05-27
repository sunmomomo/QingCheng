//
//  YFSellerDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"
#import "Gym.h"
#import "YFRespoDataArrayModel.h"
#import "YFSellerModel.h"

@interface YFSellerDataModel : YFDataBaseModel

@property(nonatomic, assign)NSUInteger page;

@property(nonatomic, strong)YFSellerModel *allModel;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)YFRespoDataArrayModel *dataMOdel;

@property(nonatomic,strong)NSMutableArray *showDataArray;


-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym isHaveAllSeller:(BOOL)isHaveAllSeller successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


@end
