//
//  YFSignUpListDeletePerCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListDeletePerCModel.h"

#import "YFSignUpListDeleteCell.h"

#import "UITableView+YFReloadExtension.h"

#import "YFBaseRefreshTBExtensionVC.h"

static NSString *yFSignUpListDeleteCell = @"YFSignUpListDeleteCell";

@interface YFSignUpListDeletePerCModel ()

@property(nonatomic,copy)void(^deletActionBlock)(id);

@end

@implementation YFSignUpListDeletePerCModel



- (void)cellSettingYF
{
    self.cellIdentifier = yFSignUpListDeleteCell;
    self.cellClass = [YFSignUpListDeleteCell class];
    self.cellHeight = 78;
    self.edgeInsets = UIEdgeInsetsMake(0, 113, 0, 0);
}


- (void)setCell:(YFSignUpListDeleteCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)bindCell:(YFSignUpListDeleteCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    baseCell.weakModel = self;
    
    baseCell.deletActionBlock = self.deletActionBlock;
    [baseCell.nameLabel changeWidth:self.nameWidth];
    
    [baseCell.sexImageView layoutIfNeeded];
    [baseCell.sexImageView setImage:[YFBaseCModel sexImageWithGender:self.gender]];
    
    [baseCell.headImageView sd_setImageWithURL:self.avatar placeholderImage:[YFBaseCModel placeHolderImageWithGender:self.gender]];
    
    baseCell.phoneLabel.text = self.phone;
    baseCell.nameLabel.text = self.username;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
}

- (void (^)(id))deletActionBlock
{
    if (_deletActionBlock == nil)
    {
        _deletActionBlock = self.selectBlock;
    }
    return _deletActionBlock;
}


@end
