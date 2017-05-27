//
//  CourseMeassureCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseMeassureCell.h"

@interface CourseMeassureCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation CourseMeassureCell

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
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(18), MSW-Width320(64), Height320(18))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(32), Height320(30), Width320(16), Height320(12))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        [self.contentView addSubview:_chooseImg];
        
        _chooseImg.hidden = YES;
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

-(void)setIsChoosed:(BOOL)isChoosed
{
    
    _isChoosed = isChoosed;
    
    _chooseImg.hidden = !_isChoosed;
    
}

-(void)setIsUnused:(BOOL)isUnused
{
    
    _isUnused = isUnused;
    
    if (_isUnused) {
        
        [_titleLabel changeTop:Height320(27)];
        
        _subtitleLabel.hidden = YES;
    
    }else{
        
        [_titleLabel changeTop:Height320(18)];
        
        _subtitleLabel.hidden = NO;
        
    }
    
}

@end
