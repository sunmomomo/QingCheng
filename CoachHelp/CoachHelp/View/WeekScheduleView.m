//
//  WeekScheduleView.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/11/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "WeekScheduleView.h"

typedef enum : NSUInteger {
    WeekScheduleCellTypeCompleted,
    WeekScheduleCellTypeRest,
    WeekScheduleCellTypeRestCompleted,
    WeekScheduleCellTypeGroup,
    WeekScheduleCellTypePrivate,
} WeekScheduleCellType;

typedef enum : NSUInteger {
    ScheduleAgentViewTypeLeft,
    ScheduleAgentViewTypeRight,
    ScheduleAgentViewTypeLeftTop,
    ScheduleAgentViewTypeLeftBot,
    ScheduleAgentViewTypeRightTop,
    ScheduleAgentViewTypeRightBot,
} ScheduleAgentViewType;

@interface ScheduleAgentButton : UIButton

{
    
    UILabel *_titleLabel;
    
    UIImageView *_imageView;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)UIImage *image;

@end

@implementation ScheduleAgentButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(18), Height320(10), Width320(20), Height320(20))];
        
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.right+Width320(8), 0, frame.size.width-_imageView.right-Width320(8), frame.size.height)];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(13);
        
        [self addSubview:_titleLabel];
        
    }
    
    return self;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imageView.image = _image;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

@end

@interface ScheduleAgentView : UIView

{
    
    UIImageView *_backImgView;
    
}

@property(nonatomic,strong)ScheduleAgentButton *restButton;

@property(nonatomic,strong)ScheduleAgentButton *groupButton;

@property(nonatomic,strong)ScheduleAgentButton *privateButton;

@property(nonatomic,assign)ScheduleAgentViewType type;

@end

@implementation ScheduleAgentView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _backImgView.userInteractionEnabled = YES;
        
        _backImgView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        _backImgView.layer.shadowOpacity = 0.4;
        
        _backImgView.layer.shadowOffset = CGSizeMake(0, 2);
        
        [self addSubview:_backImgView];
        
        _restButton = [[ScheduleAgentButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/3)];
        
        _restButton.title = @"设置休息";
        
        _restButton.image = [UIImage imageNamed:@"agent_rest"];
        
        _restButton.tag = 0;
        
        [self addSubview:_restButton];
        
        _groupButton = [[ScheduleAgentButton alloc]initWithFrame:CGRectMake(0, _restButton.bottom, frame.size.width, frame.size.height/3)];
        
        _groupButton.title = @"代约团课";
        
        _groupButton.image = [UIImage qingchengImageWithName:@"agent_group"];
        
        _groupButton.tag = 1;
        
        [self addSubview:_groupButton];
        
        _privateButton = [[ScheduleAgentButton alloc]initWithFrame:CGRectMake(0, _groupButton.bottom, frame.size.width, frame.size.height/3)];
        
        _privateButton.title = @"代约私教";
        
        _privateButton.image = [UIImage qingchengImageWithName:@"agent_private"];
        
        _privateButton.tag = 2;
        
        [self addSubview:_privateButton];
        
    }
    
    return self;
    
}

-(void)setType:(ScheduleAgentViewType)type
{
    
    _type = type;
    
    switch (_type) {
        case ScheduleAgentViewTypeLeft:
            
            _backImgView.image = [UIImage imageNamed:@"schedule_agent_left"];
            
            break;
            
        case ScheduleAgentViewTypeLeftTop:
            
            _backImgView.image = [UIImage imageNamed:@"schedule_agent_left_top"];
            
            break;
            
        case ScheduleAgentViewTypeLeftBot:
            
            _backImgView.image = [UIImage imageNamed:@"schedule_agent_left_bot"];
            
            break;
            
        case ScheduleAgentViewTypeRight:
            
            _backImgView.image = [UIImage imageNamed:@"schedule_agent_right"];
            
            break;
            
        case ScheduleAgentViewTypeRightTop:
            
            _backImgView.image = [UIImage imageNamed:@"schedule_agent_right_top"];
            
            break;
            
        case ScheduleAgentViewTypeRightBot:
            
            _backImgView.image = [UIImage imageNamed:@"schedule_agent_right_bot"];
            
            break;
            
        default:
            break;
    }
    
}


@end

@interface WeekBackCell : UIButton

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,assign)BOOL isToday;

@property(nonatomic,strong)NSIndexPath *indexPath;

@end

@implementation WeekBackCell

