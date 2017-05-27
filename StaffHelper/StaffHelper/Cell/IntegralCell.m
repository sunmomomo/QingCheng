//
//  IntegralCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralCell.h"

@interface IntegralCell ()

{
    
    UIView *_backView;
    
    UILabel *_numberLabel;
    
    UIView *_numberBack;
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
    UIImageView *_sexImg;
    
    UILabel *_phoneLabel;
    
    UILabel *_integralLabel;
    
}

@end

@implementation IntegralCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(64))];
        
        _backView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.contentView addSubview:_backView];
        
        _numberBack = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(22), Width320(20), Height320(20))];
        
        _numberBack.layer.cornerRadius = _numberBack.width/2;
        
        _numberBack.layer.masksToBounds = YES;
        
        _numberBack.layer.borderWidth = Width320(3);
        
        [self.contentView addSubview:_numberBack];
        
        _numberLabel = [[UILabel alloc]initWithFrame:_numberBack.frame];
        
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        _numberLabel.font = AllFont(14);
        
        _numberLabel.layer.cornerRadius = _numberBack.width/2;
        
        _numberLabel.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_numberLabel];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(46), Height320(12), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(12), Height320(13), Width320(200), Height320(20))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.font = AllFont(14);
        
        [self.contentView addSubview:_nameLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.right+Width320(6), Height320(17), Width320(12), Height320(12))];
        
        [self.contentView addSubview:_sexImg];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(1), Width320(120), Height320(17))];
        
        _phoneLabel.textColor = UIColorFromRGB(0x999999);
        
        _phoneLabel.font = AllFont(12);
        
        [self.contentView addSubview:_phoneLabel];
        
        _integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(85), Height320(22), Width320(55), Height320(21))];
        
        _integralLabel.textColor = UIColorFromRGB(0xF9944E);
        
        _integralLabel.textAlignment = NSTextAlignmentRight;
        
        _integralLabel.font = AllFont(15);
        
        [self.contentView addSubview:_integralLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), Height320(26), Width320(7), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:arrow];
        
    }
    
    return self;
    
}

-(void)setNo:(NSInteger)no
{
    
    _no = no;
    
    switch (_no) {
            
        case 1:
            
            _numberLabel.textColor = UIColorFromRGB(0xffffff);
            
            _numberBack.backgroundColor = UIColorFromRGB(0xFFCB07);
            
            _numberBack.layer.borderColor = UIColorFromRGB(0xFDD748).CGColor;
            
            break;
            
        case 2:
            
            _numberLabel.textColor = UIColorFromRGB(0xffffff);
            
            _numberBack.backgroundColor = UIColorFromRGB(0xC3CAD1);
            
            _numberBack.layer.borderColor = UIColorFromRGB(0xDEE0E2).CGColor;
            
            break;
            
        case 3:
            
            _numberLabel.textColor = UIColorFromRGB(0xffffff);
            
            _numberBack.backgroundColor = UIColorFromRGB(0xFE9864);
            
            _numberBack.layer.borderColor = UIColorFromRGB(0xFFB995).CGColor;
            
            break;
            
        default:
            
            _numberLabel.textColor = UIColorFromRGB(0x999999);
            
            _numberBack.backgroundColor = [UIColor clearColor];
            
            _numberBack.layer.borderColor = [UIColor clearColor].CGColor;
            
            break;
            
    }
    
    _numberLabel.text = [NSString stringWithFormat:@"%ld",(long)_no];
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = _name;
    
    [_nameLabel autoWidth];
    
    [_sexImg changeLeft:_nameLabel.right+Width320(6)];
    
}

-(void)setSex:(SexType)sex
{
    
    _sex = sex;
    
    _sexImg.image = _sex == SexTypeMan?[UIImage imageNamed:@"sex_male"]:[UIImage imageNamed:@"sex_female"];
    
    if (!self.iconURL.absoluteString.length) {
        
        if (_sex == SexTypeMan) {
            
            _iconView.image = [UIImage imageNamed:@"img_default_student_male"];
            
        }else{
            
            _iconView.image = [UIImage imageNamed:@"img_default_student_female"];
            
        }
        
    }
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _phoneLabel.text = _phone;
    
}

-(void)setIntegral:(float)integral
{
    
    _integral = integral;
    
    _integralLabel.text = [NSString formatStringWithFloat:_integral];
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    if (_iconURL.absoluteString) {
        
        if ([_iconURL.absoluteString rangeOfString:@"!"].length) {
            
            [_iconView sd_setImageWithURL:[NSURL URLWithString:_iconURL.absoluteString]];
            
        }else{
            
            if ([_iconURL.absoluteString rangeOfString:@"!/watermark/"].length) {
                
                [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[_iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[_iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                
            }else if ([_iconURL.absoluteString rangeOfString:@"/watermark/"].length){
                
                [_iconView sd_setImageWithURL:[NSURL URLWithString:_iconURL.absoluteString]];
                
            }else{
                
                [_iconView sd_setImageWithURL:[NSURL URLWithString:[_iconURL.absoluteString stringByAppendingString:@"!small"]]];
                
            }
            
        }
        
    }
    
}

@end
