//
//  YFStudentBaseViewModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"


@interface YFStudentBaseViewModel : YFDataBaseModel

@property(nonatomic, strong)NSMutableArray *dataArray;


@property(nonatomic, copy)NSString *send;

@property(nonatomic, copy)NSString *content;

@property(nonatomic, copy)NSString *message_id;

/**
 * YES 有收件人 NO 没有收件人
 */
- (BOOL)setChooseArrayForIds:(NSArray *)array;


- (void)sendSMSDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;
- (void)updateSMSDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


@end
