//
//  CourseCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 15/11/23.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CourseCell.h"

@interface CourseCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_typeImg;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation CourseCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(50), Height320(50))];
        
        _imgView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _imgView.layer.borderColor = [[UIColor blackColor]colorWithAlphaComponent:0.1].CGColor;
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imgView];
        
        _typeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(35), Height320(35), Width320(15), Height320(15))];
        
        _typeImg.layer.cornerRadius = _typeImg.width/2;
        
        [_imgView addSubview:_typeImg];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Width320(21), Width320(200), Height320(17))];
        
        _titleLabel.font = AllFont(15);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(8), Width320(200), Height320(15))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(13);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(25.8), 0, Width320(6.7), Height320(10.7))];
        
        _arrowImg.center = CGPointMake(_arrowImg.center.x, Height320(47.1));
        
        _arrowImg.image = [UIImage imageNamed:@"gray_arrow"];
        
        [self.contentView addSubview:_arrowImg];
        
        _arrowImg.hidden = NO;
        
    }
    
    return self;
    
}

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_imgView sd_setImageWithURL:_imgURL];
    
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

-(void)setCourseType:(CourseType)courseType
{
    
    _courseType = courseType;
    
    _typeImg.image = [UIImage imageNamed:_courseType == CourseTypeGroup?@"course_group":@"course_private"];
    
}


@end