-(void)setIsToday:(BOOL)isToday
{
    
    _isToday = isToday;
    
    self.backgroundColor = _isToday?UIColorFromRGB(0xECF9F1):UIColorFromRGB(0xffffff);
    
}

@end

@interface WeekScheduleCell : UIButton

{
    
    UILabel *_titleLabel;
    
    UILabel *_numberLabel;
    
    UIImageView *_imgView;
    
}

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)NSInteger number;

@property(nonatomic,copy)NSString *user;

@property(nonatomic,assign)WeekScheduleCellType type;

@end

@implementation WeekScheduleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.layer.masksToBounds = YES;
        
        self.layer.borderWidth = OnePX;
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(2), frame.size.width, Height320(24))];
        
        _titleLabel.font = AllFont(10);
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.numberOfLines = 2;
        
        _titleLabel.userInteractionEnabled = NO;
        
        [self addSubview:_titleLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(1.5), frame.size.height-Height320(12), Width320(10), Height320(10))];
        
        _imgView.image = [UIImage imageNamed:@"schedule_order_white"];
        
        _imgView.hidden = YES;
        
        [self addSubview:_imgView];
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(1.5), frame.size.height-Height320(16), frame.size.width-_imgView.right-Width320(3), Height320(15))];
        
        _numberLabel.textColor = UIColorFromRGB(0xffffff);
        
        _numberLabel.font = AllFont(10);
        
        _numberLabel.hidden = YES;
        
        _numberLabel.userInteractionEnabled = NO;
        
        [self addSubview:_numberLabel];
        
    }
    
    return self;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _titleLabel.text = _name;
    
}

-(void)setUser:(NSString *)user
{
    
    _user = user;
    
    _numberLabel.text = user;
    
}

-(void)setNumber:(NSInteger)number
{
    
    _number = number;
    
    _numberLabel.hidden = NO;
    
    if (!_number) {
        
        _imgView.hidden = YES;
        
        [_numberLabel changeLeft:Width320(1.5)];
        
        [_numberLabel changeWidth:self.width-Width320(3)];
        
    }else{
        
        _imgView.hidden = NO;
        
        [_numberLabel changeLeft:_imgView.right+Width320(1.5)];
        
        [_numberLabel changeWidth:self.width-_imgView.right-Width320(3)];
        
    }
    
}

-(void)setType:(WeekScheduleCellType)type
{
    
    _type = type;
    
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    switch (type) {
            
        case WeekScheduleCellTypeCompleted:
            
            self.backgroundColor = UIColorFromRGB(0xcccccc);
            
            self.layer.borderColor = UIColorFromRGB(0xaaaaaa).CGColor;
            
            break;
            
        case WeekScheduleCellTypeRestCompleted:
            
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.backgroundColor = UIColorFromRGB(0xcccccc);
            
            self.layer.borderColor = UIColorFromRGB(0xaaaaaa).CGColor;
            
            break;
            
        case WeekScheduleCellTypeRest:
            
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.backgroundColor = UIColorFromRGB(0xF69683);
            
            self.layer.borderColor = UIColorFromRGB(0xB87062).CGColor;
            
            break;
            
        case WeekScheduleCellTypeGroup:
            
            self.backgroundColor = UIColorFromRGB(0x7986CB);
            
            self.layer.borderColor = UIColorFromRGB(0x5A6498).CGColor;
            
            break;
            
        case WeekScheduleCellTypePrivate:
            
            self.backgroundColor = UIColorFromRGB(0x1CA5E7);
            
            self.layer.borderColor = UIColorFromRGB(0x147BAD).CGColor;
            
            break;
            
        default:
            break;
    }
    
}

@end

@interface WeekScheduleView ()<UIScrollViewDelegate>

{
    
    NSDate *_fromDate;
    
    UIView *_timeLine;
    
    ScheduleAgentView *_agentView;
    
    NSString *_currentDate;
    
    WeekBackCell *_currentCell;
    
    UIColor *_currentColor;
    
}

@end

