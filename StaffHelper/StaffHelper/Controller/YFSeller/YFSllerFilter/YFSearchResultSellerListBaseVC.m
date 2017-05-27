//
//  YFSearchResultSellerListBaseVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultSellerListBaseVC.h"

#import "SellerUserEditCell.h"

#import "YFAppConfig.h"

#import "YFEmptyView.h"

@interface YFSearchResultSellerListBaseVC ()

@property(nonatomic, strong)UILabel *tableFootLabel;
@property(nonatomic, strong)UIView *tableFootView;
@property(nonatomic, strong)UIView *emptyView;

@end

@implementation YFSearchResultSellerListBaseVC
{
    CGRect _frame;
    YFEmptyView *_emptyViewYF;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navi removeFromSuperview];
    
    self.view.frame = _frame;
    [self creatUI];
    self.view.hidden = YES;
}

- (void)creatUI
{
    self.tableView = [[MOTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.tag = 101;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(96), 0, 0);
    
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [mjHeader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [mjHeader setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [mjHeader setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    mjHeader.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = mjHeader;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];

}

- (void)changeToFrame:(CGRect)frame
{
    self.view.frame = frame;
    self.tableView.frame = self.view.bounds;
}

- (void)setSearchStr:(NSString *)searchStr
{
    _searchStr = searchStr;
    
    if (_searchStr.length == 0) {
        self.view.hidden = YES;
        [self clearAllData];
    }
    else
    {
        self.view.hidden = NO;
        [self reloadData];
    }
}

- (void)clearAllData
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"12"];
}

-(UIView *)tableFootView
{
    if (!_tableFootView)
    {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 44)];
        _tableFootView.backgroundColor = YFGrayViewColor;
        CGFloat labelWidth = 70;
        _tableFootLabel = [[UILabel alloc] initWithFrame:CGRectMake((_tableFootView.width - labelWidth) / 2.0, 0, labelWidth, 44)];
        _tableFootLabel.backgroundColor = YFGrayViewColor;
        _tableFootLabel.textColor = RGB_YF(153, 153, 153);
        _tableFootLabel.font = FontSizeFY(12.0);
        _tableFootLabel.textAlignment = NSTextAlignmentCenter;
        [_tableFootView addSubview:_tableFootLabel];
        
        CGFloat lineViewWidth = 0.25 * _tableFootView.width;;
        CGFloat lineViewxx1 = _tableFootLabel.left - lineViewWidth - 10;
        CGFloat lineViewxx2 = _tableFootLabel.right + 10;
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx1, _tableFootView.height / 2.0, lineViewWidth, 0.5)];
        lineView1.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx2, _tableFootView.center.y, lineViewWidth, 0.5)];
        lineView2.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView2];
        
        self.tableView.backgroundColor = _tableFootView.backgroundColor;
    }
    
    return _tableFootView;
}


- (void)setTableFootviewLabelNum:(NSInteger )count
{
    
//    count = 0;
    //    搜索全部会员，无搜索结果
    if (count > 0) {
        self.tableFootView.hidden = NO;
        _tableFootLabel.text = [NSString stringWithFormat:@"%@名会员",@(count)];
        [self.tableView setTableFooterView:self.tableFootView];
        [self.emptyView removeFromSuperview];
        
    }else
    {
        
        [self.tableView addSubview:self.emptyView];
        _emptyViewYF.emptyLabel.text = @"无搜索结果";

        self.tableFootView.hidden = YES;
        [self.tableView setTableFooterView:[[UIView alloc] init]];
    }
}


- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, self.tableView.height)];
        
        _emptyViewYF.emptyImg.hidden = NO;
        
        _emptyViewYF.addbutton.hidden = YES;
        
        [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom+Height320(19.5)];
        
        [_emptyViewYF.addbutton changeTop:_emptyViewYF.emptyLabel.bottom+Height320(19.5)];
        
        _emptyViewYF.emptyLabel.text = @"搜索全部会员";
        
        _emptyViewYF.emptyImg.image = [UIImage imageNamed:@"SearchResult"];
        
        _emptyViewYF.emptyImg.frame = CGRectMake((_emptyViewYF.width - Width320(20)) / 2.0, Height320(80), Width320(20), Height320(20));
        
        [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom];
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
    }
    _emptyView.frame = self.tableView.bounds;
    _emptyView.backgroundColor = self.tableView.backgroundColor;
    return _emptyViewYF;
}

- (void)creatData
{
    
}


- (NSMutableArray *)dealArray:(NSMutableArray *)array searStr:(NSString *)searStr
{
    if (searStr.length==0) {
        
        return [NSMutableArray array];
    }else if(searStr.length != 0)
    {
        NSMutableArray *users = [NSMutableArray array];
        for (Student *tempStu in array) {
            
            if ([[tempStu.name lowercaseString] rangeOfString:[searStr lowercaseString]].length||[tempStu.phone rangeOfString:searStr].length) {
                [users addObject:tempStu];
            }
        }
        return users;
    }
    return nil;
}


@end
