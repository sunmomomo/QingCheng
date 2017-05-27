//
//  YFSellerModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFSellerModel : YFBaseCModel

// 全部销售
@property(nonatomic,assign)BOOL isALl;
// 未分配销售
@property(nonatomic,assign)BOOL isNoSelle;

@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *s_id;
@property(nonatomic,copy)NSString *avatar;

@property(nonatomic,assign)BOOL isSelected;

@end
