//
//  CoursePlanBatchCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/3.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanBatchCell.h"

@interface CoursePlanBatchCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_imgView;
    
    UIImageView *_arrowView;
    
}

@end

@implementation CoursePlanBatchCell

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
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(50), Height320(50))];
        
        _imgView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(22), MSW-Width320(28.5)-_imgView.right, Height320(17))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), _titleLabel.width, Height320(15))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(13);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(35), Width320(7.5), Height320(12))];
        
        _arrowView.image = [UIImage imageNamed:@"gray_arrow"];
        
        [self.contentView addSubview:_arrowView];
        
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

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_imgView sd_setImageWithURL:_imgURL];
    
}


-(void)setType:(CourseType)type
{
    
    _type = type;
    
    if (_type == CourseTypeGroup) {
        
        _imgView.layer.cornerRadius = 0;
        
    }else
    {
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
    }
    
}

@end
