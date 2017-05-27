//
//  YFRightVCNoDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/6.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFRightVCNoDataModel.h"
#import "YFStudentFilterOriginCell.h"

static NSString *yFStudentFilterOriginCell = @"YFStudentFilterOriginCellNoData";

@implementation YFRightVCNoDataModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterOriginCell;
        self.cellClass = [YFStudentFilterOriginCell class];
        self.cellHeight = 39.0;
        self.edgeInsets = UIEdgeInsetsMake(0, XFrom6YF(14.0), 0, 0);
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)baseCell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.textColor = RGB_YF(153, 153, 153);
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentFilterOriginCell *cell = (YFStudentFilterOriginCell *)baseCell;
    cell.nameLabel.text = @"无筛选项";
    cell.arrowImageView.hidden = YES;
}

@end
