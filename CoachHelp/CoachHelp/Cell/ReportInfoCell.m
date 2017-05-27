//
//  ReportInfoCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ReportInfoCell.h"

@interface ReportInfoCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_imgLabel;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation ReportInfoCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(17), Width320(35.5), Height320(35.5))];
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        _imgView.layer.borderColor = UIColorFromRGB(0x027423).CGColor;
        
        _imgView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_imgView];
        
        _imgLabel = [[UILabel alloc]initWithFrame:_imgView.frame];
        
        _imgLabel.textColor = UIColorFromRGB(0x666666);
                
        _imgLabel.textAlignment = NSTextAlignmentCenter;
        
        _imgLabel.font = AllFont(20);
        
        _imgLabel.layer.cornerRadius = _imgLabel.width/2;
        
        _imgLabel.layer.masksToBounds = YES;
        
        _imgLabel.layer.borderColor = UIColorFromRGB(0x666666).CGColor;
        
        _imgLabel.layer.borderWidth = 1;
        
        [self.contentView addSubview:_imgLabel];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(16), Height320(17.7), Width320(218), Height320(17.3))];
        
        _titleLabel.textColor = UIColorFromRGB(0x222222);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(15))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(13);
        
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
    
    if ([_title rangeOfString:@"null"].length) {
        
        _titleLabel.text = @"";
        
    }
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
    if ([_subtitle rangeOfString:@"null"].length) {
        
        _subtitleLabel.text = @"";
        
    }
    
}

-(void)setImgText:(NSString *)imgText
{
    
    _imgText = imgText;
    
    _imgView.hidden = YES;
    
    _imgLabel.hidden = NO;
    
    _imgLabel.text = _imgText;
    
}

-(void)setImg:(UIImage *)img
{
    
    _img = img;
    
    _imgView.image = _img;
    
    _imgLabel.hidden = YES;
    
    _imgView.hidden = NO;
    
}

@end
