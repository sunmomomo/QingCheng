//
//  CoursePictureCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePictureCell.h"

#import "HorizontalGradientView.h"

#import "UIImage+Category.h"

@interface CoursePictureButton : UIButton

{
    
    HorizontalGradientView *_labelBackView;
    
    UILabel *_userLabel;
    
    UIImageView *_eyeImg;
    
    UIImageView *_imageView;
    
    UILabel *_uploadLabel;
    
}

@property(nonatomic,copy)NSString *user;

@property(nonatomic,copy)NSString *uploader;

@property(nonatomic,copy)NSURL *imageURL;

@end

@implementation CoursePictureButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _imageView.layer.masksToBounds = YES;
        
        [self addSubview:_imageView];
        
        _labelBackView = [[HorizontalGradientView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, Height320(18))];
        
        _labelBackView.leftColor = [UIColor clearColor];
        
        _labelBackView.rightColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self addSubview:_labelBackView];
        
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-Width320(80), 0, Width320(80), Height320(18))];
        
        _userLabel.textAlignment = NSTextAlignmentRight;
        
        _userLabel.textColor = UIColorFromRGB(0xffffff);
        
        _userLabel.font = AllFont(10);
        
        [self addSubview:_userLabel];
        
        _eyeImg = [[UIImageView alloc]initWithFrame:CGRectMake(_userLabel.left-Width320(15), Height320(5), Width320(12), Height320(9))];
        
        _eyeImg.image = [UIImage imageNamed:@"eye"];
        
        [self addSubview:_eyeImg];
        
        _uploadLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(4), frame.size.height-Height320(18), frame.size.width-Width320(8), Height320(18))];
        
        _uploadLabel.textColor = UIColorFromRGB(0xffffff);
        
        _uploadLabel.font = AllFont(10);
        
        _uploadLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_uploadLabel];
        
    }
    
    return self;
    
}

-(void)setUser:(NSString *)user
{
    
    _user = user;
    
    if (_user.length) {
        
        [self addSubview:_labelBackView];
        
        [self addSubview:_userLabel];
        
        [self addSubview:_eyeImg];
        
        _userLabel.text = _user;
        
        CGSize size = [_user boundingRectWithSize:CGSizeMake(MAXFLOAT, _userLabel.height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_userLabel.font} context:nil].size;
        
        [_userLabel changeWidth:size.width];
        
        [_userLabel changeLeft:self.width-Width320(4)-size.width];
        
        [_labelBackView changeWidth:size.width+Width320(50)];
        
        [_labelBackView changeLeft:self.width-_labelBackView.width];
        
        [_labelBackView reload];
        
        [_eyeImg changeLeft:_userLabel.left-Width320(15)];
        
    }else{
        
        [_labelBackView removeFromSuperview];
        
        [_userLabel removeFromSuperview];
        
        [_eyeImg removeFromSuperview];
        
    }
    
}

-(void)setImageURL:(NSURL *)imageURL
{
    
    _imageURL = imageURL;
    
    [_imageView sd_setImageWithURL:_imageURL];
    
}

-(void)setUploader:(NSString *)uploader
{
    
    _uploader = uploader;
    
    if (_uploader.length) {
        
        _uploadLabel.text = [NSString stringWithFormat:@"由%@上传",_uploader];
        
    }
    
}

@end

@interface CoursePictureCell ()

{
    
    UIView *_mainView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIButton *_manageButton;
    
    UIView *_sep;
    
    UILabel *_emptyLabel;
    
}

@end

