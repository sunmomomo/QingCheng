//
//  ChatListModel.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatListModel.h"

@implementation ChatListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.user = [[User alloc]init];
        
    }
    return self;
}

@end
