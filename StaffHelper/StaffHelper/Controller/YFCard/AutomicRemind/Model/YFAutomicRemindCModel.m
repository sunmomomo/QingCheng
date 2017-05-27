//
//  YFAutomicRemindCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAutomicRemindCModel.h"

#import "YFAutomicRemindCell.h"

#import "YFAutomicRemindCell.h"

#import "YYModel.h"

static NSString *yFAutomicRemindCell = @"YFAutomicRemindCell";

@interface YFAutomicRemindCModel ()<YYModel>

@end

@implementation YFAutomicRemindCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFAutomicRemindCell;
        self.cellClass = [YFAutomicRemindCell class];
        self.cellHeight = IPhone4_5_6_6P(66, 66, XFrom5To6YF(66), XFrom5To6YF(66));
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFAutomicRemindCell *cell = (YFAutomicRemindCell *)self.weakCell;
    
    cell.nameLabel.text = self.title;
    
    cell.desLabel.text = self.desName;
    
    if (self.isOpen)
    {
        cell.valueLabel.text = self.valueString;
        cell.valueLabel.textColor = RGB_YF(13, 177, 75);
    }else
    {
        cell.valueLabel.text = @"已关闭";
        cell.valueLabel.textColor = RGB_YF(234, 97, 97);
    }
    
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"re_id":@"id"};
}

@end
