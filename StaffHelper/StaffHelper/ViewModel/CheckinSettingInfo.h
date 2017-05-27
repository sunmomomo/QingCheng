//
//  CheckinSettingInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardKind.h"

@interface CheckinSettingInfo : NSObject

@property(nonatomic,strong)NSMutableArray *cardKinds;

@property(nonatomic,assign)BOOL autoChest;

@property(nonatomic,assign)BOOL autoReturn;

@property(nonatomic,assign)BOOL openCheckin;

@property(nonatomic,assign)NSInteger checkinId;

@property(nonatomic,assign)NSInteger checkoutId;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestUsedResult:(void(^)(BOOL success,NSString *error))result;

-(void)requestSettingResult:(void(^)(BOOL success,NSString *error))result;

-(void)editSettingResult:(void(^)(BOOL success,NSString *error))result;

-(void)requestCardKindsResult:(void(^)(BOOL success,NSString *error))result;

-(void)editCardKindsResult:(void(^)(BOOL success,NSString *error))result;

-(void)changeCheckinUsed:(BOOL)used result:(void(^)(BOOL success,NSString *error))result;

@end
