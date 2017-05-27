//
//  YFBaseInputValueCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseInputValueCModel.h"

@implementation YFBaseInputValueCModel

-(void (^)(id))changeValueBlock
{
    if (_changeValueBlock == nil)
    {
        __weak typeof(self)weakS = self;
        [self setChangeValueBlock:^(id sender) {
            [weakS valueChangeFY:sender];
        }];
    }
    return _changeValueBlock;
}

-(void)valueChangeFY:(id)sender
{
    
}

@end
