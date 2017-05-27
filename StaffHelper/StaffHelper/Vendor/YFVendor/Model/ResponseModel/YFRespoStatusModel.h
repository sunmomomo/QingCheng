//
//  YFRespoStatusModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFRespoBaseModel.h"

#import "YFRespoDataModel.h"

@class YFHttpService;
@interface YFRespoStatusModel : YFRespoBaseModel

@property(nonatomic, weak)YFHttpService *httpService;

@property(nonatomic,strong)NSDictionary *allDataDic;

@property(nonatomic, copy)NSString *status;
@property(nonatomic, copy)NSString *info;
@property(nonatomic, copy)NSString *level;
@property(nonatomic, copy)NSString *error_code;
@property(nonatomic, copy)NSString *msg;

@property(nonatomic, strong)YFRespoDataModel *dataModel;

@property(nonatomic, assign)BOOL isSuccess;



- (void)showErrorAlertView;


@end
