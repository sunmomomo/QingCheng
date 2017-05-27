//
//  YFOutRandCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFOutRandCModel.h"

#import "YFOutRandCell.h"

#import "YYModel.h"

#import "YFStudentOutRankVC.h"

#import "StudentDetailController.h"

static NSString *yFOutRandCell = @"YFOutRandCell";

@interface YFOutRandCModel ()<YYModel>

@end

@implementation YFOutRandCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFOutRandCell;
        self.cellClass = [YFOutRandCell class];
        self.cellHeight = Height320(64);
        self.edgeInsets = UIEdgeInsetsMake(0, Width320(56), 0, 0);

    }
    return self;
}
- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
//    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}


-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFOutRandCell *cell = (YFOutRandCell *)baseCell;
    YFStudentOutRankVC *rankVC = (YFStudentOutRankVC *)self.weakCell.currentVC;

    NSString *nameStr = self.username;
    BOOL isfemale = self.gender.integerValue;
    baseCell.indexPath = indexPath;
//    nameStr = @"牛超超";
//    self.phone = @"18311436234";
//    cell.headImageView.backgroundColor = [UIColor purpleColor];
   
    
    cell.nameLabel.text = nameStr;
    CGSize size = YF_MULTILINE_TEXTSIZE(nameStr, cell.nameLabel.font, CGSizeMake(Width320(80), cell.nameLabel.height), 0);
    [cell.nameLabel changeWidth:size.width + 1];
    cell.phoneLabel.text = self.phone;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar]];
    
    
    if (!isfemale)
    {
        [cell.sexImageView setImage:[UIImage imageNamed:@"sex_male"]];
    }else
    {
        [cell.sexImageView setImage:[UIImage imageNamed:@"sex_female"]];
    }
    
    [cell.sexImageView layoutIfNeeded];
    
    
    
    if ([rankVC.orderby isEqualToString:@"days"]) {
        [self setDaysStyleText];
    }else if ([rankVC.orderby isEqualToString:@"checkin"])
    {
        [self setCheckinStyleText];
    }else if ([rankVC.orderby isEqualToString:@"group"])
    {
        [self setGroupStyleText];
    }else if ([rankVC.orderby isEqualToString:@"private"])
    {
        [self setPrivateStyleText];
    }

    
//    [cell.rightView setValueStr:self.days];
//    cell.rightView.rightTopLabel.text = @"次";
//    cell.rightView.desDownLabel.text = @"出勤";
//    
//    
//    [cell.firstView setValueStr:self.checkin];
//    [cell.secondView setValueStr:self.group];
//    [cell.thirdView setValueStr:self.private_count];
    
    
    if (rankVC.isDownToTop == YES) {
        
        if (self.weakCell.indexPath.row == 0)
        {
            cell.rightView.valueMidLabel.textColor = RGB_YF(187, 187, 187);
            cell.rightView.desDownLabel.textColor = RGB_YF(153, 153, 153);
        }else if (self.weakCell.indexPath.row == 1){
            cell.rightView.valueMidLabel.textColor = RGB_YF(187, 187, 187);
            cell.rightView.desDownLabel.textColor = RGB_YF(153, 153, 153);

        }else if (self.weakCell.indexPath.row == 2){
            cell.rightView.valueMidLabel.textColor = RGB_YF(85, 85, 85);
            cell.rightView.desDownLabel.textColor = RGB_YF(153, 153, 153);

        }else
        {
            [cell.rightView setBigStyle];
            [cell.rightView setBigTextColor];
        }
        cell.rightView.rightTopLabel.textColor = RGB_YF(187, 187, 187);
    }else
    {
        if ([rankVC.orderby isEqualToString:@"days"]) {
            [self setDaysStyle];
        }else if ([rankVC.orderby isEqualToString:@"checkin"])
        {
            [self setCheckinStyle];
        }else if ([rankVC.orderby isEqualToString:@"group"])
        {
            [self setGroupStyle];
        }else if ([rankVC.orderby isEqualToString:@"private"])
        {
            [self setPrivateStyle];
        }
    }
}


#pragma mark 设置 显示字
- (void)setPrivateStyleText
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;
    
    
    [cell.rightView setValueStr:self.private_count];
    cell.rightView.desDownLabel .text = @"私教";
    cell.rightView.rightTopLabel.text = @"节";

    [cell.firstView setValueStr:self.days];
    cell.firstView.desDownLabel .text = @"出勤";
    cell.firstView.rightTopLabel.text = @"天";
    
    [cell.secondView setValueStr:self.checkin];
    cell.secondView.desDownLabel .text = @"签到";
    cell.secondView.rightTopLabel.text = @"次";
    
    [cell.thirdView setValueStr:self.group];
    cell.thirdView.desDownLabel .text = @"团课";
    cell.thirdView.rightTopLabel.text = @"节";
}

