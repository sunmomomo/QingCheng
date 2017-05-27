//
//  CourseCoachRateController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseCoachRateController.h"

#import "CourseCoachRateView.h"

#import "CourseRateLabel.h"

#import "CourseCoachRateInfo.h"

@interface CourseCoachRateController ()<CourseCoachRateViewDelegate>

@property(nonatomic,strong)CourseCoachRateInfo *info;

@property(nonatomic,strong)CourseCoachRateView *coachView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *rateLabel;

@property(nonatomic,strong)UILabel *coachRateLabel;

@property(nonatomic,strong)NSArray *grades;

@property(nonatomic,strong)UIView *emptyView;

@end

@implementation CourseCoachRateController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    if (AppGym) {
        
        self.gym = AppGym;
        
    }
    
    [self setCoachRate:self.gym.rate.coachRate andCourseRate:self.gym.rate.courseRate andServiceRate:self.gym.rate.serviceRate];
    
    self.info = [[CourseCoachRateInfo alloc]init];
    
    [self.info requestWithCourse:self.course andGym:self.gym result:^(BOOL success, NSString *error) {
        
        [self.iconView sd_setImageWithURL:self.gym.imgUrl];
        
        self.nameLabel.text = self.gym.name;
        
        if (success) {
            
            [self setCoachRate:self.gym.rate.coachRate andCourseRate:self.gym.rate.courseRate andServiceRate:self.gym.rate.serviceRate];
            
            self.coachView.coaches = self.info.coaches;
            
            if (self.coachView.coaches.count) {
                
                self.emptyView.hidden = YES;
                
                Coach *coach = [self.info.coaches firstObject];
                
                [self setCoachCoachRate:coach.rate.coachRate andCourseRate:coach.rate.courseRate andServiceRate:coach.rate.serviceRate];
                
                [self setGrades:coach.rate.rates];
                
            }else{
                
                self.emptyView.hidden = NO;
                
                [self.view bringSubviewToFront:self.emptyView];
                
            }
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.course.name;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(167))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.masksToBounds = YES;
    
    [self.view addSubview:topView];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(12), Width320(40), Height320(40))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    [topView addSubview:self.iconView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(9), Height320(15), topView.width-Width320(10)-self.iconView.right-Width320(9), Height320(16))];
    
    self.nameLabel.textColor = UIColorFromRGB(0x33333);
    
    self.nameLabel.font = AllFont(14);
    
    [topView addSubview:self.nameLabel];
    
    self.rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom+Height320(4), self.nameLabel.width, Height320(14))];
    
    self.rateLabel.textColor = UIColorFromRGB(0x999999);
    
    self.rateLabel.font = AllFont(12);
    
    [topView addSubview:self.rateLabel];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(10), Height320(65)-1/[UIScreen mainScreen].scale, MSW-Width320(20), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, topView.height-1/[UIScreen mainScreen].scale, MSW, 1/[UIScreen mainScreen].scale)];
    
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:line];
    
    self.coachView = [[CourseCoachRateView alloc]initWithFrame:CGRectMake(0, Height320(65), MSW, topView.height-Height320(65))];
    
    self.coachView.delegate = self;
    
    [topView addSubview:self.coachView];
    
    self.coachRateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(18), MSW, Height320(16))];
    
    self.coachRateLabel.textAlignment = NSTextAlignmentCenter;
    
    self.coachRateLabel.textColor = UIColorFromRGB(0x999999);
    
    self.coachRateLabel.font = AllFont(12);
    
    [self.view addSubview:self.coachRateLabel];
    
    self.emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+Height320(64), MSW, MSH-64-Height320(64))];
    
    self.emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.emptyView];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(86), Height320(73), Width320(148), Height320(135))];
    
    emptyImg.image = [UIImage imageNamed:@"coach_rate_empty"];
    
    [self.emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(18))];
    
    emptyLabel.text = @"本课程暂无教练";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(14);
    
    [self.emptyView addSubview:emptyLabel];
    
}

-(void)setCoachRate:(float)coachRate andCourseRate:(float)courseRate andServiceRate:(float)serviceRate{
    
    NSString *firstRate = [NSString stringWithFormat:@"%.1f",coachRate];
    
    NSString *secondRate = [NSString stringWithFormat:@"%.1f",courseRate];
    
    NSString *thirtRate = [NSString stringWithFormat:@"%.1f",serviceRate];
    
    NSString *allStr = [NSString stringWithFormat:@"教练评分  %@    课程评分  %@    服务评分  %@",firstRate,secondRate,thirtRate];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:allStr];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(6, 3)];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(19, 3)];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(32, 3)];
    
    self.rateLabel.attributedText = astr;
    
}

-(void)setCoachCoachRate:(float)coachRate andCourseRate:(float)courseRate andServiceRate:(float)serviceRate{
    
    NSString *firstRate = [NSString stringWithFormat:@"%.1f",coachRate];
    
    NSString *secondRate = [NSString stringWithFormat:@"%.1f",courseRate];
    
    NSString *thirtRate = [NSString stringWithFormat:@"%.1f",serviceRate];
    
    NSString *allStr = [NSString stringWithFormat:@"教练评分  %@    课程评分  %@    服务评分  %@",firstRate,secondRate,thirtRate];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:allStr];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(6, 3)];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(19, 3)];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF9944E) range:NSMakeRange(32, 3)];
    
    self.coachRateLabel.attributedText = astr;
    
}

-(void)setGrades:(NSArray *)grades
{
    
    _grades = grades;
    
    for (UIView *subView in self.view.subviews) {
        
        if ([subView isKindOfClass:[CourseRateLabel class]]) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
    if (_grades.count) {
        
        float top = self.coachRateLabel.bottom+Height320(15);
        
        float right = Width320(30);
        
        for (NSInteger i = 0; i<_grades.count; i++) {
            
            CourseRateLabel *label = [[CourseRateLabel alloc]initWithFrame:CGRectMake(right, top, MAXFLOAT, Height320(26))];
            
            label.text = _grades[i];
            
            [label changeLeft:right];
            
            right += label.width+Width320(10);
            
            if (label.right>MSW-Width320(30)) {
                
                right = Width320(30);
                
                top = top+Height320(36);
                
                [label changeLeft:right];
                
                right += label.width+Width320(10);
                
                [label changeTop:top];
                
            }
            
            [self.view addSubview:label];
            
        }
        
    }else{
        
        CourseRateLabel *label = [[CourseRateLabel alloc]initWithFrame:CGRectMake(Width320(150), self.coachRateLabel.bottom+Height320(15), MAXFLOAT, Height320(26))];
        
        label.backgroundColor = UIColorFromRGB(0xffffff);
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.text = @"暂无印象";
        
        [label changeLeft:MSW/2-label.width/2];
        
        [self.view addSubview:label];
        
    }
    
}

-(void)rateViewDidSelectedCoachAtIndex:(NSInteger)index
{
    
    Coach *coach = self.info.coaches[index];
    
    self.grades = coach.rate.impressions;
    
    [self setCoachCoachRate:coach.rate.coachRate andCourseRate:coach.rate.courseRate andServiceRate:coach.rate.serviceRate];
    
}

@end
