//
//  YFRespoDataArrayModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFRespoDataModel.h"

@interface YFRespoDataArrayModel : YFRespoDataModel

@property(nonatomic, copy)NSString *pages;
@property(nonatomic, copy)NSString *total_count;
@property(nonatomic, copy)NSString *current_page;


@property(nonatomic, copy)NSString *arrayKey;

@property(nonatomic, copy)NSString *exArrayKey;// YYModel 解析

@property(nonatomic, copy)NSString *exDicKey;// YYModel 解析

@property(nonatomic, strong)NSMutableArray *listArray;
@property(nonatomic, strong)NSDictionary *exDic;


@property(nonatomic, strong)YFBaseModel *exDicModel;



-(void)resultArray:(NSArray *)listArray;

@end

