//
//  YFSelectArrowCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSelectArrowCModel.h"

#import "YFSelectArrowCell.h"

static NSString *yFSelectArrowCell = @"YFSelectArrowCell";


@implementation YFSelectArrowCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
       
    }
    return self;
}

- (void)cellSettingYF
{
    self.cellIdentifier = yFSelectArrowCell;
    self.cellClass = [YFSelectArrowCell class];
    self.cellHeight = Height320(40);
    self.edgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    YFSelectArrowCell *cell = (YFSelectArrowCell *)baseCell;
    if (self.desColor) {
        cell.desLabel.textColor = self.desColor;
    }
    
    if (self.desValueColor) {
        cell.desValueLabel.textColor = self.desValueColor;
    }
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFSelectArrowCell *cell = (YFSelectArrowCell *)baseCell;
    cell.desValueLabel.text = self.desValue;
    cell.desLabel.text = self.des;
}



@end
