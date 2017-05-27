//
//  FollowRecordTextCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "FollowRecordTextCell.h"

@interface FollowRecordTextCell ()

{
    
    UILabel *_followerLabel;
    
    UILabel *_contentLabel;
    
    UIImageView *_textBackView;
    
    UIImageView *_iconView;
    
    UILabel *_dateLabel;
    
}

@end

@implementation FollowRecordTextCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(8), Width320(40), Height320(40))];
        
        _iconView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        _iconView.layer.borderWidth = 1;
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_iconView];
        
        _followerLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(12), Height320(6), MSW-_iconView.right-Width320(24), Height320(15))];
        
        _followerLabel.textColor = UIColorFromRGB(0x666666);
        
        _followerLabel.font = AllFont(11);
        
        [self.contentView addSubview:_followerLabel];
        
        _textBackView = [[UIImageView alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), _followerLabel.bottom+Height320(2), Width320(252), Height320(55))];
        
        _textBackView.image = [[UIImage imageNamed:@"follow_record_back"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        
        [self.contentView addSubview:_textBackView];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(9), Width320(222), Height320(100))];
        
        _contentLabel.textColor = UIColorFromRGB(0x333333);
        
        _contentLabel.font = AllFont(12);
        
        _contentLabel.numberOfLines = 0;
        
        [_textBackView addSubview:_contentLabel];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(160), _followerLabel.top, Width320(150), _followerLabel.height)];
        
        _dateLabel.textColor = UIColorFromRGB(0x999999);
        
        _dateLabel.font = AllFont(11);
        
        _dateLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_dateLabel];
        
    }
    
    return self;
    
}

-(void)setIconUrl:(NSURL *)iconUrl
{
    
    _iconUrl = iconUrl;
    
    if (_iconUrl.absoluteString) {
        
        if ([_iconUrl.absoluteString rangeOfString:@"!"].length) {
            
            [_iconView sd_setImageWithURL:[NSURL URLWithString:_iconUrl.absoluteString]];
            
        }else{
            
            if ([_iconUrl.absoluteString rangeOfString:@"!/watermark/"].length) {
                
                [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[_iconUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[_iconUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                
            }else if ([_iconUrl.absoluteString rangeOfString:@"/watermark/"].length){
                
                [_iconView sd_setImageWithURL:[NSURL URLWithString:_iconUrl.absoluteString]];
                
            }else{
                
                [_iconView sd_setImageWithURL:[NSURL URLWithString:[_iconUrl.absoluteString stringByAppendingString:@"!small"]]];
                
            }
            
        }
        
    }
    
}

-(void)setFollower:(NSString *)follower
{
    
    _follower = follower;
    
    _followerLabel.text = _follower;
    
}

-(void)setContent:(NSString *)content
{
    
    _content = content;
    
    _contentLabel.text = _content;
    
}

-(void)setDate:(NSString *)date
{
    
    _date = date;
    
    _dateLabel.text = date;
    
}

-(void)setContentSize:(CGSize)contentSize
{
    
    _contentSize = contentSize;
    
    [_contentLabel changeWidth:_contentSize.width];
    
    [_contentLabel changeHeight:_contentSize.height];
    
    [_textBackView changeHeight:_contentLabel.height+Height320(16)];
    
    [_textBackView changeWidth:_contentLabel.width+Width320(25)];
    
}

@end
