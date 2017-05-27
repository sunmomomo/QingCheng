//
//  YFRespoDataArrayYYModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFRespoDataArrayYYModel.h"

@implementation YFRespoDataArrayYYModel

-(void)resultArray:(NSArray *)listArray
{
    if ([listArray isKindOfClass:[NSArray class]] == NO)
    {
        return;
    }
    if (!self.modelClass) {
        self.listArray = (NSMutableArray *)listArray;
        return;
    }
    self.listArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in listArray)
    {
        YFBaseModel *model = [[self.modelClass alloc] initWithYYModelDictionary:dic];
        [self.listArray addObject:model];
    }
}



@end
