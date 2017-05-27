//
//  YFRespoDataOriginArrayModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFRespoDataOriginArrayModel.h"

@implementation YFRespoDataOriginArrayModel


-(instancetype)initWithDictionary:(NSDictionary *)jsonDic modelClass:(Class)modelClass
{
    self = [super initWithDictionary:jsonDic modelClass:modelClass];
    if (self)
    {
        self.dic = jsonDic;
        
        NSArray *userS;
        
        if ([jsonDic isKindOfClass:[NSArray class]]) {
            userS = (NSArray *)jsonDic;
        }else
            userS = [jsonDic objectForKey:@"origins"];
//        userS = @[@{@"id":@"1",@"name":@"活动了活动了"},@{@"id":@"3",@"name":@"活动了活动了"},@{@"id":@"5",@"name":@"活动了活动了"},@{@"id":@"4",@"name":@"活动了活动了"},@{@"id":@"10",@"name":@"活动了活动了"},@{@"id":@"6",@"name":@"活动了活动了"},@{@"id":@"7",@"name":@"活动了活动了"}];
        
        [self resultArray:userS];
        
    }
    return self;
}







@end
