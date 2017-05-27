//
//  CalendarView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/6.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CalendarView.h"

#define Font(a) [UIFont boldSystemFontOfSize:a]

#define kCalenderViewColor UIColorFromRGB(0x4e4e4e)

#define kDateNum 15

@interface ShowButton : UIButton

{
    
    UIImageView *_imgView;
    
}

@property(nonatomic,strong)UIImage *image;

@end

@implementation ShowButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(13), Height320(5), frame.size.width-Width320(26), frame.size.height-Height320(10))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.userInteractionEnabled = NO;
        
        [self addSubview:_imgView];
        
    }
    
    return self;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imgView.image = _image;
    
}

@end

@interface CalendarView ()<UIScrollViewDelegate>
{
    
    UIScrollView *_labelView;
    
    NSMutableArray *_labelArray;
    
    NSMutableArray *_dateArray;
    
    UIView *_subCalendarView;
    
    UIView *_lineView;
    
    UIScrollView *_contentView;
    
    NSMutableArray *_views;
    
}


@end

@implementation CalendarView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        [self load];
        
    }
    
    return self;
    
}

-(void)setDatasource:(id<CalendarViewDatasource>)datasource
{
    
    _datasource = datasource;
    
    for (MOTableView *tableView in _views) {
        
        tableView.dataSource = _datasource;
        
    }
    
    self.currentDate = [NSDate date];
    
}

-(void)setDelegate:(id<CalendarViewDelegate>)delegate
{
    
    _delegate = delegate;
    
    for (MOTableView *tableView in _views) {
        
        tableView.delegate = _delegate;
        
    }
    
}

-(void)load
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(54))];
    
    topView.backgroundColor = kCalenderViewColor;
    
    [self addSubview:topView];
    
    _dateArray = [NSMutableArray array];
    
    ShowButton *calendarBtn = [[ShowButton alloc]initWithFrame:CGRectMake(0, Height320(10.5), Width320(49), Height320(33))];
    
    [calendarBtn setImage:[UIImage imageNamed:@"ic_calendar"]];
    
    [calendarBtn addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:calendarBtn];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(calendarBtn.right+Width320(2), Height320(13), 1, Height320(30))];
    
    sep.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6];
    
    [topView addSubview:sep];
    
    _labelView = [[UIScrollView alloc]initWithFrame:CGRectMake(sep.right+Width320(2), 0, MSW-sep.right, Height320(54))];
    
    _labelView.showsHorizontalScrollIndicator = NO;
    
    _labelView.contentSize = CGSizeMake(Width320(45.7)*kDateNum+Width320(3.5)*(kDateNum-1), 0);
    
    _labelView.delegate = self;
    
    _labelView.tag = 102;
    
    [_labelView setContentOffset:CGPointMake(Width320(45.7)*kDateNum/3+Width320(3.5)*kDateNum/3, 0) animated:NO];
    
    [topView addSubview:_labelView];
    
    _labelArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i<kDateNum; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*Width320(49.2), 0, Width320(45.7), Height320(54))];
        
        btn.titleLabel.numberOfLines = 2;
        
        btn.tag = i;
        
        btn.titleLabel.font = AllFont(13.5);
        
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i == (kDateNum/2)) {
            
            [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
            
        }else
        {
            
            [btn setTitleColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
            
        }
        
        [btn addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_labelView addSubview:btn];
        
        [_labelArray addObject:btn];
        
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(_labelView.left+Width320(49.2)*2, _labelView.bottom-3, Width320(45.7), 3)];
    
    _lineView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [topView addSubview:_lineView];
    
    self.backgroundColor = kCalenderViewColor;
    
    [self setlabelWithDate:[NSDate date]];
    
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, self.height-topView.bottom)];
    
    _contentView.contentSize = CGSizeMake(MSW*3, 0);
    
    _contentView.delegate = self;
    
    _contentView.tag = 101;
    
    _contentView.pagingEnabled = YES;
    
    _contentView.bounces = NO;
    
    _contentView.showsHorizontalScrollIndicator = NO;
    
    _views = [NSMutableArray array];
    
    for (NSInteger i=0; i<3; i++) {
        
        MOTableView *tableView = [[MOTableView alloc]initWithFrame:CGRectMake(i*MSW, 0, MSW, _contentView.height) style:UITableViewStylePlain];
        
        tableView.tag = 201+i;
        
        tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        tableView.tableFooterView = [UIView new];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, tableView.height)];
        
        UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(Width320(66), 0, 2, tableView.height)];
        
        grayView.backgroundColor = UIColorFromRGB(0xe4e4e4);
        
        [view addSubview:grayView];
        
        tableView.backgroundView = view;
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTableView)];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        
        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        
        [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
        
        [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
        
        header.stateLabel.textColor = [UIColor blackColor];
        
        tableView.mj_header = header;
        
        [_contentView addSubview:tableView];
        
        [_views addObject:tableView];
        
    }
    
    
    [self addSubview:_contentView];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, _contentView.top, Width320(30), _contentView.height)];
    
    leftView.backgroundColor = [UIColor clearColor];
    
    leftView.userInteractionEnabled = YES;
    
    [self addSubview:leftView];
    
}


-(void)reloadTableView
{
    
    if ([self.datasource respondsToSelector:@selector(reloadTodayData)]) {
        
        [self.datasource reloadTodayData];
        
    }
    
}


-(void)labelClick:(UIButton*)btn
{
    
    self.currentDate = _dateArray[btn.tag];
    
}

