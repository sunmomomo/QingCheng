//
//  CheckinHistoryCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinHistoryCell.h"

#import "UIImage+Category.h"

@interface CheckinHistoryCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
    UILabel *_checkinLabel;
    
    UILabel *_checkoutLabel;
    
    UIImageView *_sexImg;
    
    UIImageView *_checkinImg;
    
    UIImageView *_checkoutImg;
    
    UILabel *_cancelLabel;
    
}

@end

@implementation CheckinHistoryCell

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
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(50), Height320(50))];
        
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        _iconView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        _iconView.layer.borderWidth = OnePX;
        
        [self.contentView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(10), Height320(15), Width320(200), Height320(16))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.font = AllFont(14);
        
        [self.contentView addSubview:_nameLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.right+Width320(6), Height320(16), Width320(12), Height320(12))];
        
        _sexImg.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.contentView addSubview:_sexImg];
        
        _checkinImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(6), Width320(10), Height320(10))];
        
        _checkinImg.image = [[UIImage imageNamed:@"checkin_button"]imageWithTintColor:UIColorFromRGB(0x56C981)];
        
        [self.contentView addSubview:_checkinImg];
        
        _checkinLabel = [[UILabel alloc]initWithFrame:CGRectMake(_checkinImg.right+Width320(6), _nameLabel.bottom+Height320(4), Width320(180), Height320(14))];
        
        _checkinLabel.textColor = UIColorFromRGB(0x999999);
        
        _checkinLabel.font = AllFont(12);
        
        [self.contentView addSubview:_checkinLabel];
        
        _checkoutImg = [[UIImageView alloc]initWithFrame:CGRectMake(_checkinImg.left, _checkinImg.bottom+Height320(8), Width320(10), Height320(10))];
        
        _checkoutImg.image = [[UIImage imageNamed:@"checkout_button"] imageWithTintColor:UIColorFromRGB(0xFBBF95)];
        
        [self.contentView addSubview:_checkoutImg];
        
        _checkoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(_checkinLabel.left, _checkinLabel.bottom+Height320(3), _checkinLabel.width, _checkinLabel.height)];
        
        _checkoutLabel.textColor = UIColorFromRGB(0x999999);
        
        _checkoutLabel.font = AllFont(12);
        
        [self.contentView addSubview:_checkoutLabel];
        
        _cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(76), Height320(14), Width320(48), Height320(16))];
        
        _cancelLabel.layer.cornerRadius = 1;
        
        _cancelLabel.layer.masksToBounds = YES;
        
        _cancelLabel.backgroundColor = UIColorFromRGB(0xE8E8E8);
        
        _cancelLabel.text = @"已撤销";
        
        _cancelLabel.textColor = UIColorFromRGB(0x999999);
        
        _cancelLabel.textAlignment = NSTextAlignmentCenter;
        
        _cancelLabel.font = AllFont(11);
        
        [self.contentView addSubview:_cancelLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(19), Height320(35.5), Width320(7), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [self.contentView addSubview:arrow];
        
    }
    
    return self;
    
}

-(void)setImageURL:(NSURL *)imageURL
{
    
    _imageURL = imageURL;
    
    [_iconView sd_setImageWithURL:_imageURL placeholderImage:[UIImage imageNamed:@"img_default_checkinphoto"]];
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = _name;
    
    [_nameLabel autoWidth];
    
    [_sexImg changeLeft:_nameLabel.right+Width320(5)];
    
}

-(void)setSex:(SexType)sex
{
    
    _sex = sex;
    
    _sexImg.image = [UIImage imageNamed:_sex == SexTypeMan?@"sex_male":@"sex_female"];
    
}

-(void)setHaveCanceled:(BOOL)haveCanceled
{
    
    _haveCanceled = haveCanceled;
    
    _cancelLabel.hidden = !_haveCanceled;
    
}

-(void)setCheckinTime:(NSString *)checkinTime
{
    
    _checkinTime = checkinTime;
    
    _checkinLabel.text = [NSString stringWithFormat:@"签到时间：%@",_checkinTime];
    
}

-(void)setCheckoutTime:(NSString *)checkoutTime
{
    
    _checkoutTime = checkoutTime;
    
    if (_checkoutTime) {
        
        _checkoutLabel.text = [NSString stringWithFormat:@"签出时间：%@",_checkoutTime];
        
        _checkoutImg.image = [[UIImage imageNamed:@"checkout_button"] imageWithTintColor:UIColorFromRGB(0xFBBF95)];
        
    }else{
        
        _checkoutLabel.text = @"暂未签出";
        
        _checkoutImg.image = [[UIImage imageNamed:@"checkout_button"]imageWithTintColor:UIColorFromRGB(0xaaaaaaa)];
        
    }
    
}

@end
