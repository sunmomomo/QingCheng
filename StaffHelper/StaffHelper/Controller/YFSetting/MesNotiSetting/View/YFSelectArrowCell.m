//
//  YFSelectArrowCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSelectArrowCell.h"

@implementation YFSelectArrowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.desValueLabel];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (UILabel *)desValueLabel
{
    if (!_desValueLabel)
    {
        _desValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW - self.arrowImageView.width - 17 -  Width320(90), 0, Width320(90), Height320(40))];
        
        _desValueLabel.textColor = RGBCOLOR(153, 153, 153);
        
        _desValueLabel.textAlignment = NSTextAlignmentRight;
        
        _desValueLabel.font = AllFont(12);
    }
    return _desValueLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel)
    {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.desValueLabel.left - 15, Height320(40))];
        
        _desLabel.textColor = RGBCOLOR(51, 51, 51);
        
        _desLabel.font = AllFont(14);
    }
    return _desLabel;
}


-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 15 - 7.5, Height320(40) / 2.0 - 6, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}

@end
