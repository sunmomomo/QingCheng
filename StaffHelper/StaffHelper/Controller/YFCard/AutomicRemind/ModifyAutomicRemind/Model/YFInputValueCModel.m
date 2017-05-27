//
//  YFInputValueCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFInputValueCModel.h"

#import "YFInputValueCell.h"

static NSString *yFInputValueCell = @"YFInputValueCell";


@implementation YFInputValueCModel


- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFInputValueCell;
        self.cellClass = [YFInputValueCell class];
        self.cellHeight = XFrom5To6YF(40);
        self.edgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
    }
    return self;
}

- (void)setScaleHeight
{
    self.cellHeight = Width320(40);
}

- (void)setCell:(YFInputValueCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.conditionTextColor)
    {
        baseCell.nameLabel.textColor = self.conditionTextColor;
    }
}
-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFInputValueCell *cell = (YFInputValueCell *)baseCell;
    
    
    CGSize size = YF_MULTILINE_TEXTSIZE(self.conditionName, cell.nameLabel.font, CGSizeMake(MSW / 1.5, cell.nameLabel.height), 0);
    CGFloat width = size.width + 1;
    cell.nameLabel.frame = CGRectMake(19, 0.0, width, XFrom5To6YF(40));
    cell.valueTF.frame = CGRectMake(cell.nameLabel.right + 5, 0, MSW - cell.nameLabel.right - 19 , XFrom5To6YF(40));

    cell.changeValueBlock = self.changeValueBlock;
    cell.nameLabel.text = self.conditionName;
    cell.valueTF.text = self.valueStringFY;
}

-(void)valueChangeFY:(id)sender
{
    YFInputValueCell *cell = (YFInputValueCell *)self.weakCell;
    
    if (cell.valueTF.text.integerValue <= 0 )
    {
        cell.valueTF.text = @"";
    }
    self.valueStringFY = cell.valueTF.text;
    
    if (self.changeValueTYF) {
        self.changeValueTYF(self.valueStringFY);
    }
    //    DebugLog(@"标题%@",self.valueStringFY);
}

@end
