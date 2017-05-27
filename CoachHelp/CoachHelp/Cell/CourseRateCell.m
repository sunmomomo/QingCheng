//
//  CourseRateCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseRateCell.h"

#import "CourseRateLabel.h"

@interface CourseRateCell ()

{
    
    UIView *_mainView;
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
    UILabel *_rateLabel;
    
    UIButton *_moreButton;
    
}

@end

@implementation CourseRateCell

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
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *mainBackView = [[UIView alloc]initWithFrame:CGRectMake(Width320(10), Height320(5), MSW-Width320(20), Height320(144))];
        
        mainBackView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        mainBackView.layer.shadowOffset = CGSizeMake(0, 2);
        
        mainBackView.layer.shadowOpacity = 0.17;
        
        [self.contentView addSubview:mainBackView];
        
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0,0,mainBackView.frame.size.width,mainBackView.frame.size.height)];
        
        _mainView.layer.cornerRadius = 2;
        
        _mainView.layer.masksToBounds = YES;
        
        _mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [mainBackView addSubview:_mainView];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(12), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [_mainView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(9), Height320(15), _mainView.width-Width320(10)-_iconView.right-Width320(9), Height320(16))];
        
        _nameLabel.textColor = UIColorFromRGB(0x33333);
        
        _nameLabel.font = AllFont(14);
        
        [_mainView addSubview:_nameLabel];
        
        _rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(4), _nameLabel.width, Height320(14))];
        
        _rateLabel.textColor = UIColorFromRGB(0x999999);
        
        _rateLabel.font = AllFont(12);
        
        [_mainView addSubview:_rateLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(64)-1/[UIScreen mainScreen].scale, _mainView.width, 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_mainView addSubview:sep];
        
        _moreButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(52.5), Height320(108), Width320(115), Height320(36))];
        
        [self.contentView addSubview:_moreButton];
        
        UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(4), 0, Width320(80), Height320(36))];
        
        moreLabel.text = @"查看评价详情";
        
        moreLabel.textColor = UIColorFromRGB(0x999999);
        
        moreLabel.font = AllFont(12);
        
        moreLabel.textAlignment = NSTextAlignmentCenter;
        
        [_moreButton addSubview:moreLabel];
        
        UIImageView *moreImg = [[UIImageView alloc]initWithFrame:CGRectMake(moreLabel.right, Height320(12), Width320(7), Height320(12))];
        
        moreImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [_moreButton addSubview:moreImg];
        
        [_moreButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _nameLabel.text = title;
    
}

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_iconView sd_setImageWithURL:_imgURL];
    
}

-(void)moreClick
{
    
    [self.delegate showDetailOfCourseRateCell:self];
    
}

-(void)setCoachRate:(float)coachRate andCourseRate:(float)courseRate andServiceRate:(float)serviceRate
{
    
    NSString *firstRate = [NSString stringWithFormat:@"%.1f",coachRate];
    
    NSString *secondRate = [NSString stringWithFormat:@"%.1f",courseRate];
    
    NSString *thirtRate = [NSString stringWithFormat:@"%.1f",serviceRate];
    
    NSString *allStr = [NSString stringWithFormat:@"教练评分  %@    课程评分  %@    服务评分  %@",firstRate,secondRate,thirtRate];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:allStr];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(6, 3)];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(19, 3)];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(32, 3)];
    
    _rateLabel.attributedText = astr;
    
}

-(void)setRates:(NSArray *)rates
{
    
    _rates = rates;
    
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[CourseRateLabel class]]) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
    if (rates.count) {
        
        float top = Height320(77);
        
        float right = Width320(30);
        
        for (NSInteger i = 0; i<rates.count; i++) {
            
            CourseRateLabel *label = [[CourseRateLabel alloc]initWithFrame:CGRectMake(right, top, MAXFLOAT, Height320(26))];
            
            label.text = rates[i];
            
            [label changeLeft:right];
            
            right += label.width+Width320(10);
            
            if (label.right>MSW-Width320(30)) {
                
                right = Width320(30);
                
                top = top+Height320(36);
                
                [label changeLeft:right];
                
                right = label.right+Width320(10);
                
                [label changeTop:top];
                
            }
            
            [_mainView addSubview:label];
            
        }
        
        [_moreButton changeTop:top+Height320(30)];
        
        [_mainView changeHeight:_moreButton.bottom];
        
    }else{
        
        CourseRateLabel *label = [[CourseRateLabel alloc]initWithFrame:CGRectMake(Width320(150), Height320(77), MAXFLOAT, Height320(26))];
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        label.text = @"暂无印象";
        
        [label changeLeft:(MSW-Width320(20))/2-label.width/2];
        
        [_mainView addSubview:label];
        
        [_moreButton changeTop:label.bottom+Height320(4)];
        
        [_mainView changeHeight:_moreButton.bottom];
        
    }
    
}

+(CGFloat)getHeightWithRates:(NSArray *)rates
{
    
    if (rates.count == 0) {
        
        return Height320(154);
        
    }else{
        
        CGFloat height = 0;
        
        float right = Width320(10);
        
        for (NSString *str in rates) {
            
            CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
            
            right += size.width+Width320(32)+Width320(10);
            
            if (right>MSW-Width320(20)) {
                
                right = Width320(10);
                
                right += size.width+Width320(32)+Width320(10);
                
                height += Height320(30);
    
            }
            
        }
        
        return height+Height320(77)+Height320(30)+Height320(36);
        
    }
    
}

@end
