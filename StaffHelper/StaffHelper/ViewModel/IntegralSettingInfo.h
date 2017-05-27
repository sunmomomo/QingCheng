//
//  IntegralSettingInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IntegralSetting.h"

@interface IntegralSettingInfo : NSObject

@property(nonatomic,strong)IntegralSetting *setting;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)requestBasicResult:(void(^)(BOOL success,NSString *error))result;

-(void)requestAwardResult:(void(^)(BOOL success,NSString *error))result;

-(void)uploadBasicSetting:(IntegralSetting*)setting result:(void(^)(BOOL success,NSString *error))result;

-(void)uploadAward:(IntegralAwardSetting*)award result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteAward:(IntegralAwardSetting*)award result:(void(^)(BOOL success,NSString *error))result;

-(void)changeUsed:(BOOL)used result:(void(^)(BOOL success,NSString *error))result;

@end
