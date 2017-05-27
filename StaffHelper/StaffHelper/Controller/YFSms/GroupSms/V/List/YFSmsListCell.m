//
//  YFSmsListCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsListCell.h"

@implementation YFSmsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.indicSenedButton];
        [self.contentView addSubview:self.indicDraftButton];
        [self.contentView addSubview:self.timeLabel];
        //
    }
    return self;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 16.0, MSW - self.arrowImageView.width - 15.0, 20)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(15.0);
    }
    return _nameLabel;
}

- (UILabel *)desLabel
{
    if (_desLabel == nil)
    {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.nameLabel.bottom + 6.0, MSW - 30, 38)];
        _desLabel.numberOfLines = 2;
        _desLabel.textColor = RGB_YF(136, 136, 136);
        _desLabel.font = FontCellTitleValueFY;
    }
    return _desLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 26.5, 21, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}

- (YFButton *)indicDraftButton
{
    if(_indicDraftButton == nil){
        
        _indicDraftButton = [[YFButton alloc] initWithFrame:CGRectMake(15, self.desLabel.bottom + 6.0, 80, 18) imageFrame:CGRectMake(0, 2.5, 11, 13) titleFrame:CGRectMake(20, 0, 60, 18)];
        
        [_indicDraftButton.titleLabel setFont:FontSizeFY(13.0)];
        
        [_indicDraftButton setTitle:@"草稿" forState:UIControlStateNormal];
        
        [_indicDraftButton setTitleColor:RGB_YF(249, 148, 78) forState:UIControlStateNormal];
        
        [_indicDraftButton setImage:[UIImage imageNamed:@"DraftSms"] forState:UIControlStateNormal];
    }
    return _indicDraftButton;
}


- (YFButton *)indicSenedButton
{
    if(_indicSenedButton == nil){
        
        _indicSenedButton = [[YFButton alloc] initWithFrame:CGRectMake(15, self.desLabel.bottom + 6.0, 80, 18) imageFrame:CGRectMake(0, 4, 12, 10) titleFrame:CGRectMake(20, 0, 60, 18)];
        
        [_indicSenedButton.titleLabel setFont:FontSizeFY(13.0)];
        
        [_indicSenedButton setTitle:@"已发送" forState:UIControlStateNormal];
        
        [_indicSenedButton setTitleColor:RGB_YF(13, 177, 75) forState:UIControlStateNormal];
        
        [_indicSenedButton setImage:[UIImage imageNamed:@"SendedSms"] forState:UIControlStateNormal];
    }
    return _indicSenedButton;
}


- (UILabel *)timeLabel
{
    if (_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.indicSenedButton.right, self.indicSenedButton.top, MSW - self.indicSenedButton.right - 15, 18)];
        _timeLabel.textColor = RGB_YF(187, 187, 187);
        _timeLabel.font = FontCellTitleValueFY;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (void)fitFrame
{
    self.indicSenedButton.frame = CGRectMake(15, self.desLabel.bottom + 6.0, 80, 18);
    self.indicDraftButton.frame = CGRectMake(15, self.desLabel.bottom + 6.0, 80, 18);
    self.timeLabel.frame = CGRectMake(self.indicSenedButton.right, self.indicSenedButton.top, MSW - self.indicSenedButton.right - 15, 18);
    
}

@end
