//
//  CheckinCardCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinCardCell.h"

@interface CheckinCardCell ()

{
    
    UILabel *_nameLabel;
    
    UILabel *_remainLabel;
    
    UIImageView *_chooseImg;
    
    UIImageView *_imageView;
    
}

@end

@implementation CheckinCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(18), Width320(24), Height320(24))];
        
        _imageView.layer.cornerRadius = _imageView.width/2;
        
        _imageView.layer.masksToBounds = YES;
        
        _imageView.image = [UIImage imageNamed:@"card_pay_card"];
        
        [self.contentView addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.right+Width320(8), Height320(12), MSW-_imageView.right-Width320(20), Height320(18))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.font = AllFont(14);
        
        [self.contentView addSubview:_nameLabel];
        
        _remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(2), _nameLabel.width, Height320(14))];
        
        _remainLabel.textColor = UIColorFromRGB(0x999999);
        
        _remainLabel.font = AllFont(12);
        
        [self.contentView addSubview:_remainLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(25), Height320(25), Width320(13), Height320(10))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        [self.contentView addSubview:_chooseImg];
        
    }
    
    return self;
    
}

-(void)setCardName:(NSString *)cardName
{
    
    _cardName = cardName;
    
    _nameLabel.text = _cardName;
    
}

-(void)setRemain:(NSString *)remain
{
    
    _remain = remain;
    
    _remainLabel.text = _remain;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !_choosed;
    
}

@end
