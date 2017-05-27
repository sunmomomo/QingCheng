//
//  GymURLInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymURLInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
