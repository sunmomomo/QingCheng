//
//  YFRespoStudentFollowDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFRespoStudentFollowDataModel.h"
#import "NSObject+YFExtension.h"

@implementation YFRespoStudentFollowDataModel


-(instancetype)initWithDictionary:(NSDictionary *)jsonDic modelClass:(Class)modelClass
{
    self = [super initWithDictionary:jsonDic modelClass:modelClass];
    if (self)
    {
        self.created_users_count = [self.created_users_count guardStringYF];
        self.following_users_count = [self.following_users_count guardStringYF];
        self.ne_created_users_count = [self.ne_created_users_count guardStringYF];
        self.member_users_count = [self.member_users_count guardStringYF];
        self.ne_following_users_count = [self.ne_following_users_count guardStringYF];
        self.all_users_count = [self.all_users_count guardStringYF];
        self.ne_member_users_count = [self.ne_member_users_count guardStringYF];

    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"new_created_users_count"])
    {
        self.ne_created_users_count = value;
    }else if ([key isEqualToString:@"new_following_users_count"])
    {
        self.ne_following_users_count = value;
    }else if([key isEqualToString:@"new_member_users_count"]){
        self.ne_member_users_count = value;
     
    }else
        [super setValue:value forKey:key];
}


@end
