//
//  StudentCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "StudentCell.h"

@interface StudentCell ()

{
    
    UILabel *_titleLabel;
    
    UIImageView *_imgView;
    
    UILabel *_phoneLabel;
        
    UIImageView *_sexImg;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation StudentCell


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
        
        _imgView.layer.borderWidth = OnePX;
        
        _imgView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        _imgView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(15), Width320(200), Height320(16))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_titleLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(4.4), Height320(17), Width320(12), Height320(12))];
        
        [self.contentView addSubview:_sexImg];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(4), Width320(200), Height320(17))];
        
        _phoneLabel.textColor = UIColorFromRGB(0x666666);
        
        _phoneLabel.font = AllFont(12);
        
        _phoneLabel.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_phoneLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(31), Height320(26), Width320(7), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        _arrowImg.center = CGPointMake(_arrowImg.center.x, _titleLabel.center.y);
        
        _arrowImg.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_arrowImg];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel  autoWidth];
    
    [_sexImg changeLeft:_titleLabel.right+Width320(4)];
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _phoneLabel.text = [NSString stringWithFormat:@"手机：%@",_phone];
    
}

-(void)setNoTitlePhone:(NSString *)noTitlePhone
{
    
    _noTitlePhone = noTitlePhone;
    
    _phoneLabel.text = _noTitlePhone;
    
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
    
    if (_imgUrl.absoluteString.length) {
        
        [_imgView sd_setImageWithURL:_imgUrl];
        
    }
    
}

@end