@implementation WeekScheduleView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = OnePX;
        
        self.delegate = self;
        
        self.contentSize = CGSizeMake(0, Height320(50)*24);
        
        for (NSInteger i = 0 ; i<7; i++) {
            
            for (NSInteger j =0; j<24; j++) {
                
                WeekBackCell *cell = [[WeekBackCell alloc]initWithFrame:CGRectMake(MSW/8+i*MSW/8, j*Height320(50), MSW/8, Height320(50))];
                
                cell.indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                
                [cell addTarget:self action:@selector(weekBackClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:cell];
                
            }
            
        }
        
        for (NSInteger i = 0; i<25; i++) {
            
            CGFloat top;
            
            if (i == 0) {
                
                top = 0;
                
            }else if (i == 24){
                
                top = self.contentSize.height-Height320(14);
                
            }else{
                
                top = i*Height320(50)-Height320(7);
                
            }
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, top, MSW/8, Height320(14))];
            
            label.text = [NSString stringWithFormat:@"%02ld:00",(long)i];
            
            label.textColor = UIColorFromRGB(0x999999);
            
            label.textAlignment = NSTextAlignmentCenter;
            
            label.font = AllFont(11);
            
            [self addSubview:label];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(MSW/8, i*Height320(50), MSW-MSW/8, OnePX)];
            
            line.backgroundColor = UIColorFromRGB(0xdddddd);
            
            [self addSubview:line];
            
        }
        
        for (NSInteger i =0; i<7; i++) {
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(MSW/8+i*MSW/8, 0, OnePX, Height320(50)*24)];
            
            line.backgroundColor = UIColorFromRGB(0xdddddd);
            
            [self addSubview:line];
            
        }
        
        _timeLine = [[UIView alloc]initWithFrame:CGRectMake(Width320(38), -Height320(2), MSW-Width320(38), Height320(4))];
        
        [self addSubview:_timeLine];
        
        UIView *point = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(4), Height320(4))];
        
        point.backgroundColor = UIColorFromRGB(0xF9944E);
        
        point.layer.cornerRadius = point.width/2;
        
        point.layer.masksToBounds = YES;
        
        [_timeLine addSubview:point];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width320(4), _timeLine.height/2-Height320(1)/2, _timeLine.width-Width320(4), Height320(1))];
        
        line.backgroundColor = UIColorFromRGB(0xF9944E);
        
        [_timeLine addSubview:line];
        
        NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
        
        df1.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        df1.dateFormat = @"HH:mm";
        
        NSString *dateStr = [df1 stringFromDate:[NSDate date]];
        
        NSInteger hour = [[[dateStr componentsSeparatedByString:@":"] firstObject]integerValue];
        
        NSInteger min = [[[dateStr componentsSeparatedByString:@":"] lastObject]integerValue];
        
        _timeLine.center = CGPointMake(_timeLine.center.x, hour*Height320(50)+Height320(50)*min/60);
        
    }
    
    return self;
    
}

-(void)setDate:(NSDate *)date
{
    
    _date = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:_date];
    
    _fromDate = [NSDate dateWithTimeInterval:(theComponents.weekday-1)*-86400 sinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:_date]]];
    
    NSInteger days = [[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]timeIntervalSinceDate:_fromDate]/86400;
    
    for (UIView *subview in self.subviews) {
        
        if ([subview isKindOfClass:[WeekBackCell class]]) {
            
            WeekBackCell *cell = (WeekBackCell*)subview;
            
            cell.isToday = cell.indexPath.section == days;
            
            cell.date = [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:cell.indexPath.section*86400 sinceDate:_fromDate]];
            
        }
        
    }
    
}

