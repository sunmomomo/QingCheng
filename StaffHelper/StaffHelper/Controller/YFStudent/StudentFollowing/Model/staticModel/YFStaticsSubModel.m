//
//  YFStaticsSubModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStaticsSubModel.h"
#import "NSObject+YFExtension.h"

@implementation YFStaticsSubModel
{
    NSString *_date;
}
- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.countValue = [[jsonDic objectForKey:@"count"] guardStringYF];
    }
    return self;
}


-(void)setDate:(NSString *)date
{
    _date = date;
    
    if (date.length > 0)
    {
    NSArray *array = [date componentsSeparatedByString:@"-"];
        if (array.count == 3)
        {
        NSMutableString *string = [NSMutableString stringWithFormat:@"%@-%@",array[1],array[2]];
       self.monthDay = string;
        }
    }
}

-(NSString *)date
{
    return [_date guardStringYF];
}
@end
