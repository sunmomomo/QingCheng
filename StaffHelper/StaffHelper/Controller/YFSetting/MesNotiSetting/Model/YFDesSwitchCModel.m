//
//  YFDesSwitchCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDesSwitchCModel.h"

#import "YFDesSwitchCell.h"

static NSString *yFDesSwitchCell = @"YFDesSwitchCell";


@implementation YFDesSwitchCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFDesSwitchCell;
        self.cellClass = [YFDesSwitchCell class];
        self.cellHeight = Width320(40);
        self.edgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        self.isCanTurnOffDateSwitch = YES;
    }
    return self;
}

- (void)setCell:(YFDesSwitchCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.desTextColor)
    {
        baseCell.desLabel.textColor = self.desTextColor;
    }
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFDesSwitchCell *cell = (YFDesSwitchCell *)baseCell;
    cell.changeValueBlock = self.changeValueBlock;
    cell.switchOfCell.enabled = self.isCanTurnOffDateSwitch;
    if (self.isCanTurnOffDateSwitch == NO)
    {
    cell.switchOfCell.on = YES;
    }else
    {
           cell.switchOfCell.on = self.on;
    }
    cell.desLabel.text = self.des;
 
}

-(void)valueChangeFY:(id)sender
{
    YFDesSwitchCell *cell = (YFDesSwitchCell *)self.weakCell;
    
    NSLog(@"switch:%d",cell.switchOfCell.on);
    
    self.on = cell.switchOfCell.on;
    
    if (self.selectBlock) {
        self.selectBlock(self);
    }
    
    
    //    DebugLog(@"标题%@",self.valueStringFY);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
}


@end