-(void)setSchedules:(NSArray *)schedules
{
    
    _schedules = schedules;
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    
    df1.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df1.dateFormat = @"HH:mm";
    
    NSString *dateStr = [df1 stringFromDate:[NSDate date]];
    
    NSInteger hour = [[[dateStr componentsSeparatedByString:@":"] firstObject]integerValue];
    
    NSInteger min = [[[dateStr componentsSeparatedByString:@":"] lastObject]integerValue];
    
    _timeLine.center = CGPointMake(_timeLine.center.x, hour*Height320(50)+Height320(50)*min/60);
    
    if (_timeLine.center.y<self.height/2) {
        
        self.contentOffset = CGPointMake(0, 0);
        
    }else if (_timeLine.center.y+self.height/2>self.contentSize.height){
        
        self.contentOffset = CGPointMake(0, self.contentSize.height-self.height);
        
    }else{
        
        self.contentOffset = CGPointMake(0, _timeLine.center.y-self.height/2);
        
    }
    
    [self hideAgent];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *allArray = [NSMutableArray array];
        
        for (Programme *programme in _schedules) {
            
            BOOL haveClash = NO;
            
            for (NSMutableArray *tempArray in allArray) {
                
                for (Programme *tempProgramme in tempArray) {
                    
                    if ([tempProgramme haveClashWithProgramme:programme]) {
                        
                        [tempArray addObject:programme];
                        
                        haveClash = YES;
                        
                        break;
                        
                    }
                    
                }
                
            }
            
            if (!haveClash) {
                
                NSMutableArray *array = [NSMutableArray array];
                
                [array addObject:programme];
                
                [allArray addObject:array];
                
            }
            
        }
        
        NSMutableArray *finalArray = [NSMutableArray array];
        
        for (NSMutableArray *array in allArray) {
            
            [finalArray addObject:[@[[@[[array firstObject]]mutableCopy]]mutableCopy]];
            
        }
        
        for (NSInteger i = 0; i<allArray.count; i++) {
            
            NSMutableArray *tempArray = allArray[i];
            
            NSMutableArray *tempFinalArray = finalArray[i];
            
            for (NSInteger j =1; j<tempArray.count; j++) {
                
                Programme *tempProgramme = tempArray[j];
                
                BOOL find = NO;
                
                for (NSMutableArray *tempTempFinalArray in tempFinalArray) {
                    
                    BOOL clash = NO;
                    
                    for (Programme *tempFinalProgramme in tempTempFinalArray) {
                        
                        if ([tempProgramme haveClashWithProgramme:tempFinalProgramme]) {
                            
                            clash = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!clash) {
                        
                        [tempTempFinalArray addObject:tempProgramme];
                        
                        find = YES;
                        
                        break;
                        
                    }
                    
                }
                
                if (!find) {
                    
                    [tempFinalArray addObject:[@[tempProgramme]mutableCopy]];
                    
                }
                
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (UIView *subView in self.subviews) {
                
                if ([subView isKindOfClass:[WeekScheduleCell class]]) {
                    
                    [subView removeFromSuperview];
                    
                }
                
            }
            
            for (NSMutableArray *array in finalArray) {
                
                for (NSMutableArray *tempArray in array) {
                    
                    for (Programme *programme in tempArray) {
                        
                        programme.sameTimeProgramme = [array count];
                        
                        CGFloat left = [self indexOfProgramme:programme]*MSW/8+MSW/8/[array count]*[array indexOfObject:tempArray];
                        
                        CGFloat top = [[programme.startTime substringWithRange:NSMakeRange(11, 2)]integerValue]*Height320(50)+(float)[[programme.startTime substringWithRange:NSMakeRange(14, 2)]integerValue]/60*Height320(50);
                        
                        CGFloat width = MSW/8/[array count];
                        
                        CGFloat bottom = [[programme.endTime substringWithRange:NSMakeRange(11, 2)]integerValue]*Height320(50)+(float)[[programme.endTime substringWithRange:NSMakeRange(14, 2)]integerValue]/60*Height320(50);
                        
                        WeekScheduleCell *cell = [[WeekScheduleCell alloc]initWithFrame:CGRectMake(left+MSW/8, top, width-1, bottom-top-1)];
                        
                        cell.tag = [_schedules indexOfObject:programme];
                        
                        if ([[dateFormatter dateFromString:programme.startTime] timeIntervalSinceDate:[NSDate date]]<0) {
                            
                            if (programme.style == ProgrammeStyleRest) {
                                
                                cell.type = WeekScheduleCellTypeRestCompleted;
                                
                            }else{
                                
                                cell.type = WeekScheduleCellTypeCompleted;
                                
                            }
                            
                        }else if (programme.style == ProgrammeStyleRest){
                            
                            cell.type =WeekScheduleCellTypeRest;
                            
                        }else if (programme.courseType == CourseTypeGroup){
                            
                            cell.type = WeekScheduleCellTypeGroup;
                            
                        }else{
                            
                            cell.type = WeekScheduleCellTypePrivate;
                            
                        }
                        
                        cell.name = programme.style == ProgrammeStyleRest?@"休\n息":programme.title;
                        
                        if (programme.style != ProgrammeStyleRest) {
                            
                            cell.number = programme.total;
                            
                            if (programme.orders.count == 1) {
                                
                                cell.user = programme.orders[0][@"username"];
                                
                            }else{
                                
                                cell.user = [NSString stringWithFormat:@"%ld人",(long)programme.total];
                                
                            }
                            
                        }
                        
                        [cell addTarget:self action:@selector(programmeClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [self addSubview:cell];
                        
                    }
                    
                }
                
            }
            
            [self bringSubviewToFront:_timeLine];
            
        });
        
    });
    
}

-(void)programmeClick:(WeekScheduleCell*)cell
{
    
    [self hideAgent];
    
    Programme *programme = _schedules[cell.tag];
    
    if (programme.sameTimeProgramme<3) {
        
        if ([_datasource respondsToSelector:@selector(weekViewChooseProgramme:)]) {
            
            [self.datasource weekViewChooseProgramme:programme];
            
        }
        
    }else{
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        if ([_datasource respondsToSelector:@selector(weekViewChooseProgrammesWithDate:)]) {
            
            [self.datasource weekViewChooseProgrammesWithDate:[dateFormatter dateFromString:programme.startTime]];
            
        }
        
    }
    
}

-(NSInteger)indexOfProgramme:(Programme*)programme
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    
    df1.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df1.dateFormat = @"dd";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[dateFormatter dateFromString:programme.startTime]];
    
    return theComponents.weekday-1;
    
}

