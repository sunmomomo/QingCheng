//
//  ChatMemberGroupInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatMemberGroupInfo.h"

@implementation ChatMemberGroupInfo

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    
    
}

@end
