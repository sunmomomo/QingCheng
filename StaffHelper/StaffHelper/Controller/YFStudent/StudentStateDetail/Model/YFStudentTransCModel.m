//
//  YFStudentTransCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentTransCModel.h"

#import "YFStudentTransCell.h"
#import "YFAppService.h"

#import "UIActionSheet+YFAdditions.h"
#import "StudentDetailController.h"
#import "YFSearchResultStudentStateVC.h"
#import "YFStudentStateDetailVC.h"
#import "YFStudentListVC.h"

static NSString *yFStudentTransCell = @"YFStudentTransCell";

@implementation YFStudentTransCModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentTransCell;
        self.cellClass = [YFStudentTransCell class];
        self.cellHeight = 175;
        
        self.track_record = [self.track_record guardStringYF];
        self.join_atNoMInu = [self.join_atNoMInu guardStringYF];
        self.phone = [self.phone guardStringYF];
        self.gender = [self.gender guardStringYF];
        self.username = [self.username guardStringYF];
        self.status = [self.status guardStringYF];
        self.first_card_info = [self.first_card_info guardStringYF];
        
        self.edgeInsets = UIEdgeInsetsMake(0, 82, 0, 0);
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.sta_id = value;
    }else
    {
        [super setValue:value forKey:key];
    }
}

- (NSString *)join_atNoMInu
{
    if (!_join_atNoMInu) {
        NSArray *array = [_joined_at componentsSeparatedByString:@"T"];
        if (array.count > 0)
        {
            _join_atNoMInu = array[0];
        }
    }
    return _join_atNoMInu;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentTransCell *cell = (YFStudentTransCell *)baseCell;
    NSString *nameStr = self.username;
    BOOL isfemale = self.gender.integerValue;
    NSUInteger state = self.status.integerValue;
    NSString *firstStr = [self firstStrYF];
    NSString *SecondStr = [self secondStrYF];
    
    
    CGSize maxSize = CGSizeMake(cell.grayFirstLabel.width, 10000);
    
    CGSize firstSize = YF_MULTILINE_TEXTSIZE(firstStr, cell.grayFirstLabel.font, maxSize, 0);
    CGSize secondSize = YF_MULTILINE_TEXTSIZE(SecondStr, cell.graySecondLabel.font, maxSize, 0);
    
    CGFloat firstHeight = firstSize.height + 8.0;
    if (firstStr.length == 0) {
        firstHeight = 0;
    }
    CGFloat secondHeight = secondSize.height + 8.0;
    if (SecondStr.length == 0) {
        secondHeight = 0;
    }
    
    cell.grayFirstLabel.frame = CGRectMake(cell.grayFirstLabel.mj_x, 6, cell.grayFirstLabel.width, firstHeight);
    cell.graySecondLabel.frame = CGRectMake(cell.grayFirstLabel.mj_x, cell.grayFirstLabel.bottom, cell.grayFirstLabel.width, secondHeight);
    
    if (firstHeight==0 && secondHeight == 0)
    {
        [cell.grayView changeHeight:0.0];
        cell.grayView.hidden = YES;
    }else
    {
        cell.grayView.hidden = NO;
        [cell.grayView changeHeight:cell.graySecondLabel.bottom + 8];
    }
    
    
    self.cellHeight = cell.grayView.bottom + 15.0;
    
    cell.grayFirstLabel.text = firstStr;
    cell.graySecondLabel.text = SecondStr;
    
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
    
    if (state == YFIsNewRe.integerValue)
    {
        cell.stateLabel.text = @"新注册";
        cell.stateImageView.image = [UIImage imageNamed:@"OvalNew"];
    }else if (state == YFIsFollowing.integerValue){
        cell.stateLabel.text = @"已接洽";
        
        cell.stateImageView.image = [UIImage imageNamed:@"Ovaling"];
        
    }else if (state == YFIsMember.integerValue){
        
        cell.stateLabel.text = @"会员";
        cell.stateImageView.image = [UIImage imageNamed:@"OvalMe"];
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
    
    YFStudentStateDetailVC *stateVC = (YFStudentStateDetailVC *)self.weakCell.currentVC;
    
    NSString *status =stateVC.status;
    
    StudentDetailController *svc = [[StudentDetailController alloc]init];
    
    if (status.integerValue == 0)
    {
        svc.selectIndex = 3;
    }else if (status.integerValue == 1)
    {
        svc.selectIndex = 2;
    }else
    {
        svc.selectIndex = 1;
    }
    
    Student *stu = [[Student alloc]init];
    
    stu.stuId = [self.sta_id integerValue];
    
    stu.name = self.username;
    
    stu.phone = self.phone;
    stu.avatar = [NSURL URLWithString:self.avatar];
    //    stu.photo = [NSURL URLWithString:self.checkin_avatar];
    stu.sex = [self.gender integerValue]?SexTypeWoman:SexTypeMan;
    
    stu.createDate = self.joined_at;
    stu.type = self.status.integerValue;
    //    stu.remarks = self.
    
    svc.student = stu;
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).student = svc.student;
    
    if (AppGym) {
        
        svc.gym = ((AppDelegate *)[UIApplication sharedApplication].delegate).gym;
        
    }
    
    [self.weakCell.currentVC.navigationController pushViewController:svc animated:YES];
}


- (NSString *)sellersString
{
    if (!_sellersString)
    {
        NSMutableString *string = [[NSMutableString alloc] init];
        self.sellers = [self.sellers guardArrayYF];
        for (NSDictionary *dic in self.sellers)
        {
            NSString *name=  [[dic objectForKey:@"username"] guardStringYF];
            
            [string appendString:name];
            [string appendString:@","];
        }
        if (string.length > 0)
        {
            [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
        }
        _sellersString = string;
    }
    
    if (_sellersString.length == 0)
    {
        _sellersString = @"未分配";
    }
    
    return _sellersString;
}


- (NSString *)recommend_byString
{
    
    if (!_recommend_byString)
    {
        self.recommend_by = [self.recommend_by guardDictionaryYF];
        _recommend_byString = [[self.recommend_by objectForKey:@"username"] guardStringYF];
    }
    
    return _recommend_byString;
}

-(NSString *)firstStrYF
{
    NSString *selleterStr = [NSString stringWithFormat:@"销售：%@",self.sellersString];
    
    return selleterStr;
}
-(NSString *)secondStrYF
{
    YFStudentStateDetailVC *stateVC = (YFStudentStateDetailVC *)self.weakCell.currentVC;
    
    NSString *status =stateVC.status;
    
    if (status.integerValue == YFIsNewRe.integerValue)
    {
        // 新注册
        if (self.join_atNoMInu.length)
        {
            return [NSString stringWithFormat:@"注册时间：%@",self.join_atNoMInu];
        }else
            return @"注册时间：";
    }
    
    return @"";
}



@end
