//
//  YFUserAttendanceModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFUserAttendanceModel.h"

#import "YYModel.h"

#import "YFUserAttendanceCell.h"

#import "YFAttendanceVaueBaseModel.h"

static NSString *yFUserAttendanceCell = @"YFUserAttendanceCell";



@interface YFUserAttendanceModel ()<YYModel>

// 从右 开始数  是 第一个
@property(nonatomic, strong)YFAttendanceVaueBaseModel *firstModel;
@property(nonatomic, strong)YFAttendanceVaueBaseModel *secondModel;
@property(nonatomic, strong)YFAttendanceVaueBaseModel *thirdModel;
@property(nonatomic, strong)YFAttendanceVaueBaseModel *forthModel;

@end



@implementation YFUserAttendanceModel

- (void)cellSettingYF
{
    self.cellIdentifier = yFUserAttendanceCell;
    self.cellClass = [YFUserAttendanceCell class];
    self.cellHeight = Width(64);
    
    self.edgeInsets = UIEdgeInsetsMake(0, Width(40), 0, 0);
}
- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFUserAttendanceCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    [baseCell.headImageView sd_setImageWithURL:self.avatar];
    baseCell.nameLabel.text = self.username;
    
    [self checkModel];
    
   
    [self setModel:self.firstModel view:baseCell.thirdView];
    [self setModel:self.secondModel view:baseCell.secondView];
    [self setModel:self.thirdModel view:baseCell.firstView];
    [self setModel:self.forthModel view:baseCell.rightView];
}

-(void)setModel:(YFAttendanceVaueBaseModel *)model view:(YFThreeLabel *)labelView
{
    if (model)
    {
        labelView.rightTopLabel.text = model.rightUnitStr;
        labelView.desDownLabel.text = model.downStr;
        [labelView setValueStr:model.valueStr];

        labelView.hidden = NO;
    }else
    {
        labelView.hidden = YES;
    }
}

- (void)checkModel
{
    NSMutableArray *array = [NSMutableArray array];
    
    if (self.private_count)
    {
        YFAttendanceVaueBaseModel *model = [[YFAttendanceVaueBaseModel alloc] init];
        model.rightUnitStr = @"节";
        model.downStr = @"私教";
        model.valueStr = self.private_count;
        [array addObject:model];
    }
    if (self.group_count)
    {
        YFAttendanceVaueBaseModel *model = [[YFAttendanceVaueBaseModel alloc] init];
        model.rightUnitStr = @"节";
        model.downStr = @"团课";
        model.valueStr = self.group_count;
        [array addObject:model];
    }
    if (self.checkin_count)
    {
        YFAttendanceVaueBaseModel *model = [[YFAttendanceVaueBaseModel alloc] init];
        model.rightUnitStr = @"次";
        model.downStr = @"签到";
        model.valueStr = self.checkin_count;

        [array addObject:model];
    }
    if (self.day_count)
    {
        YFAttendanceVaueBaseModel *model = [[YFAttendanceVaueBaseModel alloc] init];
        model.rightUnitStr = @"天";
        model.downStr = @"出勤";
        model.valueStr = self.day_count;
        [array addObject:model];
    }
    if (array.count > 0)
    {
        self.firstModel = array[0];
    }
    
    if (array.count > 1)
    {
        self.secondModel = array[1];
    }
    
    if (array.count > 2)
    {
        self.thirdModel = array[2];
    }

    if (array.count > 3)
    {
        self.forthModel = array[3];
    }
}


#pragma mark Data
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"u_id":@"user.id",
             @"username":@"user.username",
             @"gender":@"user.gender",
             @"phone":@"user.phone",
             @"avatar":@"user.avatar"
             };
}

@end