-(NSInteger)pretimeProgramme:(Programme*)programme
{
    
    NSInteger i = 0;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    for (Programme *tempProgramme in _schedules) {
        
        if ([programme haveClashWithProgramme:tempProgramme]) {
            
            if ([[dateFormatter dateFromString:tempProgramme.startTime]compare:[dateFormatter dateFromString:programme.startTime]]==NSOrderedAscending) {
                
                i++;
                
            }else if ([[dateFormatter dateFromString:tempProgramme.startTime]compare:[dateFormatter dateFromString:programme.startTime]]==NSOrderedSame){
                
                if (tempProgramme.programmeId>programme.programmeId) {
                    
                    i++;
                    
                }else if (tempProgramme.programmeId == programme.programmeId && tempProgramme.gym.gymId>programme.gym.gymId){
                    
                    i++;
                    
                }
                
            }
            
        }
        
    }
    
    dateFormatter = nil;
    
    return i;
    
}

-(void)weekBackClick:(WeekBackCell*)cell
{
    
    if (_currentCell) {
        
        [self hideAgent];
        
    }else{
        
        _currentCell = cell;
        
        _currentColor = cell.backgroundColor;
        
        cell.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _currentDate = cell.date;
        
        [self showAgentWithIndexPath:cell.indexPath];
        
    }
    
}

-(NSInteger)sametimePrograme:(Programme*)programme
{
    
    NSInteger i = 0;
    
    for (Programme *tempProgramme in _schedules) {
        
        if ([programme haveClashWithProgramme:tempProgramme]) {
            
            i ++;
            
        }
        
    }
    
    return i;
    
}

-(void)showAgentWithIndexPath:(NSIndexPath*)indexPath
{
    
    if (!_agentView) {
        
        _agentView = [[ScheduleAgentView alloc]initWithFrame:CGRectMake(0, 0, Width320(126), Height320(126))];
        
        [_agentView.restButton addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_agentView.groupButton addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_agentView.privateButton addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_agentView];
        
    }
    
    [_agentView changeTop:indexPath.row == 0?0:indexPath.row==23?self.contentSize.height-Height320(126):Height320(50)*indexPath.row+Height320(25)-Height320(63)];
    
    if (_agentView.top < self.contentOffset.y) {
        
        self.contentOffset = CGPointMake(0, _agentView.top);
        
    }else if (_agentView.bottom>self.contentOffset.y+self.height){
        
        self.contentOffset = CGPointMake(0, _agentView.bottom-self.height);
        
    }
    
    [self bringSubviewToFront:_agentView];
    
    _agentView.hidden = NO;
    
    if (indexPath.section>=3) {
        
        [_agentView changeLeft:(indexPath.section+1)*MSW/8+Width320(5)-Width320(126)];
        
        if (indexPath.row == 0) {
            
            _agentView.type = ScheduleAgentViewTypeRightTop;
            
        }else if (indexPath.row == 23){
            
            _agentView.type = ScheduleAgentViewTypeRightBot;
            
        }else{
            
            _agentView.type = ScheduleAgentViewTypeRight;
            
        }
        
    }else{
        
        [_agentView changeLeft:(indexPath.section+2)*MSW/8-Width320(5)];
        
        if (indexPath.row == 0) {
            
            _agentView.type = ScheduleAgentViewTypeLeftTop;
            
        }else if (indexPath.row == 23){
            
            _agentView.type = ScheduleAgentViewTypeLeftBot;
            
        }else{
            
            _agentView.type = ScheduleAgentViewTypeLeft;
            
        }
        
    }
    
}

-(void)agentClick:(ScheduleAgentButton*)button
{
    
    [self hideAgent];
    
    if ([_datasource respondsToSelector:@selector(agentClickWithType:andDate:)]) {
        
        [_datasource agentClickWithType:button.tag andDate:_currentDate];
        
    }
    
}

-(void)hideAgent
{
    
    _agentView.hidden = YES;
    
    _currentCell.backgroundColor = _currentColor;
    
    _currentCell = nil;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self hideAgent];
    
}

@end
