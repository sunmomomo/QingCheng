
//
//  YFPayStyleModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFPayStyleModel.h"

#import "YFPayStyleCell.h"


static NSString *yFPayStyleCell = @"YFPayStyleCell";


@interface YFPayStyleModel ()


@end

@implementation YFPayStyleModel



- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFPayStyleCell;
        self.cellClass = [YFPayStyleCell class];
        self.cellHeight = Width320(64);
        self.edgeInsets  = UIEdgeInsetsMake(0,19, 0, 19);
    }
    return self;
}

- (void)setIsShowSubValue:(BOOL)isShowSubValue
{
    _isShowSubValue = isShowSubValue;
    if (isShowSubValue)
    {
        self.cellHeight = Width320(64);
    }else
    {
        self.cellHeight = Width320(40);
    }
}

- (void)setCell:(YFPayStyleCell *)baseCell toObjectFY:(NSObject *)object
{
    if (self.desColor)
    {
    baseCell.desLabel.textColor = self.desColor;
    }
    if (self.desValueColor)
    {
    baseCell.desValueLabel.textColor = self.desValueColor;
    }
    
    
}

- (void)bindCell:(YFPayStyleCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.desLabel.text = self.des;
    baseCell.desValueLabel.text = self.desValue;
    if (self.isShowSubValue)
    {
        baseCell.desSubValueLabel.hidden = NO;
        baseCell.desSubValueLabel.text = self.desSubValue;
    }else
    {
        baseCell.desSubValueLabel.text = @"";
        baseCell.desSubValueLabel.hidden = YES;
    }
    
}





@end
