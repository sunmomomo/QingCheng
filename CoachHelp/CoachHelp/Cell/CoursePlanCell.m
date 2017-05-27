//
//  CoursePlanCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanCell.h"

@interface CoursePlanCell ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_imgView;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation CoursePlanCell

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
        
        self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(21), MSW-Width320(28)-_imgView.right, Height320(17))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(8), _titleLabel.width, Height320(15))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(13);
        
        [self.contentView addSubview:_subtitleLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(78), Height320(16), Width320(50), Height320(50))];
        
        _imgView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imgView];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5),Height320(34), Width320(7.5), Height320(12))];
        
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

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_imgView sd_setImageWithURL:_imgURL];
    
}

-(void)setOutTime:(BOOL)outTime
{
    
    _outTime = outTime;
    
    _titleLabel.textColor = _outTime?UIColorFromRGB(0x999999):UIColorFromRGB(0x333333);
    
    _subtitleLabel.textColor = _outTime?UIColorFromRGB(0x999999):UIColorFromRGB(0x666666);
    
    _imgView.layer.opacity = _outTime?0.6:1;
    
}


-(void)setType:(CourseType)type
{
    
    _type = type;
    
    if (_type == CourseTypePrivate) {
        
        _imgView.layer.cornerRadius = 0;
        
    }else
    {
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
    }
    
}

@end
