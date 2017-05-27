//
//  YFTagFooterModel.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFTagFooterModel.h"

#import "YFTagFooterCReusableView.h"

@implementation YFTagFooterModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        
        self.cvCellIdentifier = yFTagFooterCReusableView;
        self.cellSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 130, MSH - 170);
    }
    return self;
}




@end
