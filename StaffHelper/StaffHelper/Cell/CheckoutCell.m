//
//  CheckoutCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckoutCell.h"

#import "UIImage+Category.h"

@interface CheckoutCell ()

{
    
    UIView *_topView;
    
    UIView *_buttonView;
    
    UIButton *_iconView;
    
    UIImageView *_sexImg;
    
    UILabel *_nameLabel;
    
    UILabel *_phoneLabel;
    
    UILabel *_cardLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_chestLabel;
    
    UILabel *_timeLabel;
    
    UIButton *_ignoreButton;
    
    UIButton *_confirmButton;
    
    UIImageView *_confirmImg;
    
    UILabel *_confirmLabel;
    
    UIView *_hsep;
    
}

@end

@implementation CheckoutCell

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
        
        self.backgroundColor = [UIColor clearColor];
        
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(112))];
        
        _topView.backgroundColor = UIColorFromRGB(0x8CA3BA);
        
        _topView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_topView];
        
        _iconView = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(50), Height320(50))];
        
        _iconView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _iconView.layer.borderWidth = 1;
        
        [_iconView addTarget:self action:@selector(uploadPhoto) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(10), Height320(10), Width320(200), Height320(16))];
        
        _nameLabel.textColor = UIColorFromRGB(0xffffff);
        
        _nameLabel.font = AllFont(14);
        
        [_topView addSubview:_nameLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.right+Width320(5), Height320(13), Width320(12), Height320(12))];
        
        _sexImg.backgroundColor = UIColorFromRGB(0xffffff);
        
        _sexImg.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _sexImg.layer.borderWidth = 1;
        
        _sexImg.layer.cornerRadius = _sexImg.width/2;
        
        _sexImg.layer.masksToBounds = YES;
        
        [_topView addSubview:_sexImg];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(5), MSW-Width320(22)-_iconView.right, Height320(14))];
        
        _phoneLabel.textColor = UIColorFromRGB(0xffffff);
        
        _phoneLabel.font = AllFont(12);
        
        [_topView addSubview:_phoneLabel];
        
        _cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneLabel.left, _phoneLabel.bottom+Height320(3), _phoneLabel.width, Height320(14))];
        
        _cardLabel.textColor = UIColorFromRGB(0xffffff);
        
        _cardLabel.font = AllFont(12);
        
        _cardLabel.numberOfLines = 0;
        
        [_topView addSubview:_cardLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardLabel.left, _cardLabel.bottom+Height320(3), _cardLabel.width, _cardLabel.height)];
        
        _priceLabel.textColor = UIColorFromRGB(0xffffff);
        
        _priceLabel.font = AllFont(12);
        
        [_topView addSubview:_priceLabel];
        
        _chestLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardLabel.left, _priceLabel.bottom+Height320(3), _cardLabel.width, _cardLabel.height)];
        
        _chestLabel.textColor = UIColorFromRGB(0xffffff);
        
        _chestLabel.font = AllFont(12);
        
        [_topView addSubview:_chestLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardLabel.left, _priceLabel.bottom+Height320(3), _cardLabel.width, _cardLabel.height)];
        
        _timeLabel.textColor = UIColorFromRGB(0xffffff);
        
        _timeLabel.font = AllFont(12);
        
        [_topView addSubview:_timeLabel];
        
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom, MSW, Height320(40))];
        
        _buttonView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _buttonView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _buttonView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _buttonView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        _buttonView.layer.shadowOffset = CGSizeMake(0, 2);
        
        _buttonView.layer.shadowOpacity = 0.13;
        
        [self.contentView addSubview:_buttonView];
        
        _ignoreButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, MSW/2, Height320(40))];
        
        [_ignoreButton addTarget:self action:@selector(ignore) forControlEvents:UIControlEventTouchUpInside];
        
        [_buttonView addSubview:_ignoreButton];
        
        UIImageView *ignoreImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(51), Height320(13.5), Width320(14), Height320(12))];
        
        ignoreImg.image = [UIImage imageNamed:@"checkin_ignore"];
        
        [_ignoreButton addSubview:ignoreImg];
        
        UILabel *ignoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(ignoreImg.right+Width320(6), 0, Width320(40), Height320(40))];
        
        ignoreLabel.text = @"忽略";
        
        ignoreLabel.textColor = UIColorFromRGB(0x999999);
        
        ignoreLabel.font = AllFont(13);
        
        [_ignoreButton addSubview:ignoreLabel];
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2, 0, MSW/2, Height320(40))];
        
        [_buttonView addSubview:_confirmButton];
        
        _confirmImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(51), Height320(14), Width320(12), Height320(12))];
        
        _confirmImg.image = [[UIImage imageNamed:@"checkout_button"] imageWithTintColor:UIColorFromRGB(0xF9944E)];
        
        [_confirmButton addSubview:_confirmImg];
        
        _confirmLabel = [[UILabel alloc]initWithFrame:CGRectMake(_confirmImg.right+Width320(6), 0, Width320(70), Height320(40))];
        
        _confirmLabel.text = @"确认签出";
        
        _confirmLabel.textColor = UIColorFromRGB(0xF9944E);
        
        _confirmLabel.font = AllFont(13);
        
        [_confirmButton addSubview:_confirmLabel];
        
        _hsep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(10), 1/[UIScreen mainScreen].scale, Height320(20))];
        
        _hsep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_confirmButton addSubview:_hsep];
        
        [_confirmButton addTarget:self action:@selector(checkout) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    if (_iconURL.absoluteString.length) {
        
        [_iconView sd_setImageWithURL:_iconURL forState:UIControlStateNormal];
        
    }else{
        
        [_iconView setImage:[UIImage imageNamed:@"checkin_photo_add"] forState:UIControlStateNormal];
        
    }
    
}

