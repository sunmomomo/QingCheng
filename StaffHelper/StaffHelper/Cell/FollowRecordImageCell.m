//
//  FollowRecordImageCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "FollowRecordImageCell.h"

@interface FollowRecordImageCell ()

{
    
    UILabel *_followerLabel;
    
    UIImageView *_imageView;
    
    UIImageView *_imageBackView;
    
    UIImageView *_iconView;
    
    UILabel *_dateLabel;
    
}

@end

@implementation FollowRecordImageCell

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
        
        _imageBackView = [[UIImageView alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), _followerLabel.bottom+Height320(2), Width320(252), Height320(55))];
        
        _imageBackView.userInteractionEnabled = YES;
        
        _imageBackView.image = [[UIImage imageNamed:@"follow_record_back"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        
        [self.contentView addSubview:_imageBackView];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(4), 1, Width320(122), Height320(76)-2)];
        
        _imageView.userInteractionEnabled = YES;
        
        [_imageBackView addSubview:_imageView];
        
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)]];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(160), _followerLabel.top, Width320(150), _followerLabel.height)];
        
        _dateLabel.textColor = UIColorFromRGB(0x999999);
        
        _dateLabel.font = AllFont(11);
        
        _dateLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_dateLabel];
        
    }
    
    return self;
    
}

-(void)imageClick:(UITapGestureRecognizer*)tap
{
    
    [self.delegate ImageCellClick:self.tag];
    
}

-(void)setFollower:(NSString *)follower
{
    
    _follower = follower;
    
    _followerLabel.text = _follower;
    
}

-(void)setImageUrl:(NSURL *)imageUrl
{
    
    _imageUrl = imageUrl;
    
    [_imageView sd_setImageWithURL:_imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [_imageView changeWidth:image.size.width*((Height320(76)-2)/image.size.height)];
        
        [_imageBackView changeWidth:_imageView.width+Width320(8)];
        
        [_imageBackView changeHeight:_imageView.height+Height320(1)];
        
    }];
    
}

-(void)setIconUrl:(NSURL *)iconUrl
{
    
    _iconUrl = iconUrl;
    
    [_iconView sd_setImageWithURL:_iconUrl];
    
}

-(void)setDate:(NSString *)date
{
    
    _date = date;
    
    _dateLabel.text = date;
    
}

@end
