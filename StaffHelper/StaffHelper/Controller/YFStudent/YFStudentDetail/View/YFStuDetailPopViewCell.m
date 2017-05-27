//
//  YFStuDetailPopViewCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStuDetailPopViewCell.h"

@implementation YFStuDetailPopViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(28), Height320(28))];
        
        _headImageView.layer.cornerRadius = _headImageView.width/2;
        
        _headImageView.layer.masksToBounds = YES;
        
        _headImageView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
        
        _headImageView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_headImageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headImageView.right + Width320(6), 0, Width320(190) - _headImageView.right - Width320(6) - 3, Height320(48))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = FontSizeFY(XFrom5YF(12));
        
        [self.contentView addSubview:_titleLabel];
        
        [self addSubview:self.arrowImageView];
    }
    return self;
}



-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake( Width320(190), Width320(39) / 2.0 , Width320(12), Width320(9))];
        _arrowImageView.image = [UIImage imageNamed:@"FillSelected"];
    }
    return _arrowImageView;
}



@end
