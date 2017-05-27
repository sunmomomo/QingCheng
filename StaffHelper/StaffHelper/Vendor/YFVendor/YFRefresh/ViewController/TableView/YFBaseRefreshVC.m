//
//  YFBaseRefreshVC.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseRefreshVC.h"

#import "MJRefresh.h"


@interface YFBaseRefreshVC ()




/**
 * 上次刷新的时间
 */
@property(nonatomic, assign)CFAbsoluteTime lastRefreshTime;//

/**
 * 当前时间
 */
@property(nonatomic, assign)CFAbsoluteTime currentTime;


@end

@implementation YFBaseRefreshVC

{
    BOOL _isFirstStartRequest;
    
    CGRect _initFrame;
}
- (void)dealloc
{
    self.baseDataArray = nil;
    
    self.refreshScrollView.delegate = nil;
    
    self.refreshScrollView.delegate = nil;
    
    self.refreshScrollView = nil;
}

#pragma mark - ViewController Cycle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self initData_YF];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initData_YF];
}

-(void)loadView
{
    [super loadView];
    
    if (!CGRectEqualToRect(_initFrame, CGRectZero))
    {
        self.view.frame = _initFrame;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initSubViews_YF];
}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//     [self refreshTableListDataaAtFirstTime];
//}
-(void)refreshTableListDataaAtFirstTime
{
    if (_isFirstStartRequest && _canNoPullRefresh)
    {
        _isFirstStartRequest = NO;
        [self startRequest];
    }
}

#pragma mark - 本类方法 子类不能重写
-(void)initData_YF
{
    _canNoPullRefresh = YES;
    _canGetMore = YES;
    _isFirstStartRequest = YES;
    _lastRefreshTime = 0;// 只有在刷新成功后才进行赋值
    
    _currentTime = CFAbsoluteTimeGetCurrent();
    
    _baseDataArray = [[NSMutableArray alloc] init];
    
    _firstPage =  1;
    
    _betweenRefreshTimes = 20 * 60;
    self.numberOfEachPage = 30;
}

#pragma mark TabelView 的加载
-(void)initSubViews_YF
{
    self.refreshScrollView = [self getScrollViewYF];
    
    if (_refreshScrollView == nil)
    {
        DebugLogYF(@"!!!!!!!!!!");
        return;
    }
//#warning 考虑界面重用 时，这个Key是一样的
    //    self.refreshScrollView.headerView.dateStoreKey = NSStringFromClass([self class]);
    _refreshScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self setScrollViewDelegateFY];
    //    _refreshScrollView ->_footerView.emptyDataText = @"没有找到符合条件的酒店！";
    [self.view addSubview: _refreshScrollView];
    
    }


#pragma mark Custom 可以 重写
-(void)setScrollViewDelegateFY
{
  
}

-(void)startRequest
{
    [self refreshTableListData];
}

-(void)refreshTableListData
{
    self.isReFreshing = YES;
    
//    if ([NSThread mainThread])
//    {
//        NSLog(@"主线程");
//    }
    [self setRefreshHeadViewYF];
    
    [self.refreshScrollView.mj_header beginRefreshing];

}

- (void)setRefreshHeadViewYF
{
    if (self.refreshScrollView.mj_header == nil)
    {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefreshTableView)];
        
        self.refreshScrollView.mj_header = header;
        header.lastUpdatedTimeLabel.hidden = YES;
        
        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        
        [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
        
        [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    }

}

-(void)reloadNetDataYF
{
    [self refreshTableListData];
}

-(void)refreshTableListDataIfNeed
{
    _currentTime = CFAbsoluteTimeGetCurrent();
    
    if (_currentTime - _lastRefreshTime  > _betweenRefreshTimes)
    {
        [self refreshTableListData];
    }
}

-(void)refreshTableListDataNoPull
{
    if (_canNoPullRefresh == NO)
    {
        return;
    }
    _canNoPullRefresh = NO;
    self.isReFreshing = YES;
    [self showLoadingViewWithMessage:@"加载中"];
    [self requestDataYF];
}

-(void)refreshTableListDataNoLoading
{
    if (_canNoPullRefresh == NO)
    {
        return;
    }
    _canNoPullRefresh = NO;
    self.isReFreshing = YES;
    [self requestDataYF];
}

-(void)requestDataYF
{
    //    self.requestDataArray = [[NSMutableArray alloc]init];
    [self clearAllRemindView];
    _lastRequestPage = _dataPage;
    
    if (self.isReFreshing)
    {
        _dataPage = _firstPage;
    }
    else
    {
        _dataPage++;
    }
    
    [self requestData];
}

