//
//  ChatMemberGymModel.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

#import "ChatMemberGroupModel.h"

@interface ChatMemberGymModel : NSObject

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,assign)NSInteger gymId;

@property(nonatomic,copy)NSString *iconURL;

@property(nonatomic,copy)NSString *brandName;

@property(nonatomic,strong)NSArray *positions;

@property(nonatomic,assign)NSInteger userCount;

@end
