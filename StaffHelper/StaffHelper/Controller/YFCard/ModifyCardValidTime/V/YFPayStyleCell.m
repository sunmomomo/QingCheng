//
//  YFPayStyleCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFPayStyleCell.h"


@implementation YFPayStyleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.desValueLabel];
        [self.contentView addSubview:self.desSubValueLabel];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (UILabel *)desValueLabel
{
    if (!_desValueLabel)
    {
        _desValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW - self.arrowImageView.width - 19 -  Width320(120) - 10, 0, Width320(120), Height320(40))];
        
        _desValueLabel.textColor = RGBCOLOR(153, 153, 153);
        
        _desValueLabel.textAlignment = NSTextAlignmentRight;
        
        _desValueLabel.font = FontScale320SizeFY(14);
    }
    return _desValueLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel)
    {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 0, self.desValueLabel.width, Height320(40))];
        
        _desLabel.textColor = RGBCOLOR(51, 51, 51);
        
        _desLabel.font = FontScale320SizeFY(14);
    }
    return _desLabel;
}


- (UILabel *)desSubValueLabel
{
    if (!_desSubValueLabel)
    {
        _desSubValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.desValueLabel.left, self.desValueLabel.bottom, self.desValueLabel.width, Height320(40))];
        
        _desSubValueLabel.textColor = RGBCOLOR(153, 153, 153);
        
        _desSubValueLabel.font = FontScale320SizeFY(12);
    }
    return _desSubValueLabel;
}


-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 19 - 7.5, Height320(40) / 2.0 - 6, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
//    _desValueLabel.font = FontSizeFY(XFromWidthYF(self.contentView.height,40, 14));

    
    
}


@end
