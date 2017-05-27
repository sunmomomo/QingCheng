//
//  ChatMemberGroupInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChatMemberGroupModel.h"

@interface ChatMemberGroupInfo : NSObject

@property(nonatomic,strong)NSMutableArray *groups;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
