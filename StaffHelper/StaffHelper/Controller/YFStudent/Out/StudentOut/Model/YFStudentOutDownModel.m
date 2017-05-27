//
//  YFStudentOutDownModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentOutDownModel.h"

#import "YFStudentFollowingCell.h"

static NSString *yFStudentFollowingCell = @"YFStudentFollowingCell";


@implementation YFStudentOutDownModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFollowingCell;
        self.cellClass = [YFStudentFollowingCell class];
        self.cellHeight = 56.0;
        
        self.edgeInsets = UIEdgeInsetsMake(0, 18.0, 0.0, 0.0);
        
    }
    return self;
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentFollowingCell *cell = (YFStudentFollowingCell *)baseCell;
    cell.stateImageView.layer.cornerRadius = cell.stateImageView.width / 2.0;
    cell.stateImageView.layer.masksToBounds = YES;
    
    if ([self.status isEqualToString:@"1"]){
        cell.nameLabel.text = @"缺勤统计";
        cell.stateImageView.backgroundColor = RGB_YF(234, 97, 97);
        
    }else if ([self.status isEqualToString:@"2"]){
        cell.nameLabel.text = @"出勤排行";
        cell.stateImageView.backgroundColor = RGB_YF(13, 177, 75);
    }
}

@end
