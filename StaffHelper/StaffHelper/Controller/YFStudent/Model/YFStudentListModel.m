//
//  YFStudentListModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentListModel.h"
#import "YFStudentListCell.h"
#import "NSObject+YFExtension.h"
#import "StudentDetailController.h"
#import "YFStudentListVC.h"
#import "YFSearchResultStuListVC.h"

static NSString *yFStudentListCell = @"yFStudentListCell";


@implementation YFStudentListModel
{
    NSString *_head;
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.p_id = value;
    }else
        [super setValue:value forKey:key];
}

-(NSString *)checkin_avatar
{
    if (!_checkin_avatar) {
        _checkin_avatar = @"";
    }
    return _checkin_avatar;
}

-(NSString *)head
{
    if (!_head) {
        _head = @"#";
    }
    return _head;
}

-(void)setHead:(NSString *)head
{
    if (head.length == 1) {
        int asciicode = [head characterAtIndex:0];
        
        if ((asciicode>=65 && asciicode <=90) || (asciicode>=97 && asciicode<=122)) {
            head = [head uppercaseString];
        }else
        {
            head = @"#";
        }
    }else
    {
        head = @"#";

    }
    _head = head;
}


- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentListCell;
        self.cellClass = [YFStudentListCell class];
        self.cellHeight = 75.0;
        
        self.gender = [self.gender guardStringYF];
        self.p_id = [self.p_id guardStringYF];
        self.phone = [self.phone guardStringYF];
        self.shops = [self.shops guardArrayYF];
        self.head = [self.head guardStringYF];
        self.status = [self.status guardStringYF];


    }
    return self;
}


- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    NSString *nameStr = self.username;

    NSUInteger state = self.status.integerValue;
    
    YFStudentListCell *cell = (YFStudentListCell *)baseCell;
    cell.nameLabel.text = nameStr;
    CGSize size = YF_MULTILINE_TEXTSIZE(nameStr, cell.nameLabel.font, CGSizeMake(150, cell.nameLabel.height), 0);
    [cell.nameLabel changeWidth:size.width + 1];
    cell.phoneLabel.text = self.phone;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.avatar]];
    
    [cell.sexImageView setImage:[YFBaseCModel sexImageWithGender:self.gender]];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StudentDetailController *svc = [[StudentDetailController alloc]init];
    
    
    Student *stu = [[Student alloc]init];
    
    stu.stuId = [self.p_id integerValue];
    
    stu.name = self.username;
    
    stu.phone = self.phone;
    stu.avatar = [NSURL URLWithString:self.avatar];
    stu.photo = [NSURL URLWithString:self.checkin_avatar];
    stu.sex = [self.gender integerValue]?SexTypeWoman:SexTypeMan;
    stu.head = self.head;
    stu.createDate = self.join_at;
    stu.country = [[CountryPhone alloc] init];
    stu.country.countryNo = self.area_code;
    stu.type = self.status.integerValue;
//    stu.remarks = self.

    svc.student = stu;
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).student = svc.student;
    
    if (AppGym) {
        
        svc.gym = ((AppDelegate *)[UIApplication sharedApplication].delegate).gym;
        
    }
    
    [self.weakCell.currentVC.navigationController pushViewController:svc animated:YES];
}

@end