@implementation CoursePictureCell

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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(56))];
        
        _mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _mainView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _mainView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [self.contentView addSubview:_mainView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(8), Height320(10), MSW-Width320(60), Height320(18))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        [_mainView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.font = AllFont(12);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        [_mainView addSubview:_subtitleLabel];
        
        _manageButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(52), Height320(20), Width320(52), Height320(16))];
        
        [_mainView addSubview:_manageButton];
        
        UILabel *manageLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(4), 0, Width320(33), Height320(16))];
        
        manageLabel.textColor = UIColorFromRGB(0x0DB14B);
        
        manageLabel.text = @"管理";
        
        manageLabel.textAlignment = NSTextAlignmentCenter;
        
        manageLabel.font = AllFont(12);
        
        [_manageButton addSubview:manageLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(manageLabel.right, Height320(2), Width320(7), Height320(12))];
        
        arrowImg.image = [[UIImage imageNamed:@"gray_arrow"] imageWithTintColor:UIColorFromRGB(0x0DB14B)];
        
        [_manageButton addSubview:arrowImg];
        
        [_manageButton addTarget:self action:@selector(manageClick) forControlEvents:UIControlEventTouchUpInside];
        
        _sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(8), Height320(56)-1/[UIScreen mainScreen].scale, MSW-Width320(16), 1/[UIScreen mainScreen].scale)];
        
        _sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_mainView addSubview:_sep];
        
        _emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _sep.bottom, MSW, Height320(36))];
        
        _emptyLabel.text = @"本节课暂无照片";
        
        _emptyLabel.textColor = UIColorFromRGB(0x999999);
        
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        
        _emptyLabel.font = AllFont(12);
        
        [_mainView addSubview:_emptyLabel];
        
    }
    
    return self;
    
}

-(void)manageClick
{
    
    [self.delegate manageOfCoursePictureCellClick:self];
    
}

-(void)setPictures:(NSArray *)pictures
{
    
    _pictures = pictures;
    
    if (_pictures.count) {
        
        _sep.hidden = _emptyLabel.hidden = YES;
        
        [_mainView changeHeight:Height320(56)+Height320(106)*((_pictures.count-1)/3+1)+Height320(2)*((_pictures.count-1)/3)];
        
        for (UIView *subView in _mainView.subviews) {
            
            if ([subView isKindOfClass:[HorizontalGradientView class]]) {
                
                [subView removeFromSuperview];
                
            }
            
        }
        
        for (NSInteger i = 0 ; i<_pictures.count; i++) {
            
            CoursePicture *picture = _pictures[i];
            
            CoursePictureButton *pictureView = [[CoursePictureButton alloc]initWithFrame:CGRectMake(i%3*Width320(108),Height320(56)+i/3*Height320(108), Width320(106), Height320(106))];
            
            pictureView.imageURL = picture.imageURL;
            
            pictureView.user = picture.canSeeUserName;
            
            pictureView.uploader = picture.uploadStaffName;
            
            pictureView.tag = i;
            
            [pictureView addTarget:self action:@selector(pictureClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_mainView addSubview:pictureView];
            
        }
        
    }else{
        
        for (UIView *subView in _mainView.subviews) {
            
            if ([subView isKindOfClass:[CoursePictureButton class]]) {
                
                [subView removeFromSuperview];
                
            }
            
        }
        
        [_mainView changeHeight:Height320(93)];
        
        _sep.hidden = _emptyLabel.hidden = NO;
        
    }
    
}

-(void)pictureClick:(CoursePictureButton*)button
{
    
    [self.delegate pictureCell:self pictureSelectedAtIndex:button.tag];
    
}

-(void)setCourseName:(NSString *)courseName
{
    
    _courseName = courseName;
    
    _titleLabel.text = [NSString stringWithFormat:@"%@ 一 %@",_courseName,_coachName];
    
}

-(void)setCoachName:(NSString *)coachName
{
    
    _coachName = coachName;
    
    _titleLabel.text = [NSString stringWithFormat:@"%@ 一 %@",_courseName,_coachName];
    
}

-(void)setGymName:(NSString *)gymName
{
    
    _gymName = gymName;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"%@，%@",_gymName,_courseTime];
    
}

-(void)setCourseTime:(NSString *)courseTime
{
    
    _courseTime = courseTime;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"%@，%@",_gymName,_courseTime];
    
}

@end
