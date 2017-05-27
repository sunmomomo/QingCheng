//
//  YFSignUpListAddPerCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListAddPerCModel.h"

#import "YFSignUpListAddPerVC.h"

#import "YFSignUpListAddCell.h"

#import "YFTeamCModel.h"

static NSString *yFSignUpListAddCell = @"YFSignUpListAddCell";


@implementation YFSignUpListAddPerCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.dataDic = jsonDic;
    }
    return self;
}

- (instancetype)sameModel:(void(^)(id))selectBlock
{
    YFSignUpListAddPerCModel *model = [YFSignUpListAddPerCModel defaultWithYYModelDic:self.dataDic];
    model.selectBlock = selectBlock;
    model.cellHeight = self.cellHeight;
    return model;
}

- (void)cellSettingYF
{
    self.cellIdentifier = yFSignUpListAddCell;
    self.cellClass = [YFSignUpListAddCell class];
    self.cellHeight = 145.0;
    self.edgeInsets = UIEdgeInsetsMake(0, 113, 0, 0);
    self.isSelected = NO;
}
- (void)setCell:(YFSignUpListAddCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell.signUpTagView setTitleBlock:^NSString *(YFTeamCModel *model) {
        return model.name;
    }];
}

-(void)bindCell:(YFSignUpListAddCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
   
    [baseCell.nameLabel changeWidth:self.nameWidth];
    
    [baseCell.sexImageView layoutIfNeeded];
    [baseCell.sexImageView setImage:[YFBaseCModel sexImageWithGender:self.gender]];
    
    [baseCell.headImageView sd_setImageWithURL:self.avatar placeholderImage:[YFBaseCModel placeHolderImageWithGender:self.gender]];
    
    baseCell.phoneLabel.text = self.phone;
    baseCell.nameLabel.text = self.username;
    baseCell.weakModel = self;
    
    if (self.teams.count) {
        baseCell.signUpTagView.hidden = NO;
        [baseCell.signUpTagView removeAllTag];
        [baseCell.signUpTagView addTagModels:self.teams];
        self.cellHeight = baseCell.signUpTagView.bottom + 9;
    }else
    {
        baseCell.signUpTagView.hidden = YES;
        self.cellHeight = baseCell.signUpTagView.top + 17;
    }
    if ([self.weakCell.currentVC isKindOfClass:[YFSignUpListAddPerVC class]] == NO)
    {
        baseCell.deleteBlock = self.selectBlock;
        [baseCell setDeleteStateYF];
    }else
    {
        [self setSelectStateCell:baseCell];
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.isCannotSelected == YES)
    {
        return;
    }
    
    if ([self.weakCell.currentVC isKindOfClass:[YFSignUpListAddPerVC class]] == NO)
    {
        return;
    }
    self.isSelected = !self.isSelected;
    
    
    YFSignUpListAddPerVC *addVC = (YFSignUpListAddPerVC *)self.weakCell.currentVC;

    if (self.isSelected)
    {
        [addVC setSelctModel:self check:YES];
    }
    else
    {
        [addVC removeSelctModel:self];
    }
    [self setSelectStateCell:(YFSignUpListAddCell *)self.weakCell];
}

- (void)setSelectStateCell:(YFSignUpListAddCell *)baseCell
{
    
    if (self.isCannotSelected == YES)
    {
        [baseCell setCannnotSelectStateYF];
    }
    else if (self.isSelected)
    {
        [baseCell setSelectStateYF];
    }else
    {
        
        [baseCell setUnselectStateYF];
    }
}




@end
