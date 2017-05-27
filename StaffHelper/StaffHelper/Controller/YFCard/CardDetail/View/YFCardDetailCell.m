//
//  YFCardDetailCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardDetailCell.h"
#import "UIView+masonryExtesionYF.h"
#import "YFAppConfig.h"

@implementation YFCardDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.desLabel];
    
        [self.contentView addSubview:self.arrowImageView];
    
        _headImageView.backgroundColor = YFMainBackColor;
    
        self.arrowImageView.backgroundColor = YFMainBackColor;
    }
    return self;
}


- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16.0, Height320(26), Height320(20), Height320(20))];
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 15, Height320(17), 100, Height320(20))];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = AllFont(14);
    }
    return _nameLabel;
}

-(UILabel *)desLabel
{
    if (_desLabel == nil)
    {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 5.5, MSW - self.nameLabel.left - self.arrowImageView.width  - Height320(12) , Height320(12))];
        _desLabel.textColor = YFCellSubTitleColor;
        _desLabel.font = FontSizeFY(XFrom5YF(12));
    }
    return _desLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - Height320(7.5)  -Height320(12) , (Height320(72) - Height320(12.0)) / 2.0, Height320(7.5), Height320(12))];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}
@end
