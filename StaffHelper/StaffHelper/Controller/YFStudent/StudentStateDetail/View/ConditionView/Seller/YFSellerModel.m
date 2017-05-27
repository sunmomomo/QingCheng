//
//  YFSellerModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSellerModel.h"
#import "NSObject+YFExtension.h"

@implementation YFSellerModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {

        if (self.s_id)
        {
        self.s_id = [NSString stringWithFormat:@"%@",self.s_id];
        }else
        {
            self.s_id = @"";
        }
        
        self.username = [self.username guardStringYF];

    }
    return self;
}
-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.s_id = value;
    }else
        [super setValue:value forKey:key];
}


- (void)setIsALl:(BOOL)isALl
{
    _isALl = isALl;
    self.username = @"全部";
    self.avatar = @"AllSeller";
}

- (void)setIsNoSelle:(BOOL)isNoSelle
{
    _isNoSelle = isNoSelle;
    self.username = @"未分配销售";
    self.s_id = @"0";
    self.avatar = @"noSeller";
}


@end
