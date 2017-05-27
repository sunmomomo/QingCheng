//
//  YFDesValueCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDesValueCModel.h"

#import "YFDesValueCell.h"

static NSString *yFDesValueCell = @"YFDesValueCell";


@implementation YFDesValueCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFDesValueCell;
        self.cellClass = [YFDesValueCell class];
        self.cellHeight = 50.0;
        self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

-(void)bindCell:(YFDesValueCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.nameDesLabel.text = self.des;
    baseCell.nameAllLabel.text = self.timeStr;
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
}



@end