-(void)uploadPhoto
{
    
    [self.delegate uploadPhotoWithCheckoutCell:self];
    
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

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _phoneLabel.text = [NSString stringWithFormat:@"手机：%@",_phone];
    
}

-(void)setCardName:(NSString *)cardName
{
    
    _cardName = cardName;
    
    _cardLabel.text = [NSString stringWithFormat:@"会员卡：%@",_cardName];
    
}

-(void)setRemain:(NSString*)remain
{
    
    _remain = remain;
    
    _cardLabel.text = [NSString stringWithFormat:@"会员卡：%@（%@）",_cardName,_remain];
    
    CGSize cardSize = [_cardLabel.text boundingRectWithSize:CGSizeMake(MSW-Width320(82), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [_cardLabel changeSize:cardSize];
    
    [_chestLabel changeTop:_cardLabel.bottom+Height320(3)];
    
    [_timeLabel changeTop:_chestLabel.top];
    
    [_topView changeHeight:_timeLabel.bottom+Height320(12)];
    
    [_buttonView changeTop:_topView.bottom];
    
}

-(void)setPrice:(NSString *)price
{
    
    _price = price;
    
    if (_price.length) {
        
        _priceLabel.hidden = NO;
        
        _priceLabel.text = [NSString stringWithFormat:@"费用：%@",_price];
        
        [_priceLabel changeTop:_cardLabel.bottom+Height320(3)];
        
        [_chestLabel changeTop:_priceLabel.bottom+Height320(3)];
        
        [_timeLabel changeTop:_chestLabel.top];
        
        [_topView changeHeight:_timeLabel.bottom+Height320(12)];
        
        [_buttonView changeTop:_topView.bottom];
        
    }else{
        
        _priceLabel.hidden = YES;
        
        _priceLabel.text = @"";
        
    }
    
}

-(void)setCheckinTime:(NSString *)checkinTime
{
    
    _checkinTime = checkinTime;
    
    _timeLabel.text = [NSString stringWithFormat:@"签到时间：%@",_checkinTime];
    
}

-(void)checkout
{
    
    [self.delegate checkoutCellCheckout:self];
    
}

-(void)ignore
{
    
    [self.delegate ignoreCheckoutWithCheckoutCell:self];
    
}

-(void)setChestName:(NSString *)chestName
{
    
    _chestName = chestName;
    
    if (_chestName) {
        
        _chestLabel.hidden = NO;
        
        _chestLabel.text = [NSString stringWithFormat:@"更衣柜号：%@",_chestName];
        
        [_timeLabel changeTop:_chestLabel.bottom+Height320(3)];
        
        [_topView changeHeight:_timeLabel.bottom+Height320(12)];
        
        [_buttonView changeTop:_topView.bottom];
        
    }else{
        
        _chestLabel.hidden = YES;
        
        _chestLabel.text = @"";
        
        [_timeLabel changeTop:_priceLabel.hidden?_cardLabel.bottom+Height320(3):_priceLabel.bottom+Height320(3)];
        
        [_topView changeHeight:_timeLabel.bottom+Height320(12)];
        
        [_buttonView changeTop:_topView.bottom];
        
    }
    
}

-(void)setNoIgnore:(BOOL)noIgnore
{
    
    _noIgnore = noIgnore;
    
    if (_noIgnore) {
        
        [_confirmButton changeLeft:0];
        
        [_confirmButton changeWidth:MSW];
        
        [_confirmImg changeLeft:Width320(124)];
        
        [_confirmLabel changeLeft:_confirmImg.right+Width320(6)];
        
        [_ignoreButton removeFromSuperview];
        
    }
    
}

@end
