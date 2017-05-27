//
//  GymSyncInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymSyncInfo : NSObject

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
