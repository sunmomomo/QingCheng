//
//  CourseInfoView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseInfoView.h"

#import "UIImage+Category.h"

@interface CourseInfoView ()

{
    
    UIImageView *_imgView;
    
    UILabel *_nameLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_numLabel;
    
    UILabel *_capacityLabel;
    
    UILabel *_planLabel;
    
    UILabel *_suitTitleLabel;
    
    UILabel *_suitLabel;
    
    UIView *_sep;
    
    UIButton *_editButton;
    
    UILabel *_capacityTitleLabel;
    
    UILabel *_numTitleLabel;
    
    UILabel *_planTitleLabel;
    
}

@end

@implementation CourseInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(56), Height320(56))];
        
        _imgView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _imgView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
        
        [self addSubview:_imgView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(12), Height320(20), MSW-Width320(28)-_imgView.right, Height320(18))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.font = AllFont(16);
        
        [self addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(8), _nameLabel.width, Height320(15))];
        
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        
        _timeLabel.font = AllFont(13);
        
        [self addSubview:_timeLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), Height320(80), MSW-Width320(24), 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:sep];
        
        CGSize size = [@"单节可约人数" boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(15)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
        
        _capacityTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), sep.bottom+Height320(10), size.width, size.height)];
        
        _capacityTitleLabel.text = @"单节可约人数";
        
        _capacityTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _capacityTitleLabel.font = AllFont(13);
        
        [self addSubview:_capacityTitleLabel];
        
        _capacityLabel = [[UILabel alloc]initWithFrame:CGRectMake(_capacityTitleLabel.right+Width320(12), _capacityTitleLabel.top, MSW-Width320(24)-_capacityTitleLabel.right, _capacityTitleLabel.height)];
        
        _capacityLabel.textColor = UIColorFromRGB(0x333333);
        
        _capacityLabel.font = AllFont(13);
        
        [self addSubview:_capacityLabel];
        
        _numTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _capacityTitleLabel.bottom+Height320(6), size.width, size.height)];
        
        _numTitleLabel.text = @"最小上课人数";
        
        _numTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _numTitleLabel.font = AllFont(13);
        
        [self addSubview:_numTitleLabel];
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(_numTitleLabel.right+Width320(12), _numTitleLabel.top, MSW-Width320(24)-_numTitleLabel.right, _numTitleLabel.height)];
        
        _numLabel.textColor = UIColorFromRGB(0x333333);
        
        _numLabel.font = AllFont(13);
        
        [self addSubview:_numLabel];
        
        _planTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), _numTitleLabel.bottom+Height320(6), size.width, size.height)];
        
        _planTitleLabel.text = @"默认课程计划";
        
        _planTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _planTitleLabel.font = AllFont(13);
        
        [self addSubview:_planTitleLabel];
        
        _planLabel = [[UILabel alloc]initWithFrame:CGRectMake(_planTitleLabel.right+Width320(12), _planTitleLabel.top, MSW-Width320(24)-_planTitleLabel.right, _planTitleLabel.height)];
        
        _planLabel.textColor = UIColorFromRGB(0x333333);
        
        _planLabel.font = AllFont(13);
        
        [self addSubview:_planLabel];
        
        _suitTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_numTitleLabel.left, _planTitleLabel.bottom+Height320(6), _numTitleLabel.width, Height320(15))];
        
        _suitTitleLabel.text = @"适用场馆";
        
        _suitTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _suitTitleLabel.font = AllFont(13);
        
        [self addSubview:_suitTitleLabel];
        
        _suitLabel = [[UILabel alloc]initWithFrame:CGRectMake(_planLabel.left, _planLabel.bottom+Height320(4), _planLabel.width, Height320(15))];
        
        _suitLabel.textColor = UIColorFromRGB(0x333333);
        
        _suitLabel.font = AllFont(13);
        
        [self addSubview:_suitLabel];
        
        _sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), _suitLabel.bottom+Height320(14)-1/[UIScreen mainScreen].scale, MSW-Width320(24), 1/[UIScreen mainScreen].scale)];
        
        _sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_sep];
        
        _editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, _sep.bottom, MSW, Height320(36))];
        
        [self addSubview:_editButton];
        
        UIImageView *editImage = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(50), Height320(12), Width320(12), Height320(12))];
        
        editImage.image = [[UIImage imageNamed:@"navi_edit"] imageWithTintColor:UIColorFromRGB(0xcccccc)];
        
        [_editButton addSubview:editImage];
        
        UILabel *editLabel = [[UILabel alloc]initWithFrame:CGRectMake(editImage.right+Width320(6), 0, _editButton.width-editImage.right-Width320(6), _editButton.height)];
        
        editLabel.text = @"编辑基本信息";
        
        editLabel.textColor = UIColorFromRGB(0x999999);
        
        editLabel.font = AllFont(12);
        
        [_editButton addSubview:editLabel];
        
        [self changeHeight:_editButton.bottom];
        
    }
    
    return self;
    
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    
    [_editButton addTarget:target action:action forControlEvents:controlEvents];
    
}

