//
//  YFCollectionViewSellerCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFCollectionViewSellerCell.h"
#import "YFAppConfig.h"

#define YFLeftGap XFrom6YF(11.5)
#define YFRightGap XFrom6YF(11.5)


@implementation YFCollectionViewSellerCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
//        23.0f
        
        [self addSubview:self.headImageView];
        [self addSubview:self.nameLabel];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.chooseImg];
    }
    return self;
}

- (UIImageView *)chooseImg
{
    if (!_chooseImg)
    {
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.headImageView.right-Width320(16), self.headImageView.bottom-Height320(16), Width320(16), Height320(16))];
        
        _chooseImg.backgroundColor = UIColorFromRGB(0xffffff);
        
        _chooseImg.layer.cornerRadius = _chooseImg.width/2;
        
        _chooseImg.layer.masksToBounds = YES;
        
        _chooseImg.image = [UIImage imageNamed:@"selected"];
        
        [self addSubview:_chooseImg];

    }
    return _chooseImg;
}

- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        CGFloat width = self.width - YFLeftGap - YFRightGap;
                
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(YFLeftGap, 23, width, width)];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = width / 2.0;
        _headImageView.layer.borderColor = kMainColor.CGColor;
        
        _headImageView.layer.borderWidth = 0;
    }
    return _headImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImageView.bottom + 10.0, self.width, Width(14))];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(Width(14));
    }
    return _nameLabel;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    _chooseImg.hidden = !_isSelected;
    
    _headImageView.layer.borderWidth = _isSelected?OnePX*2:0;
}

@end
