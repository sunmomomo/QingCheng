//
//  YFSignUpListCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/24.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListCModel.h"

#import "YFSignUpListCell.h"

#import "YFCompetitionModule.h"

static NSString *yFSignUpListCell = @"YFSignUpListCell";

@interface YFSignUpListCModel()



@end

@implementation YFSignUpListCModel
{
    NSString *_priceStr;
}
- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
       
        _priceStr = [NSString stringWithFormat:@"报名费用：%@元",self.price];
        self.created_at = [self.created_at stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

- (void)cellSettingYF
{
    self.cellIdentifier = yFSignUpListCell;
    self.cellClass = [YFSignUpListCell class];
    self.cellHeight = 145.0;
    self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
}

- (void)setCell:(YFSignUpListCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell.signUpTagView setTitleBlock:^NSString *(YFTeamCModel *model) {
        return model.name;
    }];
}

- (void)bindCell:(YFSignUpListCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    [baseCell.nameLabel changeWidth:self.nameWidth];

    [baseCell.sexImageView layoutIfNeeded];
    [baseCell.sexImageView setImage:[YFBaseCModel sexImageWithGender:self.gender]];

    [baseCell.headImageView sd_setImageWithURL:self.avatar placeholderImage:[YFBaseCModel placeHolderImageWithGender:self.gender]];
    
    baseCell.phoneLabel.text = self.phone;
    baseCell.nameLabel.text = self.username;
    baseCell.signUpTimeLabel.text = [NSString stringWithFormat:@"报名时间：%@",self.created_at];
    baseCell.signUpPayLabel.text = _priceStr;
    
    if (self.teams.count) {
        baseCell.signUpTagView.hidden = NO;
        [baseCell.signUpTagView removeAllTag];
        [baseCell.signUpTagView addTagModels:self.teams];
        self.cellHeight = baseCell.signUpTagView.bottom + 9;
    }else
    {
        baseCell.signUpTagView.hidden = YES;
        self.cellHeight = baseCell.signUpTagView.top + 9;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *detailVC = [YFCompetitionModule signUpDetailVCOrderId:self.order_id];
    
    [self.weakCell.currentVC.navigationController pushViewController:detailVC animated:YES];
}
@end
