//
//  YFStuAbsenceFilterTimeModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStuAbsenceFilterTimeModel.h"

#import "YFStudentFilterOriginCell.h"

#import "YFAbsenceStaTimeVC.h"

static NSString *yFStudentFilterOriginCell = @"YFStudentFilterOriginCell";

@implementation YFStuAbsenceFilterTimeModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterOriginCell;
        self.cellClass = [YFStudentFilterOriginCell class];
        self.cellHeight = 46;
        self.edgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)baseCell;

    [cell fitHeight:self.cellHeight];
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    NSString *nameStr = self.name;
    
    YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)baseCell;
    
    cell.nameLabel.text = nameStr;
    
    [self setSelectState];
}


- (void)setSelectState
{
    YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)self.weakCell;
    
    
    if (!self.isSelected)
    {
        cell.arrowImageView.hidden = YES;
        cell.nameLabel.textColor = YFCellTitleColor;
    }else
    {
        cell.arrowImageView.hidden = NO;
        cell.nameLabel.textColor = YFSelectedButtonColor;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    YFAbsenceStaTimeVC *rightVC = (YFAbsenceStaTimeVC *)self.weakCell.currentVC;

    if ([self.name isEqualToString:@"自定义"])
    {
        [rightVC showRightView];
        return;
    }
        self.isSelected = YES;
        [self setSelectState];
        
        [rightVC setFilterTimeModel:self];
}



@end
