//
//  MyStudentCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MyStudentCell.h"

@interface MyStudentCell ()

{
    
    UIView *_circleView;
    
    UILabel *_titleLabel;
    
    UIImageView *_imgView;
    
    UILabel *_phoneLabel;
    
    UILabel *_gymLabel;
    
    UIImageView *_sexImg;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation MyStudentCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _circleView = [[UIView alloc]initWithFrame:CGRectMake(Width320(24.8), Height320(12.4), Width320(43.5), Height320(43.5))];
        
        _circleView.layer.cornerRadius = _circleView.width/2;
        
        _circleView.layer.borderWidth = 1.5;
        
        _circleView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_circleView];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_circleView.left+2, _circleView.top+2, _circleView.width-4, _circleView.height-4)];
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        _imgView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_circleView.right+Width320(11.5), Height320(12.4), Width320(200), Height320(17))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_titleLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(4.4), Height320(15), Width320(10.7), Height320(10.7))];
        
        [self.contentView addSubview:_sexImg];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(4), Width320(200), Height320(17))];
        
        _phoneLabel.textColor = UIColorFromRGB(0x666666);
        
        _phoneLabel.font = AllFont(12);
        
        _phoneLabel.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_phoneLabel];
        
        _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _phoneLabel.bottom+Height320(4), Width320(200), Height320(17))];
        
        _gymLabel.textColor = UIColorFromRGB(0x666666);
        
        _gymLabel.font = AllFont(12);
        
        _gymLabel.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_gymLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(25.3), Height320(17.7), Width320(6.7), Height320(10.7))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        _arrowImg.center = CGPointMake(_arrowImg.center.x, _titleLabel.center.y);
        
        _arrowImg.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_arrowImg];
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
        
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [self.contentView addGestureRecognizer:swipe];
        
    }
    
    return self;
    
}

-(void)swipe:(UISwipeGestureRecognizer*)swipe
{
    
    self.editing = YES;
    
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

-(void)setGymName:(NSString *)gymName
{
    
    _gymName = gymName;
    
    _gymLabel.text = _gymName;
    
}

-(void)setGender:(NSString *)gender
{
    
    _gender = gender;
    
    if ([_gender isEqualToString:@"男"]) {
        
        _sexImg.image = [UIImage imageNamed:@"sex_male"];
        
    }else
    {
        
        _sexImg.image = [UIImage imageNamed:@"sex_female"];
        
    }
    
}

-(void)setBorderColor:(UIColor *)borderColor
{
    
    _borderColor = borderColor;
    
    if (_circleView.layer.borderColor) {
        
        _circleView.layer.borderColor = [UIColor whiteColor].CGColor;
        
    }
    
    _circleView.layer.borderColor = _borderColor.CGColor;
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    if (_imgUrl.absoluteString.length) {
        
        [_imgView sd_setImageWithURL:_imgUrl];
        
    }else{
        
        _imgView.image = [UIImage imageNamed:[_gender isEqualToString:@"男"]?@"icon_male":@"icon_female"];
        
    }
    
}

@end
