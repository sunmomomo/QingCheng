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
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(62), Height320(16), Width320(50), Height320(50))];
        
        _imgView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(22), MSW-Width320(72), Height320(17))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(15);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), _titleLabel.width, Height320(15))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        _subtitleLabel.font = AllFont(13);
        
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

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    if (_imgURL.absoluteString) {
        
        if ([_imgURL.absoluteString rangeOfString:@"!"].length) {
            
            [_imgView sd_setImageWithURL:[NSURL URLWithString:_imgURL.absoluteString]];
            
        }else{
            
            if ([_imgURL.absoluteString rangeOfString:@"!/watermark/"].length) {
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[_imgURL.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[_imgURL.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                
            }else if ([_imgURL.absoluteString rangeOfString:@"/watermark/"].length){
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:_imgURL.absoluteString]];
                
            }else{
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:[_imgURL.absoluteString stringByAppendingString:@"!small"]]];
                
            }
            
        }
        
    }else{
        
        _imgView.image = [UIImage imageNamed:@"img_default_course"];
        
    }
    
}

-(void)setOutOfTime:(BOOL)outOfTime
{
    
    _outOfTime = outOfTime;
    
    _titleLabel.textColor = _outOfTime?UIColorFromRGB(0xb2b2b2):UIColorFromRGB(0x333333);
    
    _subtitleLabel.textColor = _outOfTime?UIColorFromRGB(0xb2b2b2):UIColorFromRGB(0x666666);
    
    _imgView.layer.opacity = _outOfTime?0.5:1;
    
}

@end
