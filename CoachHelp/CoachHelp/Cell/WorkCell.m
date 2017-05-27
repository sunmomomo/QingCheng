//
//  WorkCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WorkCell.h"

#define kColor UIColorFromRGB(0x2a804a)

@interface WorkCell ()

{
    
    UIView *_mainView;
    
    UILabel *_titleLabel;
    
    UILabel *_timeLabel;
    
    UIImageView *_iconView;
    
    UIImageView *_certificateImgView;
    
    UILabel *_jobLabel;
    
    UILabel *_summaryLabel;
    
    UILabel *_courseNumLabel;
    
    UILabel *_coursePeopleLabel;
    
    UILabel *_privateNumLabel;
    
    UILabel *_privatePeopleLabel;
    
    UILabel *_saleLabel;
    
    UIView *_firstView;
    
    UIView *_secondView;
    
    UIView *_thirdView;
    
}


@end

@implementation WorkCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(10), MSW, Height320(348))];
        
        _mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _mainView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _mainView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_mainView];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [_mainView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), Height320(20), MSW-_iconView.right-Width320(20), Height320(18.7))];
        
        _titleLabel.font = AllFont(14);
        
        [_mainView addSubview:_titleLabel];
        
        _certificateImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(42), Height320(41), Width320(14), Height320(14))];
        
        _certificateImgView.layer.cornerRadius = _certificateImgView.width/2;
        
        _certificateImgView.layer.masksToBounds = YES;
        
        _certificateImgView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _certificateImgView.layer.borderWidth = 1;
        
        _certificateImgView.image = [UIImage imageNamed:@"ic_qc_identify"];
        
        _certificateImgView.center = CGPointMake(_certificateImgView.center.x, _titleLabel.center.y);

        [_mainView addSubview:_certificateImgView];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), Width320(200), Height320(15))];
        
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
        _timeLabel.font = AllFont(11);
        
        [_mainView addSubview:_timeLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(72)-1, MSW, 1)];
        
        sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [_mainView addSubview:sep];
        
        UIImageView *jobImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), sep.bottom+Height320(11), Width320(14.4), Height320(16))];
        
        jobImg.image = [UIImage imageNamed:@"workcell1"];
        
        [_mainView addSubview:jobImg];
        
        _jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(jobImg.right+Width320(10), sep.bottom+Height320(4), Width320(260), Height320(32))];
        
        _jobLabel.textColor = UIColorFromRGB(0x666666);
        
        _jobLabel.font = AllFont(12);
        
        [_mainView addSubview:_jobLabel];
        
        UIImageView *summaryImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), jobImg.bottom+Height320(16), Width320(14.4), Height320(16))];
        
        summaryImg.image = [UIImage imageNamed:@"workcell2"];
        
        [_mainView addSubview:summaryImg];
        
        _summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_jobLabel.left, sep.bottom+Height320(45), Width320(260), Height320(40))];
        
        _summaryLabel.textColor = UIColorFromRGB(0x666666);
        
        _summaryLabel.font = AllFont(12);
        
        [_mainView addSubview:_summaryLabel];
        
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), Height320(93)+sep.bottom, MSW-Width320(40), Height320(52))];
        
        _firstView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        
        _firstView.layer.borderWidth = 1;
        
        [_mainView addSubview:_firstView];
        
        UIView *firstSep = [[UIView alloc]initWithFrame:CGRectMake(Width320(72), Height320(6), 1, _firstView.height-Height320(12))];
        
        firstSep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [_firstView addSubview:firstSep];
        
        UIImageView *firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(25), Height320(18), Width320(22), Height320(14))];
        
        firstImg.image = [UIImage imageNamed:@"workcell3"];
        
        [_firstView addSubview:firstImg];
        
        _courseNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstSep.right, Height320(7), (_firstView.width-firstSep.right)/2, Height320(21))];
        
        _courseNumLabel.textColor = kColor;
        
        _courseNumLabel.font = AllFont(14);
        
        _courseNumLabel.textAlignment = NSTextAlignmentCenter;
        
        [_firstView addSubview:_courseNumLabel];
        
        _coursePeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_courseNumLabel.right, _courseNumLabel.top, _courseNumLabel.width, _courseNumLabel.height)];
        
        _coursePeopleLabel.textAlignment = NSTextAlignmentCenter;
        
        _coursePeopleLabel.textColor = kColor;
        
        _coursePeopleLabel.font = AllFont(14);
        
        [_firstView addSubview:_coursePeopleLabel];
        
        UILabel *courseNumTitle = [[UILabel alloc]initWithFrame:CGRectMake(_courseNumLabel.left, _courseNumLabel.bottom, _courseNumLabel.width, _courseNumLabel.height)];
        
        courseNumTitle.text = @"团课节数";
        
        courseNumTitle.textColor = UIColorFromRGB(0x999999);
        
        courseNumTitle.textAlignment = NSTextAlignmentCenter;
        
        courseNumTitle.font = AllFont(11);
        
        [_firstView addSubview:courseNumTitle];
        
        UILabel *coursePeopleTitle = [[UILabel alloc]initWithFrame:CGRectMake(courseNumTitle.right, courseNumTitle.top, courseNumTitle.width, courseNumTitle.height)];
        
        coursePeopleTitle.text = @"服务人次";
        
        coursePeopleTitle.textAlignment = NSTextAlignmentCenter;
        
        coursePeopleTitle.textColor = UIColorFromRGB(0x999999);
        
        coursePeopleTitle.font = AllFont(11);
        
        [_firstView addSubview:coursePeopleTitle];
        
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), _firstView.bottom+Height320(6), MSW-Width320(40), Height320(52))];
        
        _secondView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        
        _secondView.layer.borderWidth = 1;
        
        [_mainView addSubview:_secondView];
        
        UIView *secondSep = [[UIView alloc]initWithFrame:CGRectMake(Width320(72), Height320(6), 1, _secondView.height-Height320(12))];
        
        secondSep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [_secondView addSubview:secondSep];
        
        UIImageView *secondImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(27), Height320(17), Width320(18), Height320(18))];
        
        secondImg.image = [UIImage imageNamed:@"workcell4"];
        
        [_secondView addSubview:secondImg];
        
        _privateNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(secondSep.right, Height320(7), (_secondView.width-secondSep.right)/2, Height320(21))];
        
        _privateNumLabel.textColor = kColor;
        
        _privateNumLabel.font = AllFont(14);
        
        _privateNumLabel.textAlignment = NSTextAlignmentCenter;
        
        [_secondView addSubview:_privateNumLabel];
        
        _privatePeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_privateNumLabel.right, _privateNumLabel.top, _privateNumLabel.width, _privateNumLabel.height)];
        
        _privatePeopleLabel.textAlignment = NSTextAlignmentCenter;
        
        _privatePeopleLabel.textColor = kColor;
        
        _privatePeopleLabel.font = AllFont(14);
        
        [_secondView addSubview:_privatePeopleLabel];
        
        UILabel *privateNumTitle = [[UILabel alloc]initWithFrame:CGRectMake(_privateNumLabel.left, _privateNumLabel.bottom, _privateNumLabel.width, _privateNumLabel.height)];
        
        privateNumTitle.text = @"私教节数";
        
        privateNumTitle.textColor = UIColorFromRGB(0x999999);
        
        privateNumTitle.textAlignment = NSTextAlignmentCenter;
        
        privateNumTitle.font = AllFont(11);
        
        [_secondView addSubview:privateNumTitle];
        
        UILabel *privatePeopleTitle = [[UILabel alloc]initWithFrame:CGRectMake(privateNumTitle.right, privateNumTitle.top, privateNumTitle.width, privateNumTitle.height)];
        
        privatePeopleTitle.text = @"服务人次";
        
        privatePeopleTitle.textAlignment = NSTextAlignmentCenter;
        
        privatePeopleTitle.textColor = UIColorFromRGB(0x999999);
        
        privatePeopleTitle.font = STFont(13);
        
        [_secondView addSubview:privatePeopleTitle];
        
        _thirdView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), _secondView.bottom+Height320(6), MSW-Width320(40), Height320(52))];
        
        _thirdView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
        
        _thirdView.layer.borderWidth = 1;
        
        [_mainView addSubview:_thirdView];
        
        UIView *thirdSep = [[UIView alloc]initWithFrame:CGRectMake(Width320(72), Height320(6), 1, _thirdView.height-Height320(12))];
        
        thirdSep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [_thirdView addSubview:thirdSep];
        
        UIImageView *thirdImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(26), Height320(16), Width320(20), Height320(20))];
        
        thirdImg.image = [UIImage imageNamed:@"workcell5"];
        
        [_thirdView addSubview:thirdImg];
        
        _saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(thirdSep.right, Height320(7), _thirdView.width-thirdSep.right, Height320(21))];
        
        _saleLabel.textColor = kColor;
        
        _saleLabel.font = AllFont(14);
        
        _saleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_thirdView addSubview:_saleLabel];
        
        UILabel *saleTitle = [[UILabel alloc]initWithFrame:CGRectMake(_saleLabel.left, _saleLabel.bottom, _saleLabel.width, _saleLabel.height)];
        
        saleTitle.text = @"销售额（元）";
        
        saleTitle.textColor = UIColorFromRGB(0x999999);
        
        saleTitle.textAlignment = NSTextAlignmentCenter;
        
        saleTitle.font = AllFont(11);
        
        [_thirdView addSubview:saleTitle];
        
    }
    
    return self;
    
}

