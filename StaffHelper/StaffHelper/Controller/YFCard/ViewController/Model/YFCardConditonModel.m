//
//  YFCardConditonModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardConditonModel.h"

#import "YFCardConditionCell.h"


static NSString *yFCardConditionCell = @"YFCardConditionCell";


@implementation YFCardConditonModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFCardConditionCell;
        self.cellClass = [YFCardConditionCell class];
        self.cellHeight = XFrom5To6YF(40);
        self.edgeInsets = UIEdgeInsetsMake(0,15, 0, 15.0);
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFCardConditionCell *cell = (YFCardConditionCell *)baseCell;
    cell.changeValueBlock = self.changeValueBlock;
    cell.nameLabel.text = self.conditionName;
    cell.unitLabel.text = self.conditionUnit;
    cell.valueTF.text = self.valueStringFY;
}

-(void)valueChangeFY:(id)sender
{
    YFCardConditionCell *cell = (YFCardConditionCell *)self.weakCell;
    
    if (cell.valueTF.text.integerValue <= 0 )
    {
       cell.valueTF.text = @"";
    }
    self.valueStringFY = cell.valueTF.text;
    
//    DebugLog(@"标题%@",self.valueStringFY);
}

@end