-(void)setCourse:(Course *)course
{
    
    _course = course;
    
    if (_course.imgUrl.absoluteString) {
        
        if ([_course.imgUrl.absoluteString rangeOfString:@"!"].length) {
            
            [_imgView sd_setImageWithURL:[NSURL URLWithString:_course.imgUrl.absoluteString]];
            
        }else{
            
            if ([_course.imgUrl.absoluteString rangeOfString:@"!/watermark/"].length) {
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[_course.imgUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[_course.imgUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                
            }else if ([_course.imgUrl.absoluteString rangeOfString:@"/watermark/"].length){
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:_course.imgUrl.absoluteString]];
                
            }else{
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:[_course.imgUrl.absoluteString stringByAppendingString:@"!small"]]];
                
            }
            
        }
        
    }
    
    _nameLabel.text = _course.name;
    
    _timeLabel.text = [NSString stringWithFormat:@"时长%ldmin，累计%ld节",(long)_course.during,(long)_course.courseNum];
    
    if (course.type == CourseTypeGroup) {
        
        _capacityLabel.hidden = NO;
        
        _numLabel.hidden = NO;
        
        _planLabel.hidden = NO;
        
        _capacityTitleLabel.hidden = NO;
        
        _numTitleLabel.hidden = NO;
        
        _planTitleLabel.hidden = NO;
        
        _capacityLabel.text = [NSString stringWithFormat:@"%ld人",(long)_course.capacity];
        
        _numLabel.text = [NSString stringWithFormat:@"%ld人",(long)_course.minNumber];
        
        _planLabel.text = _course.meassure.name?_course.meassure.name:@"无";
        
        [_suitLabel changeTop:_planLabel.bottom+Height320(4)];
        
    }else{
        
        _capacityLabel.hidden = YES;
        
        _numLabel.hidden = YES;
        
        _planLabel.hidden = YES;
        
        _capacityTitleLabel.hidden = YES;
        
        _numTitleLabel.hidden = YES;
        
        _planTitleLabel.hidden = YES;
        
        [_suitLabel changeTop:_capacityLabel.top];
        
    }
    
    NSString *gymStr = @"";
    
    for (Gym *gym in _course.gyms) {
        
        gymStr = [gymStr stringByAppendingString:gym.name];
        
        if ([_course.gyms indexOfObject:gym]<_course.gyms.count-1) {
            
            gymStr = [gymStr stringByAppendingString:@"，"];
            
        }
        
    }
    
    [_suitLabel changeWidth:_numLabel.width];
    
    [_suitLabel changeHeight:Height320(5000)];
    
    _suitLabel.autoSizeText = gymStr;
    
    [_suitTitleLabel changeTop:_suitLabel.top];
    
    [_sep changeTop:_suitLabel.bottom+Height320(14)-1/[UIScreen mainScreen].scale];
    
    [_editButton changeTop:_sep.bottom];
    
    [self changeHeight:_editButton.bottom];
    
}

@end