-(void)setWork:(Work *)work
{
    
    _work = work;
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@|%@",work.title,work.gym.city]];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:NSMakeRange(astr.length-work.gym.city.length-1, work.gym.city.length+1)];
    
    [astr addAttribute:NSFontAttributeName value:STFont(13) range:NSMakeRange(astr.length-work.gym.city.length-1, work.gym.city.length+1)];
    
    _titleLabel.attributedText = astr;
    
    if (!work.gym.city.length) {
        
        _titleLabel.text = work.gym.name;
        
    }
    
    _titleLabel.numberOfLines = 0;
    
    CGSize size = [_titleLabel sizeThatFits:CGSizeMake(MSW-Width320(25)-_titleLabel.left, self.height)];
    
    [_titleLabel changeWidth:size.width];
    
    [_titleLabel changeHeight:size.height];
    
    [_certificateImgView changeLeft:_titleLabel.right+Width320(5)];
    
    _timeLabel.text = [NSString stringWithFormat:@"%@ 至%@",work.startTime,[work.endTime isEqualToString:@"3000-01-01"]?@"今":[@" " stringByAppendingString:work.endTime]];
    
    [_iconView sd_setImageWithURL:work.gym.imgUrl];
    
    _certificateImgView.hidden = !work.isVerified;
    
    _jobLabel.text = work.job;
    
    _summaryLabel.text = work.summary;
    
    [_summaryLabel autoHeight];
    
    _courseNumLabel.text = [NSString stringWithFormat:@"%ld",(long)work.group_course];
    
    _coursePeopleLabel.text = [NSString stringWithFormat:@"%ld",(long)work.group_user];
    
    _privateNumLabel.text = [NSString stringWithFormat:@"%ld",(long)work.private_course];
    
    _privatePeopleLabel.text = [NSString stringWithFormat:@"%ld",(long)work.private_user];
    
    _saleLabel.text = [NSString stringWithFormat:@"%ld",(long)work.sale];
    
    _firstView.hidden = NO;
    
    _secondView.hidden = NO;
    
    _thirdView.hidden = NO;
    
    [_firstView changeTop:Height320(165)];
    
    [_secondView changeTop:_firstView.bottom+Height320(6)];
    
    [_thirdView changeTop:_secondView.bottom+Height320(6)];
    
    [_mainView changeHeight:Height320(348)];
    
    if (!work.group_course && !work.group_user) {
        
        _firstView.hidden = YES;
        
        [_thirdView changeTop:_secondView.top];
        
        [_secondView changeTop:_firstView.top];
        
        [_mainView changeHeight:_mainView.height-Height320(58)];
        
    }
    
    if (!work.private_course && !work.private_user) {
        
        _secondView.hidden = YES;
        
        [_thirdView changeTop:_secondView.top];
        
        [_mainView changeHeight:_mainView.height-Height320(58)];
        
    }
    
    if (!work.sale) {
        
        _thirdView.hidden = YES;
        
        [_mainView changeHeight:_mainView.height-Height320(58)];
        
    }
    
    self.cellHeight = _mainView.bottom;
    
}


@end