-(void)setlabelWithDate:(NSDate *)date
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [df setDateFormat:@"EEE\nMM.dd"];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    
    df1.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    [df1 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startDate = [NSDate dateWithTimeInterval:-86400*(kDateNum/2) sinceDate:date];
    
    [_dateArray removeAllObjects];
    
    for (NSInteger i = 0; i<_labelArray.count; i++) {
        
        NSDate *tempDate = [NSDate dateWithTimeInterval:86400*i sinceDate:startDate];
        
        [_dateArray addObject:tempDate];
        
        NSString *dateStr = [df stringFromDate:tempDate];
        
        UIButton *btn = _labelArray[i];
        
        [btn setTitle:dateStr forState:UIControlStateNormal];
        
        if (btn.tag == kDateNum/2) {
            
            [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
            
        }else
        {
            
            [btn setTitleColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
            
        }
        
    }
    
    [_labelView setContentOffset:CGPointMake(Width320(49.2)*5, 0) animated:NO];
    
}

-(void)reload
{
    
    for (MOTableView *tableView in _views) {
        
        [tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        
        [tableView reloadData];
        
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (scrollView.tag == 102) {
        
        NSInteger x = scrollView.contentOffset.x/Width320(49.2);
        
        NSDate *startDate = [NSDate dateWithTimeInterval:-86400*(kDateNum/2) sinceDate:_currentDate];
        
        if (scrollView.contentOffset.x>(x+0.5)*Width320(49.2)) {
            
            [_labelView setContentOffset:CGPointMake(Width320(49.2)*(x+1), 0) animated:YES];
            
            for (UIButton *btn in _labelArray) {
                
                if (btn.tag == x+3) {
                    
                    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                    
                }else
                {
                    
                    [btn setTitleColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
                    
                }
                
            }
            
            self.currentDate = [NSDate dateWithTimeInterval:(x+3)*86400 sinceDate:startDate];
            
        }else{
            
            [_labelView setContentOffset:CGPointMake(Width320(49.2)*x, 0) animated:YES];
            
            for (UIButton *btn in _labelArray) {
                
                if (btn.tag == x+2) {
                    
                    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                    
                }else
                {
                    
                    [btn setTitleColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
                    
                }
                
            }
            
            self.currentDate = [NSDate dateWithTimeInterval:(x+2)*86400 sinceDate:startDate];
            
        }
        
        //        [_labelView setContentOffset:CGPointMake(Width320(49.2)*kDateNum/3, 0) animated:NO];
        
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 101) {
        
        NSInteger x = scrollView.contentOffset.x;
        
        if (x == MSW*2) {
            
            scrollView.scrollEnabled = NO;
            
            [_datasource setSliderable:NO];
            
            self.currentDate = [NSDate dateWithTimeInterval:86400 sinceDate:_currentDate];
            
        }else if(x == 0)
        {
            
            scrollView.scrollEnabled = NO;
            
            [_datasource setSliderable:NO];
            
            self.currentDate = [NSDate dateWithTimeInterval:-86400 sinceDate:_currentDate];
            
        }
        
    }else
    {
        
        NSInteger x = scrollView.contentOffset.x/Width320(49.2);
        
        NSDate *startDate = [NSDate dateWithTimeInterval:-86400*(kDateNum/2) sinceDate:_currentDate];
        
        if (scrollView.contentOffset.x>x*Width320(49.2)) {
            
            [_labelView setContentOffset:CGPointMake(Width320(49.2)*(x+1), 0) animated:YES];
            
            for (UIButton *btn in _labelArray) {
                
                if (btn.tag == x+3) {
                    
                    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                    
                }else
                {
                    
                    [btn setTitleColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
                    
                }
                
            }
            
            self.currentDate = [NSDate dateWithTimeInterval:(x+3)*86400 sinceDate:startDate];
            
        }else{
            
            [_labelView setContentOffset:CGPointMake(Width320(49.2)*x, 0) animated:YES];
            
            for (UIButton *btn in _labelArray) {
                
                if (btn.tag == x+2) {
                    
                    [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
                    
                }else
                {
                    
                    [btn setTitleColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
                    
                }
                
            }
            
            self.currentDate = [NSDate dateWithTimeInterval:(x+2)*86400 sinceDate:startDate];
            
        }
        //        [_labelView setContentOffset:CGPointMake(Width320(49.2)*kDateNum/3, 0) animated:NO];
        
    }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 101) {
        
        [_datasource setSliderable:YES];
        
        scrollView.scrollEnabled = YES;
        
    }
    
}

-(void)reloadContent
{
    
    [_contentView setContentOffset:CGPointMake(MSW, 0) animated:NO];
    
}

-(void)setCurrentDate:(NSDate *)currentDate
{
    
    _currentDate = currentDate;
    
    [self setlabelWithDate:_currentDate];
    
    [_datasource reloadCalendarData];
    
    [_datasource getDate];
    
}

-(void)calendarClick:(UIButton*)btn
{
    
    [_delegate calendarClick];
    
}

-(void)endRefresh
{
    
    for (MOTableView *tableView in _views) {
        
        tableView.dataSuccess = YES;
        
        if (tableView.tag == 202) {
            
            [tableView.mj_header endRefreshing];
            
        }
        
    }
    
}

-(void)dealloc
{
    
    for (UIView *subView in _contentView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            if (((UIScrollView *)subView).mj_header) {
                
                ((UIScrollView *)subView).mj_header = nil;
                
            }
            
        }
        
        [subView removeFromSuperview];
        
    }
    
    [self removeAllView];
    
}

@end
