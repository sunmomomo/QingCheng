//
//  RecordCalendarView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "RecordCalendarView.h"

@interface RecordCalendarView ()<UIScrollViewDelegate>

{
    
    UILabel *_yearLabel;
    
    UIButton *_subYearBtn;
    
    UIButton *_addYearBtn;
    
    UIImageView *_addImg;
    
    NSMutableArray *_buttonArray;
    
    UIScrollView *_buttonView;
    
    UIView *_lineView;
    
    UIScrollView *_contentView;
    
    NSInteger _nowYear;
    
    NSMutableArray *_tableViews;
    
}

@end

@implementation RecordCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *comps;
        
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        
        comps = [calendar components:unitFlags fromDate:[NSDate date]];
        
        _year = [comps year];
        
        _nowYear  = _year;
        
        NSInteger month = [comps month];
        
        self.currentMonth = month;
        
        _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2-Width320(28), Height320(10), Width320(56), Height320(14))];
        
        _yearLabel.text = [NSString stringWithFormat:@"%ld年",(long)_year];
        
        _yearLabel.textColor = UIColorFromRGB(0x999999);
        
        _yearLabel.textAlignment = NSTextAlignmentCenter;
        
        _yearLabel.font = AllFont(12);
        
        [self addSubview:_yearLabel];
        
        _subYearBtn = [[UIButton alloc]initWithFrame:CGRectMake(_yearLabel.left-Width320(11.5), Height320(8), Width320(11.5), Height320(20))];
        
        _subYearBtn.tag = 101;
        
        [self addSubview:_subYearBtn];
        
        [_subYearBtn addTarget:self action:@selector(yearChanged:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *subImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(4), Height320(4), Width320(7.5), Height320(12))];
        
        subImg.image = [UIImage imageNamed:@"gray_arrow_left"];
        
        [_subYearBtn addSubview:subImg];
        
        _addYearBtn = [[UIButton alloc]initWithFrame:CGRectMake(_yearLabel.right, Height320(8), Width320(11.5), Height320(20))];
        
        _addYearBtn.tag = 102;
        
        _addYearBtn.userInteractionEnabled = NO;
        
        [self addSubview:_addYearBtn];
        
        [_addYearBtn addTarget:self action:@selector(yearChanged:) forControlEvents:UIControlEventTouchUpInside];
        
        _addImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(4), Width320(7.5), Height320(12))];
        
        _addImg.image = [UIImage imageNamed:@"unable_gray_arrow"];
        
        [_addYearBtn addSubview:_addImg];
        
        _buttonView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height320(26), MSW, Height320(32))];
        
        _buttonView.contentSize = CGSizeMake(MSW*1.5, 0);
        
        _buttonView.scrollEnabled = NO;
        
        [self addSubview:_buttonView];
        
        _buttonArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i<12; i++) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(MSW/8*i, 0, MSW/8, Height320(32))];
            
            button.tag = i;
            
            [button setTitle:[NSString stringWithFormat:@"%ld月",(long)(i+1)] forState:UIControlStateNormal];
            
            [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(monthButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_buttonView addSubview:button];
            
            [_buttonArray addObject:button];
            
            if (i == month-1) {
                
                [button setTitleColor:kMainColor forState:UIControlStateNormal];
                
            }
            
        }
        
        if (month>10) {
            
            [_buttonView setContentOffset:CGPointMake(MSW/2, 0) animated:NO];
            
        }else if(month>5)
        {
            
            [_buttonView setContentOffset:CGPointMake(MSW/8*(month-5), 0) animated:NO];
            
        }
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake((month-1)*MSW/8, _buttonView.height-Height320(2), MSW/8, Height320(2))];
        
        _lineView.backgroundColor = kMainColor;
        
        [_buttonView addSubview:_lineView];
        
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _buttonView.bottom, MSW, frame.size.height-_buttonView.bottom)];
        
        _contentView.contentSize = CGSizeMake(MSW*12, 0);
        
        _contentView.delegate = self;
        
        _contentView.pagingEnabled = YES;
        
        [_contentView setContentOffset:CGPointMake((month-1)*MSW, 0) animated:NO];
        
        [self addSubview:_contentView];
        
    }
    return self;
}

-(void)yearChanged:(UIButton*)button
{
    
    if (button.tag == 101) {
        
        self.year = _year - 1;
        
    }else
    {
        
        self.year = _year+1;
        
    }
    
    [self.delegate yearChanged];
    
}

-(void)setYear:(NSInteger)year
{
    
    _year = year;
    
    _yearLabel.text = [NSString stringWithFormat:@"%ld年",(long)_year];
    
    if (_year >= _nowYear) {
        
        _addYearBtn.userInteractionEnabled = NO;
        
        _addImg.image = [UIImage imageNamed:@"unable_gray_arrow"];
        
    }else
    {
        
        _addYearBtn.userInteractionEnabled = YES;
        
        _addImg.image = [UIImage imageNamed:@"gray_arrow"];
        
    }
    
}

-(void)monthButtonClick:(UIButton*)button
{
    
    if (button.tag<4) {
        
        [_buttonView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }else if (button.tag>8){
        
        [_buttonView setContentOffset:CGPointMake(MSW/2, 0) animated:NO];
        
    }else
    {
        
        [_buttonView setContentOffset:CGPointMake(MSW/8*(button.tag-4), 0) animated:YES];
        
    }
    
    for (UIButton *btn in _buttonArray) {
        
        [btn setTitleColor:btn.tag == button.tag?kMainColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [_lineView changeLeft:button.tag*MSW/8];
        
    }];
    
    [_contentView setContentOffset:CGPointMake(button.tag*MSW, 0) animated:YES];
    
    self.currentMonth = button.tag+1;
    
    [self.delegate changedMonth:button.tag+1];
    
}

-(void)setDatasource:(id<RecordCalendarViewDatasource>)datasource
{
    
    _datasource = datasource;
    
    [self load];
    
}

-(void)load
{
    
    _tableViews = [NSMutableArray array];
    
    for (NSInteger i = 0; i<12; i++) {
        
        MOTableView *tableView = [self.datasource tableViewForMonth:i+1];
        
        [tableView changeLeft:i*MSW];
        
        [_contentView addSubview:tableView];
        
        [_tableViews addObject:tableView];
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger page = scrollView.contentOffset.x/MSW;
    
    if (page<4) {
        
        [_buttonView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }else if (page>8){
        
        [_buttonView setContentOffset:CGPointMake(MSW/2, 0) animated:NO];
        
    }else
    {
        
        [_buttonView setContentOffset:CGPointMake(MSW/8*(page-4), 0) animated:YES];
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [_lineView changeLeft:page*MSW/8];
        
    }];
    
    for (UIButton *btn in _buttonArray) {
        
        [btn setTitleColor:btn.tag == page?kMainColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
    }
    
    self.currentMonth = page+1;
    
    [self.delegate changedMonth:page+1];
    
}

-(void)reloadDataAtMonth:(NSInteger)month
{
    
    MOTableView *tableView = _tableViews[month-1];
    
    tableView.dataSuccess = YES;
    
    [tableView reloadData];
    
}

-(void)dealloc
{
    
    for (UIView *subView in _contentView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            if (((UIScrollView *)subView).mj_header) {
                
                ((UIScrollView *)subView).mj_header = nil;
                
            }
            
        }
        
    }
    
}

@end
