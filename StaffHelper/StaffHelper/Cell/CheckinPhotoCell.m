//
//  CheckinPhotoCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinPhotoCell.h"

@interface CheckinPhotoCell ()

{
    
    UILabel *_timeLabel;
    
    UILabel *_staffLabel;
    
    UIImageView *_imageView;
    
}

@end

@implementation CheckinPhotoCell

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
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(18), Width320(65), Height320(15))];
        
        timeLabel.text = @"操作时间：";
        
        timeLabel.textColor = UIColorFromRGB(0x999999);
        
        timeLabel.font = AllFont(13);
        
        [self.contentView addSubview:timeLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeLabel.right, timeLabel.top, Width320(160), Height320(15))];
        
        _timeLabel.textColor = UIColorFromRGB(0x333333);
        
        _timeLabel.font = AllFont(13);
        
        [self.contentView addSubview:_timeLabel];
        
        UILabel *staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeLabel.left, timeLabel.bottom+Height320(6), timeLabel.width, timeLabel.height)];
        
        staffLabel.text = @"操作员：";
        
        staffLabel.textColor = UIColorFromRGB(0x999999);
        
        staffLabel.font = AllFont(13);
        
        [self.contentView addSubview:staffLabel];
        
        _staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(_timeLabel.left, staffLabel.top, _timeLabel.width, _timeLabel.height)];
        
        _staffLabel.textColor = UIColorFromRGB(0x333333);
        
        _staffLabel.font = AllFont(13);
        
        [self.contentView addSubview:_staffLabel];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(64), Height320(13), Width320(48), Height320(48))];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imageView];
        
    }
    
    return self;
    
}

-(void)setStaffName:(NSString *)staffName
{
    
    _staffName = staffName;
    
    _staffLabel.text = _staffName;
    
}

-(void)setTime:(NSString *)time
{
    
    _time = time;
    
    _timeLabel.text = _time;
    
}

-(void)setImageURL:(NSURL *)imageURL
{
    
    _imageURL = imageURL;
    
    [_imageView sd_setImageWithURL:_imageURL];
    
}

@end
