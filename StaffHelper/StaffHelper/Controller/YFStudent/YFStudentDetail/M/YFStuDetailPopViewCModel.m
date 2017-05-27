//
//  YFStuDetailPopViewCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStuDetailPopViewCModel.h"

#import "YFStuDetailPopViewCell.h"

#import "YFStuDetailGymPopVC.h"

static NSString *yFStuDetailPopViewCell = @"YFStuDetailPopViewCell";

@implementation YFStuDetailPopViewCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStuDetailPopViewCell;
        self.cellClass = [YFStuDetailPopViewCell class];
        self.cellHeight = Width320(48);
        self.edgeInsets = UIEdgeInsetsMake(0, Width320(44), 0, 0);
        self.isAll = NO;
//        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStuDetailPopViewCell *cell = (YFStuDetailPopViewCell *)baseCell;

    if (self.isAll) {
        [cell.headImageView setImage:[UIImage imageNamed:@"AllSeller"]];

        cell.titleLabel.text = @"全部场馆";
    }else
    {
        cell.titleLabel.text = self.gym.name;
        
        [cell.headImageView sd_setImageWithURL:self.gym.imgUrl];
    }
    [self setSelectState];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.isSelected = YES;
    [self setSelectState];
    
    YFStuDetailGymPopVC *rightVC = (YFStuDetailGymPopVC *)self.weakCell.currentVC;
    [rightVC setSelelcModel:self];
}

+ (instancetype)allModel
{
    YFStuDetailPopViewCModel *model = [YFStuDetailPopViewCModel defaultWithYYModelDic:nil];
    model.isAll = YES;
    return model;
}


- (void)setSelectState
{
    YFStuDetailPopViewCell *cell = (YFStuDetailPopViewCell *)self.weakCell;
    if (!self.isSelected)
    {
        cell.arrowImageView.hidden = YES;
//        cell.titleLabel.textColor = YFCellTitleColor;
    }else
    {
        cell.arrowImageView.hidden = NO;
//        cell.titleLabel.textColor = YFSelectedButtonColor;
    }
}


@end
