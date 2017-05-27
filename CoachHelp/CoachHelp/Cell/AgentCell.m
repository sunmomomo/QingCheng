//
//  AgentCourseCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/9.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AgentCell.h"

@interface AgentCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation AgentCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(40), Height320(40))];
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(8), Height320(18), Width320(276)-_imgView.left, Height320(17))];
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(5), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(7.5), Height320(28.5), Width320(6.7), Height320(10.6))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:_arrowImg];
        
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

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    [_imgView sd_setImageWithURL:_imgUrl placeholderImage:[UIImage imageNamed:@"gymempty"]];
    
}

@end
