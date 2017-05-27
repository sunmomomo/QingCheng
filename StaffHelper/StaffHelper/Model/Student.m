//
//  Student.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "Student.h"

#import "YFStudentListCell.h"

#import "StudentDetailController.h"

#import "YYModel.h"

#import "YFTagColloectionViewCell.h"

static NSString *yFStudentListCell = @"yFStudentListCell";

@interface Student ()<YYModel>

@end


@implementation Student
{
    CGSize _cellSizeYF;
}
-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.gyms = [NSArray array];
        
        self.cards = [NSMutableArray array];
        
        self.cellIdentifier = yFStudentListCell;
        self.cellClass = [YFStudentListCell class];
        self.cellHeight = 75.0;
    }
    
    return self;
    
}

- (NSString *)cvCellIdentifier
{
    return yFTagColloectionViewCell;
}

- (CGSize)cellSize
{
    if (_cellSizeYF.width == 0)
    {
        // 标签宽度
        CGFloat width = ceil( [self.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width);
        if (width > [[UIScreen mainScreen] bounds].size.width - 31) {
            width = [[UIScreen mainScreen] bounds].size.width - 31;
        }
        _cellSizeYF = CGSizeMake(width + 14 + 26, 26);
        
    }
    return _cellSizeYF;
}


-(NSString *)head
{
    if (!_head) {
        _head = @"#";
    }
    return _head;
}

- (NSMutableDictionary *)sellersDic
{
    if (!_sellersDic)
    {
        _sellersDic = [NSMutableDictionary dictionary];
        
        for (Seller *seller in self.sellers)
        {
            NSString *string = [NSString stringWithFormat:@"%@",@(seller.sellerId)];
            if (string)
            {
                [_sellersDic setObject:seller forKey:string];
            }
        }
    }
    return _sellersDic;
}

-(NSMutableDictionary *)coachesDic
{
    if (!_coachesDic)
    {
        _coachesDic = [NSMutableDictionary dictionary];
        
        for (Coach *coach in self.coaches)
        {
            NSString *string = [NSString stringWithFormat:@"%@",@(coach.coachId)];
            if (string)
            {
                [_coachesDic setObject:coach forKey:string];
            }
        }
    }
    return _coachesDic;
}

- (NSString *)stuStrId
{
    if (!_stuStrId)
    {
        _stuStrId = [NSString stringWithFormat:@"%@",@(_stuId)];
    }
    return _stuStrId;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    YFStudentListCell *cell = (YFStudentListCell *)baseCell;

    cell.stateLabel.hidden = YES;
    cell.stateImageView.hidden = YES;


}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    NSString *nameStr = self.name;
    BOOL ismale = self.sex == 0;
    
    
    YFStudentListCell *cell = (YFStudentListCell *)baseCell;
    cell.nameLabel.text = nameStr;
    CGSize size = YF_MULTILINE_TEXTSIZE(nameStr, cell.nameLabel.font, CGSizeMake(150, cell.nameLabel.height), 0);
    [cell.nameLabel changeWidth:size.width + 1];
    cell.phoneLabel.text = self.phone;
    [cell.headImageView sd_setImageWithURL:self.avatar];
    
    
    if (ismale)
    {
        [cell.sexImageView setImage:[UIImage imageNamed:@"sex_male"]];
    }else
    {
        [cell.sexImageView setImage:[UIImage imageNamed:@"sex_female"]];
    }
    
    [cell.sexImageView layoutIfNeeded];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StudentDetailController *svc = [[StudentDetailController alloc]init];
    
    svc.student = self;
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).student = svc.student;
    
    if (AppGym) {
        
        svc.gym = ((AppDelegate *)[UIApplication sharedApplication].delegate).gym;
    }
    [self.weakCell.currentVC.navigationController pushViewController:svc animated:YES];
}


- (void)bindCollVCell:(YFTagColloectionViewCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.tagNameLabel.text = self.name;
    baseCell.tagModel = self;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"stuId":@"id",
             @"name":@"username",
             };
}

@end
