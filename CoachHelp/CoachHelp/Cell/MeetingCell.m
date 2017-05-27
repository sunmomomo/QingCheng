//
//  MeetingCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MeetingCell.h"

@interface MeetingCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_addressLabel;
    
    UIImageView *_imgView;
    
}

@end

@implementation MeetingCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(15.3), MSW-Width320(100), Height320(18))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3.7), Width320(200), Height320(16))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(13);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _subtitleLabel.bottom+Height320(3), MSW-_titleLabel.left-Width320(10), Height320(16))];
        
        _addressLabel.textColor = UIColorFromRGB(0x666666);
        
        _addressLabel.font = AllFont(13);
        
        [self.contentView addSubview:_addressLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(72), Height320(16), Width320(58), Height320(58))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imgView];
        
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

-(void)setAddress:(NSString *)address
{
    
    _address = address;
    
    _addressLabel.text = _address;
    
}

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_imgView sd_setImageWithURL:_imgURL];
    
}

@end
