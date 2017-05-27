//
//  YFStudentListDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

#import "Gym.h"

#import "YFFilterOtherModel.h"

@interface YFStudentListDataModel : YFDataBaseModel

@property(nonatomic,copy)NSString *searchStr;
@property(nonatomic,copy)NSString *allMemNum;


@property(nonatomic,strong)Gym *gym;
// 所有数据 字母排序
@property(nonatomic,strong)NSMutableArray *allSectionLetterFilterdataArray;
@property(nonatomic,strong)NSMutableArray *sortTimeArray;
@property(nonatomic,strong)NSArray *allLetterKeys;


@property(nonatomic,strong)NSMutableArray *showLetterFilterdataArray;
@property(nonatomic,strong)NSMutableArray *showSortTimeArray;
@property(nonatomic,strong)NSMutableArray *showLetterKeys;


@property(nonatomic,strong)NSMutableArray *searchResultArray;


@property(nonatomic,strong)NSMutableArray *isShowIngArray;


@property(nonatomic, strong)YFFilterOtherModel *fiterOtherModel;



- (void)setSearchStr:(NSString *)searchStr isLetterSort:(BOOL )isLetter;


-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym filterModel:(YFFilterOtherModel *)filterModel successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)setTimeArraySorted;

@end
