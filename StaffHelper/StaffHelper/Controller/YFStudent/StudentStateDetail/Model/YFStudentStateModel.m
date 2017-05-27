//
//  YFStudentStateModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentStateModel.h"

#import "YFStudentStateCell.h"
#import "YFAppService.h"

#import "UIActionSheet+YFAdditions.h"
#import "StudentDetailController.h"
#import "YFSearchResultStudentStateVC.h"
#import "YFStudentStateDetailVC.h"
#import "YFStudentListVC.h"

static NSString *yFStudentStateCell = @"YFStudentStateCell";


@implementation YFStudentStateModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentStateCell;
        self.cellClass = [YFStudentStateCell class];
        self.cellHeight = 175;
        
        self.edgeInsets = UIEdgeInsetsMake(0, 82, 0, 0);
        self.track_record = [self.track_record guardStringYF];
        self.join_atNoMInu = [self.join_atNoMInu guardStringYF];
        self.phone = [self.phone guardStringYF];
        self.gender = [self.gender guardStringYF];
        self.username = [self.username guardStringYF];
        self.status = [self.status guardStringYF];
        self.first_card_info = [self.first_card_info guardStringYF];

//
        weakTypesYF
        [self setPhoneActionBlock:^{
            [weakS setPhoneAction:nil];
        }];
        
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
        NSArray *array = [_join_at componentsSeparatedByString:@"T"];
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

- (CGFloat)firstHeight
{
    if (_firstHeight == 0) {
        
        _firstHeight = [self heightFromStr:[self firstStrYF]];

    }
    return _firstHeight;
}

- (CGFloat)secondHeight
{
    if (_secondHeight == 0)
    {
        _secondHeight = [self heightFromStr:[self secondStrYF]];
    }
    return _secondHeight;
}

- (CGFloat)thirdHeight
{
    if (_thirdHeight == 0) {
        
        _thirdHeight = [self heightFromStr:[self thirdStrYF]];
    }
    return _thirdHeight;
}


- (CGFloat )heightFromStr:(NSString *)str
{
    CGSize secondSize = YF_MULTILINE_TEXTSIZE(str, YFGRAYLabelFont, YFMaxSize, 0);
    
    CGFloat secondHeight = secondSize.height + 8.0;
    if (str.length == 0) {
        secondHeight = 0;
    }
    
    return  secondHeight;

}



-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentStateCell *cell = (YFStudentStateCell *)baseCell;
    cell.phoneActionBlock = self.phoneActionBlock;
    NSString *nameStr = self.username;
    BOOL isfemale = self.gender.integerValue;
    NSUInteger state = self.status.integerValue;

    

    
    
   
    
    cell.grayFirstLabel.frame = CGRectMake(cell.grayFirstLabel.mj_x, 6, cell.grayFirstLabel.width, self.firstHeight);
    cell.graySecondLabel.frame = CGRectMake(cell.grayFirstLabel.mj_x, cell.grayFirstLabel.bottom, cell.grayFirstLabel.width, self.secondHeight);
    
    cell.grayThreeabel.frame =  CGRectMake(7.5, cell.graySecondLabel.bottom, cell.graySecondLabel.width, self.thirdHeight);
    
    if (self.firstHeight==0 && self.secondHeight == 0 && self.thirdHeight == 0)
    {
    [cell.grayView changeHeight:0.0];
        cell.grayView.hidden = YES;
    }else
    {
        cell.grayView.hidden = NO;
        [cell.grayView changeHeight:cell.grayThreeabel.bottom + 8];
    }
    
    self.cellHeight = (long)cell.grayView.bottom + 15.0;
    
    DebugLogParamYF(@"----%@",@(self.cellHeight));
    
    cell.grayFirstLabel.text = [self firstStrYF];
    cell.graySecondLabel.text = [self secondStrYF];
    cell.grayThreeabel.text = [self thirdStrYF];
    
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
    
        NSString *selleterStr = [NSString stringWithFormat:@"销售：%@",self.sellersString];
    
    if (self.sellersString.length)
    {
        cell.sellersLabel.text = selleterStr;
    }else
    {
        cell.sellersLabel.text = @"";
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

    stu.createDate = self.join_at;
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
    
    YFStudentStateDetailVC *stateVC = (YFStudentStateDetailVC *)self.weakCell.currentVC;
    
    NSString *status =stateVC.status;
    
    if (status.integerValue == YFIsNewRe.integerValue)
    {
        // 新注册
        if (self.origin.length)
        {
        return [NSString stringWithFormat:@"来源：%@",self.origin];
        }else
            return @"来源：";
    }else if (status.integerValue == YFIsFollowing.integerValue)
    {
        // 新注册
        if (self.track_record.length)
        {
            return [NSString stringWithFormat:@"最新跟进：%@",self.track_record];
        }else
            return @"";
    }else if (status.integerValue == YFIsMember.integerValue)
    {
        if (self.first_card_info.length) {
            return [NSString stringWithFormat:@"首次购卡：%@",self.first_card_info];
        }
        return @"";
    }
    return @"";
}
-(NSString *)secondStrYF
{
    YFStudentStateDetailVC *stateVC = (YFStudentStateDetailVC *)self.weakCell.currentVC;
    
    NSString *status =stateVC.status;
    
    if (status.integerValue == YFIsNewRe.integerValue)
    {
        // 新注册
        if (self.recommend_byString.length)
        {
            return [NSString stringWithFormat:@"推荐人：%@",self.recommend_byString];
        }else
            return @"推荐人：";
    }
    
    return @"";
}
-(NSString *)thirdStrYF
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



/*
 NSString *nameStr = @"fafafaf";
 BOOL ismale = indexPath.row % 2 == 0;
 NSUInteger state = indexPath.row % 3;
 NSString *firstStr = indexPath.row % 2 == 0 ? @"口碑网：双十二活动口碑网：双十二活动口碑网：双十二活动口碑网：双十二活动口碑网：双十二活动口碑网：双十二活动":@"口碑网：双十二活动";
 NSString *SecondStr = indexPath.row % 2 == 0 ? @"推荐人：林雪婷林雪婷林雪婷林雪婷林雪婷林雪婷林雪婷林雪婷林雪婷":@"推荐人：林雪婷林雪婷";
 NSString *threeStr = indexPath.row % 2 == 0 ? @"注册时间：2016-12-09":@"注册时间：2016-12-09注册时间：2016-12-09注册时间：2016-12-09";
 */

@end
