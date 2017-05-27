//
//  YFSignUpListAddCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListAddCell.h"
#import "UIView+masonryExtesionYF.h"


@interface YFSignUpListAddCell ()

@property(nonatomic, strong)UIImageView *selectimageView;

@end

@implementation YFSignUpListAddCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.sexImageView];


        [self.contentView addSubview:self.signUpTagView];

        [self.contentView addSubview:self.selectimageView];

        
        [self.sexImageView setSizeYF:CGSizeMake(14.0, 13.0)];
        [self.sexImageView setEqualCenterYOffset:0.0 toView:self.nameLabel];
        
        [self.sexImageView setLeftYF:7.0 toViewRight:self.nameLabel];
        
        [self.selectimageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAction:)]];

        
    }
    return self;
}



- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 48, 48)];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = 24;
    }
    return _headImageView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 15, self.headImageView.top + 1, 50, 21)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(15.0);
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (_phoneLabel == nil)
    {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 3, MSW - self.nameLabel.left - 15, 18)];
        _phoneLabel.textColor = RGB_YF(136, 136, 136);
        _phoneLabel.font = FontCellTitleValueFY;
    }
    return _phoneLabel;
}


-(UIImageView *)sexImageView
{
    if (_sexImageView == nil)
    {
        _sexImageView = [[UIImageView alloc] init];
        //        _sexImageView.clipsToBounds = YES;
        //        _sexImageView.layer.cornerRadius = 23.5;
    }
    return _sexImageView;
}


- (YFSignUpTagView *)signUpTagView
{
    if (!_signUpTagView)
    {
        _signUpTagView = [[YFSignUpTagView alloc] initWithFrame:CGRectMake(self.nameLabel.left - 5, self.phoneLabel.bottom + 3, self.phoneLabel.width, 0)];
        _signUpTagView.colorTagNomalBg = [UIColor whiteColor];
        _signUpTagView.fontTag = FontSizeFY(12);
        _signUpTagView.colorTextTag = YFCellSubGrayTitleColor;
        _signUpTagView.tagHeight = 24.0;
        _signUpTagView.beginxx = 0;
        _signUpTagView.userInteractionEnabled = NO;
    }
    return _signUpTagView;
}

- (UIImageView *)selectimageView
{
    if (!_selectimageView)
    {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 29, 20, 20)];
        
        _selectimageView = iv;
    }
    return _selectimageView;
}

- (void)setCannnotSelectStateYF
{
    self.selectimageView.userInteractionEnabled = NO;
    self.selectimageView.image = [UIImage imageNamed:@"addSignMemSele"];
    self.selectimageView.alpha = 0.3;
}
- (void)setSelectStateYF
{
    self.selectimageView.userInteractionEnabled = NO;
    self.selectimageView.image = [UIImage imageNamed:@"addSignMemSele"];
}

- (void)setUnselectStateYF
{
    self.selectimageView.userInteractionEnabled = NO;
    self.selectimageView.image = [UIImage imageNamed:@"addSignMemunSele"];
}

- (void)setDeleteStateYF
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.selectimageView.userInteractionEnabled = YES;
    self.selectimageView.image = [UIImage imageNamed:@"deleteSignMem"];
}

- (void)deleteAction:(id)model
{
    if (self.deleteBlock)
    {
        self.deleteBlock(self.weakModel);
    }
}

@end