- (void)setDaysStyleText
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;

    [cell.thirdView setValueStr:self.private_count];
    cell.thirdView.desDownLabel .text = @"私教";
    cell.thirdView.rightTopLabel.text = @"节";
    
    [cell.rightView setValueStr:self.days];
    cell.rightView.desDownLabel .text = @"出勤";
    cell.rightView.rightTopLabel.text = @"天";
    
    [cell.firstView setValueStr:self.checkin];
    cell.firstView.desDownLabel .text = @"签到";
    cell.firstView.rightTopLabel.text = @"次";
    
    [cell.secondView setValueStr:self.group];
    cell.secondView.desDownLabel .text = @"团课";
    cell.secondView.rightTopLabel.text = @"节";
    
}

- (void)setCheckinStyleText
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;
    
    [cell.thirdView setValueStr:self.private_count];
    cell.thirdView.desDownLabel .text = @"私教";
    cell.thirdView.rightTopLabel.text = @"节";
    
    [cell.firstView setValueStr:self.days];
    cell.firstView.desDownLabel .text = @"出勤";
    cell.firstView.rightTopLabel.text = @"天";
    
    [cell.rightView setValueStr:self.checkin];
    cell.rightView.desDownLabel .text = @"签到";
    cell.rightView.rightTopLabel.text = @"次";
    
    [cell.secondView setValueStr:self.group];
    cell.secondView.desDownLabel .text = @"团课";
    cell.secondView.rightTopLabel.text = @"节";
    
}

- (void)setGroupStyleText
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;
    
    [cell.thirdView setValueStr:self.private_count];
    cell.thirdView.desDownLabel .text = @"私教";
    cell.thirdView.rightTopLabel.text = @"节";
    
    [cell.firstView setValueStr:self.days];
    cell.firstView.desDownLabel .text = @"出勤";
    cell.firstView.rightTopLabel.text = @"天";
    
    [cell.secondView setValueStr:self.checkin];
    cell.secondView.desDownLabel .text = @"签到";
    cell.secondView.rightTopLabel.text = @"次";
    
    [cell.rightView setValueStr:self.group];
    cell.rightView.desDownLabel .text = @"团课";
    cell.rightView.rightTopLabel.text = @"节";
    
}
#pragma mark 设置 显示字颜色
- (void)setPrivateStyle
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;

    if (self.weakCell.indexPath.row == 0)
    {
        cell.rightView.valueMidLabel.textColor = RGB_YF(80, 97, 200);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 1){
        cell.rightView.valueMidLabel.textColor = RGB_YF(138, 149, 217);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 2){
        cell.rightView.valueMidLabel.textColor = RGB_YF(183, 190, 236);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else
    {
        [cell.rightView setBigStyle];
        [cell.rightView setBigTextColor];
    }
}

- (void)setDaysStyle
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;
    
    if (self.weakCell.indexPath.row == 0)
    {
        cell.rightView.valueMidLabel.textColor = RGB_YF(249, 96, 30);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 1){
        cell.rightView.valueMidLabel.textColor = RGB_YF(252, 158, 0);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 2){
        cell.rightView.valueMidLabel.textColor = RGB_YF(251, 200, 34);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else
    {
        [cell.rightView setBigStyle];
        [cell.rightView setBigTextColor];
    }
    
}

- (void)setCheckinStyle
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;
    
    if (self.weakCell.indexPath.row == 0)
    {
        cell.rightView.valueMidLabel.textColor = RGB_YF(1, 166, 190);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 1){
        cell.rightView.valueMidLabel.textColor = RGB_YF(112, 203, 216);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 2){
        cell.rightView.valueMidLabel.textColor = RGB_YF(132, 215, 227);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else
    {
        [cell.rightView setBigStyle];
        [cell.rightView setBigTextColor];
    }
    
}

- (void)setGroupStyle
{
    YFOutRandCell *cell = (YFOutRandCell *)self.weakCell;
    
    if (self.weakCell.indexPath.row == 0)
    {
        cell.rightView.valueMidLabel.textColor = RGB_YF(8, 165, 240);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 1){
        cell.rightView.valueMidLabel.textColor = RGB_YF(84, 194, 240);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else if (self.weakCell.indexPath.row == 2){
        cell.rightView.valueMidLabel.textColor = RGB_YF(144, 210, 238);
        cell.rightView.desDownLabel.textColor = cell.rightView.valueMidLabel.textColor;
        cell.rightView.rightTopLabel.textColor = cell.rightView.valueMidLabel.textColor;
    }else
    {
        [cell.rightView setBigStyle];
        [cell.rightView setBigTextColor];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    StudentDetailController *svc = [[StudentDetailController alloc]init];
    
    Student *stu = [[Student alloc]init];
    svc.student = stu;

    stu.stuId = [self.user_id integerValue];
    stu.name = self.username;
    stu.phone = self.phone;
    stu.avatar = [NSURL URLWithString:self.avatar];
    stu.sex = [self.gender integerValue]?SexTypeWoman:SexTypeMan;
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).student = svc.student;
    
    if (AppGym) {
        
        svc.gym = ((AppDelegate *)[UIApplication sharedApplication].delegate).gym;
    }
    [self.weakCell.currentVC.navigationController pushViewController:svc animated:YES];

}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"user_id":@"user.id",
             @"avatar":@"user.avatar",
             @"gender":@"user.gender",
             @"phone":@"user.phone",
             @"username":@"user.username",
             };
}

@end
