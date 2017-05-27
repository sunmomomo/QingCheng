//
//  ChatMemberGroupModel.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface ChatMemberGroupModel : NSObject

@property(nonatomic,assign)BOOL showing;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,strong)NSMutableArray *users;

@end
