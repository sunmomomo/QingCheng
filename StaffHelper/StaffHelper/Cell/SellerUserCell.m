//
//  SellerUserCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellerUserCell.h"

@interface SellerUserCell ()

{
    
    UILabel *_titleLabel;
    
    UIImageView *_imgView;
    
    UILabel *_phoneLabel;
    
    UIImageView *_sexImg;
    
    UILabel *_sellerLabel;
    
    UIView *_typeColorView;
    
    UILabel *_typeLabel;
    
    UIView *_line;
    
}

@end

@implementation SellerUserCell

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
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(40), Height320(40))];
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(15), Width320(200), Height320(16))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        [self.contentView addSubview:_titleLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(4.4), Height320(17), Width320(12), Height320(12))];
        
        [self.contentView addSubview:_sexImg];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(4), Width320(200), Height320(14))];
        
        _phoneLabel.textColor = UIColorFromRGB(0x666666);
        
        _phoneLabel.font = AllFont(12);
        
        [self.contentView addSubview:_phoneLabel];
        
        _sellerLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _phoneLabel.bottom+Width320(2), Width320(228), Height320(14))];
        
        _sellerLabel.textColor = UIColorFromRGB(0x666666);
        
        _sellerLabel.font = AllFont(12);
        
        [self.contentView addSubview:_sellerLabel];
        
        _typeColorView = [[UIView alloc]initWithFrame:CGRectMake(Width320(253), Height320(18), Width320(6), Height320(6))];
        
        _typeColorView.layer.cornerRadius = _typeColorView.width/2;
        
        _typeColorView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_typeColorView];
        
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_typeColorView.right+Width320(4), Height320(14), Width320(36), Height320(13))];
        
        _typeLabel.textColor = UIColorFromRGB(0x999999);
        
        _typeLabel.font = AllFont(11);
        
        [self.contentView addSubview:_typeLabel];
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(Width320(68), Height320(76)-OnePX, MSW-Width320(68), OnePX)];
        
        _line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.contentView addSubview:_line];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    CGFloat maxWidth = _typeColorView.right - _titleLabel.left - 10 - _sexImg.width - Width320(4);
    
    [_titleLabel  autoWidthWithMaxWidth:maxWidth];
    
    [_sexImg changeLeft:_titleLabel.right+Width320(4)];
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _phoneLabel.text = _phone;
    
}

-(void)setSex:(SexType)sex
{
    
    _sex = sex;
    
    if (_sex == SexTypeMan) {
        
        _sexImg.image = [UIImage imageNamed:@"sex_male"];
        
    }else
    {
        
        _sexImg.image = [UIImage imageNamed:@"sex_female"];
        
    }
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    [_imgView sd_setImageWithURL:_imgUrl];
    
}

-(void)setSellers:(NSString *)sellers
{
    
    _sellers = sellers;
    
    _sellerLabel.text = [NSString stringWithFormat:@"销售：%@",_sellers.length?_sellers:@""];
    
}

-(void)setCoaches:(NSString *)coaches
{
    
    _coaches = coaches;
    
    if (_coaches.length) {
        
        _sellerLabel.text = [NSString stringWithFormat:@"教练：%@",_coaches];
        
        [_line changeTop:Height320(76)-OnePX];
        
    }else{
        
        _sellerLabel.text = @"";
        
        [_line changeTop:Height320(64)-OnePX];
        
    }
    
}

-(void)setUserType:(UserType)userType
{
    
    _userType = userType;
    
    if (_userType == UserTypeNewRegister) {
        
        _typeColorView.backgroundColor = UIColorFromRGB(0x6EB8F1);
        
        _typeLabel.text = @"新注册";
        
    }else if (_userType == UserTypeFollowing){
        
        _typeColorView.backgroundColor = UIColorFromRGB(0xF9944E);
        
        _typeLabel.text = @"已接洽";
        
    }else{
        
        _typeColorView.backgroundColor = UIColorFromRGB(0x0DB14B);
        
        _typeLabel.text = @"会员";
        
    }
    
}

-(void)setNoLine:(BOOL)noLine
{
    
    _noLine = noLine;
    
    _line.hidden = _noLine;
    
}

@end
