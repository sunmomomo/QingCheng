//
//  YFAbsenceStaticCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAbsenceStaticCModel.h"

#import "YFAbsenceStaticCell.h"

#import "UIActionSheet+YFAdditions.h"

#import "YYModel.h"

#import "StudentDetailController.h"

static NSString *yFAbsenceStaticCell = @"YFAbsenceStaticCell";

@interface YFAbsenceStaticCModel ()<YYModel>

@end

@implementation YFAbsenceStaticCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFAbsenceStaticCell;
        self.cellClass = [YFAbsenceStaticCell class];
        self.cellHeight = 161;
        
        self.edgeInsets = UIEdgeInsetsMake(0, 82, 0, 0);
        
//        self.track_record = [self.track_record guardStringYF];
//        self.join_atNoMInu = [self.join_atNoMInu guardStringYF];
//        self.phone = [self.phone guardStringYF];
//        self.gender = [self.gender guardStringYF];
//        self.username = [self.username guardStringYF];
//        self.status = [self.status guardStringYF];
//        self.first_card_info = [self.first_card_info guardStringYF];
        
        //
        weakTypesYF
        [self setPhoneActionBlock:^{
            [weakS setPhoneAction:nil];
        }];
        
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
//    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFAbsenceStaticCell *cell = (YFAbsenceStaticCell *)baseCell;
    cell.phoneActionBlock = self.phoneActionBlock;
    NSString *nameStr = self.username;
    BOOL isfemale = self.gender.integerValue;
//    NSString *firstStr = @"最后出勤";
//    NSString *SecondStr = @"TotalGame 娜娜";
//    
//    NSString *threeStr = @"2016-09-16 10:00-9:00";
//    
//    nameStr = @"牛超超";
//    NSString *daySstr = @"345";
//    self.phone = @"18311436234";
//    cell.headImageView.backgroundColor = [UIColor purpleColor];
    
    NSString *firstStr = @"最后出勤";
    NSString *SecondStr = self.title;
    
    NSString *threeStr = self.date_and_time;
    
    nameStr = self.username;
    NSString *daySstr = self.absence;
    self.phone = self.phone;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar]];

    cell.grayDaysLabel.text = daySstr;

    cell.grayFirstLabel.text = firstStr;
    cell.graySecondLabel.text = SecondStr;
    cell.grayThreeabel.text = threeStr;
    
    cell.nameLabel.text = nameStr;
    CGSize size = YF_MULTILINE_TEXTSIZE(nameStr, cell.nameLabel.font, CGSizeMake(150, cell.nameLabel.height), 0);
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
}



- (void)setPhoneAction:(UIButton *)button
{
    NSString *desStr = [NSString stringWithFormat:@"呼叫%@",self.phone];
    
    [UIActionSheet actionSWithCallBackBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1)
        {
            // 取消
        }else if (buttonIndex == 2)
        {// 短信
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",self.phone]]];
            
        }else if (buttonIndex == 0)
        {
            // 电话
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.phone]]];
        }
        
        DebugLogYF(@"%@",@(buttonIndex));
        
    } title:@"联系会员" message:@"2" cancelButtonName:@"取消" otherButtonTitles:desStr,@"发短信",nil];
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
    return @{@"ab_id":@"id",
             @"user_id":@"user.id",
             @"avatar":@"user.avatar",
             @"gender":@"user.gender",
             @"phone":@"user.phone",
             @"username":@"user.username",
             };
}

@end
