//
//  SearchGymCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
}

@end

@implementation SearchCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), Height320(16), Width320(240), Height320(18))];
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(18))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
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
    
    [_iconView sd_setImageWithURL:_imgUrl];
    
}


@end