#pragma mark  - 子类方法 ，子类必须重写，在这个方法 去 进行 网络的数据请求
-(void)requestData
{
    
}


//刷新
- (void)pullToRefreshTableView
{
    if (self.refreshScrollView.mj_footer.isRefreshing == NO)
    {
        self.isReFreshing = YES;
        __weak typeof(self)weakS = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kYFRefreshDelaySecondsssss * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakS requestDataYF];
        });
    }else
    {
        [self.refreshScrollView.mj_header endRefreshing];
    }
}
- (void)pullToLoadTableView
{
    if (self.refreshScrollView.mj_header.isRefreshing == NO)
    {
        self.isReFreshing = NO;
        __weak typeof(self)weakS = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kYFRefreshDelaySecondsssss * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakS requestDataYF];
        });
    }else
    {
        [self.refreshScrollView.mj_footer endRefreshing];
    }
}


#pragma mark  请求成功 数据 处理逻辑
#pragma mark 请求成功 数据处理
-(void)requestSuccessArray:(NSMutableArray *)array
{
    [self requestSuccessArray:array toDataArray:nil];
}

-(void)requestSuccessArray:(NSMutableArray *)array toDataArray:(NSMutableArray *)dataArray
{
    _canNoPullRefresh = YES;
    
    if (self.isReFreshing)
    {
        self.lastRefreshTime = CFAbsoluteTimeGetCurrent(); //更新刷新时间
        
        if (dataArray)
        {
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:array];
        }else
        {
            self.baseDataArray = array;
        }
        
        
        if (array.count == 0)
        {
            //            [self.refreshScrollView clearFoorView];
        }else
        {
            if (_canGetMore == YES)
            {
                if (array.count < _numberOfEachPage || array.count == 0)
                {
                    //没有更多数据
                    //                    self.refreshScrollView.reachedTheEnd = YES;
                }else
                {
                    //                    [self.refreshScrollView canShowFootView];
                    if (self.refreshScrollView.mj_footer == nil && self.canGetMore == YES)
                    {
                        self.refreshScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullToLoadTableView)];
                    }
                }
            }
        }
        
    }else
    {
        if (array.count >0 )
        {
            if (dataArray)
            {
                [dataArray addObjectsFromArray:array];
            }else
            {
                [self.baseDataArray addObjectsFromArray:array];
            }
            
        }
        
        if (array.count < _numberOfEachPage || array.count == 0)
        {
            //没有更多数据
            //            self.refreshScrollView.reachedTheEnd = YES;
            self.refreshScrollView.mj_footer.state = MJRefreshStateNoMoreData;
            
        }
        
        if (self.numberOfEachPage > 0 && array.count < self.numberOfEachPage) {
            self.refreshScrollView.mj_footer = nil;
        }
    }
    [self.refreshScrollView.mj_footer endRefreshing];
    [self.refreshScrollView.mj_header endRefreshing];
    
    [(UITableView *)self.refreshScrollView reloadData];
    
    
    
    if (dataArray)
    {
        if (self.sumDataNum>0 && dataArray.count >= self.sumDataNum)
        {
            self.refreshScrollView.mj_footer.state = MJRefreshStateNoMoreData;
        }
    }else
    {
        if (self.sumDataNum>0 && self.baseDataArray.count >= self.sumDataNum)
        {
            self.refreshScrollView.mj_footer.state = MJRefreshStateNoMoreData;
        }
    }
    
    
    
    //    [self.refreshScrollView tableViewDidFinishedLoading];
    
    [self stopLoadingViewWithMessage:nil];
    
    if (dataArray)
    {
        if (dataArray.count == 0)
        {
            [self emptyDataReminderAction];
        }
    }else
    {
        if (self.baseDataArray.count == 0)
        {
            [self emptyDataReminderAction];
        }
    }
}

#pragma mark 请求失败 数据处理
-(void)failRequest:(NSError *)error
{
    self.canNoPullRefresh = YES;
    self.dataPage = self.lastRequestPage;

    [self.refreshScrollView.mj_footer endRefreshing];
    [self.refreshScrollView.mj_header endRefreshing];

    [super failRequest:error];
}

-(void)showFailViewOnSuperView:(UIView *)superView
{
    // 如果 有数据，就显示在 self.view 防止下滑  failview 看到数据
    if (self.baseDataArray.count > 0)
    {
        superView = self.view;
    }else
    superView = self.refreshScrollView;
    [super showFailViewOnSuperView:superView];
}

- (UIScrollView *)getScrollViewYF
{
    
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _initFrame = frame;
    }
    return self;
}

@end
