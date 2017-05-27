//
//  QualityListCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/3/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QualityListCell.h"

@interface QualityListCell ()

{
    
    UIView *_hideBack;
    
}

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)UILabel *validLabel;

@property(nonatomic,strong)UIImageView *verifiedImg;

@end

@implementation QualityListCell

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
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(20), Width320(175), Height320(18.5))];
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), _titleLabel.bottom+Height320(3.5), Width320(225), Height320(16))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(11);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _validLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), _subtitleLabel.bottom+Height320(3.5), Width320(225), Height320(16))];
        
        _validLabel.textColor = UIColorFromRGB(0x666666);
        
        _validLabel.font = AllFont(11);
        
        [self.contentView addSubview:_validLabel];
        
        _verifiedImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(21), Width320(14), Height320(14))];
        
        _verifiedImg.image = [UIImage imageNamed:@"ic_qc_identify"];
        
        [self.contentView addSubview:_verifiedImg];
        
        _verifiedImg.hidden = YES;
        
        UIImageView *cellarrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(24.5), Height320(22.5), Width320(6.5), Height320(10.5))];
        
        cellarrow.image = [UIImage imageNamed:@"cellarrow"];
        
        cellarrow.center = CGPointMake(cellarrow.center.x, Height320(48.5));
        
        [self.contentView addSubview:cellarrow];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(97)-1, MSW, 1)];
        
        sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:sep];
        
        _hideBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cellarrow.left, Height320(97)-1)];
        
        _hideBack.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6];
        
        _hideBack.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_hideBack];
        
        _hideBack.hidden = YES;
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel autoWidth];
    
    [_verifiedImg changeLeft:_titleLabel.right+Width320(8)];
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
    [_subtitleLabel autoWidth];
    
}

-(void)setValidTime:(NSString *)validTime
{
    
    _validTime = validTime;
    
    _validLabel.text = _validTime;
    
    [_validLabel autoWidth];
    
}

-(void)setIsVerified:(BOOL)isVerified
{
    
    _isVerified = isVerified;
    
    _verifiedImg.hidden = !_isVerified;
    
}


-(void)setIshideAnimated:(BOOL)isHide
{
    
    _isHide = isHide;
    
    _hideBack.hidden = !_isHide;
    
    if (_isHide) {
        
        _validLabel.text = @"已隐藏";
        
    }
    
}


@end
