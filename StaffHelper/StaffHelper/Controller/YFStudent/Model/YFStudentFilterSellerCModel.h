//
//  YFStudentFilterSellerCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFSellerModel.h"

@interface YFStudentFilterSellerCModel : YFBaseCModel

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)NSDictionary *param;

@property(nonatomic, assign)BOOL isShowAll;

@property(nonatomic,strong)YFSellerModel *selelctModel;

- (void)setUnSelectSellerModel;
@end
