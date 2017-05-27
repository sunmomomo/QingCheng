//
//  PositionInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Position.h"

@interface PositionInfo : NSObject

@property(nonatomic,strong)NSArray *positions;

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

-(void)requestWithGym:(Gym*)gym;

@end
