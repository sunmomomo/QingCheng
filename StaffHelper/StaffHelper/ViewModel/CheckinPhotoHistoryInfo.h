//
//  CheckinPhotoHistoryInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CheckinPhotoHistory.h"

@interface CheckinPhotoHistoryInfo : NSObject

@property(nonatomic,strong)NSMutableArray *histories;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestDataWithStudent:(Student*)stu result:(void(^)(BOOL success,NSString *error))result;

-(void)uploadPhoto:(NSString *)photo student:(Student*)stu result:(void(^)(BOOL success,NSString *error))result;

@end
