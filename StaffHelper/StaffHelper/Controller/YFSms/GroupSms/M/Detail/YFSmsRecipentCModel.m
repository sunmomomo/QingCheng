//
//  YFSmsRecipentCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsRecipentCModel.h"

#import "YFSmsRecipentCell.h"

#import "YFTBSmsDetailSectionModel.h"

#import "YFBaseRefreshTBVC.h"

static NSString *yFSmsRecipentCell = @"YFSmsRecipentCell";


@implementation YFSmsRecipentCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFSmsRecipentCell;
        self.cellClass = [YFSmsRecipentCell class];
        self.cellHeight = 50.0;
        self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

        self.showEdgeInsets = UIEdgeInsetsMake(0, MSW, 0, 0);
        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

- (void)setCell:(YFSmsRecipentCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell.showDetaiButton addTarget:self action:@selector(showDetailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFSmsRecipentCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    self.weakCell.indexPath = indexPath;
    baseCell.baseModel = self;
    
    [self setValueToCell];
}

- (NSMutableAttributedString *)atriFirstNameString
{
    if (!_atriFirstNameString) {
        
        YFSmsRecipentCell *weakCell = (YFSmsRecipentCell *)self.weakCell;
        NSMutableAttributedString *atriString = [[NSMutableAttributedString alloc] initWithString:self.firstNameTitle];
        
        [atriString addAttribute:NSFontAttributeName value:weakCell.nameAllLabel.font range:NSMakeRange(0, atriString.length)];
        [atriString addAttribute:NSForegroundColorAttributeName value:RGB_YF(51, 51, 51) range:NSMakeRange(0, atriString.length)];
        if (atriString.length >= 13)
        {
            [atriString addAttribute:NSForegroundColorAttributeName value:RGB_YF(199, 199, 199) range:NSMakeRange(atriString.length - 13, 13)];
        }

        _atriFirstNameString = atriString;
    }
    return _atriFirstNameString;
}

- (void)showDetailButtonAction:(UIButton *)sender
{
    if (self.allNameTitle.length == 0)
    {
        return;
    }
    self.weakSectionModel.isShowDetail = !self.weakSectionModel.isShowDetail;

    [self setValueToCell];
    [((YFBaseRefreshTBVC *)self.weakCell.currentVC).baseTableView reloadSections:[NSIndexSet indexSetWithIndex:self.weakCell.indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setValueToCell
{
    YFSmsRecipentCell *weakCell = (YFSmsRecipentCell *)self.weakCell;
    
    if (self.weakSectionModel.isShowDetail)
    {
        self.edgeInsets = self.showEdgeInsets;
        [weakCell.showDetaiButton setTitle:@"隐藏" forState:UIControlStateNormal];

        weakCell.nameAllLabel.attributedText = self.atriFirstNameString;
    }else
    {
        self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        weakCell.nameAllLabel.text = self.allNameTitle;

        [weakCell.showDetaiButton setTitle:@"详情" forState:UIControlStateNormal];
    }

}

- (void)getInforFrom:(YFSmsRecipentSubCModel *)model
{
    self.stuId = model.stuId;
    self.name = model.name;
    self.avatar = model.avatar;
    self.phone = model.phone;
}



- (NSString *)firstNameTitle
{
    if (!_firstNameTitle)
    {
        _firstNameTitle = [NSString stringWithFormat:@"%@    %@",self.name,self.phone];
    }
    return _firstNameTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
}

@end
