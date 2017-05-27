//
//  YFBaseRefreshVC.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseVC.h"

@interface YFBaseRefreshVC : YFBaseVC

- (instancetype)initWithFrame:(CGRect)frame;

/**
 * 上一次 请求的 页数
 */
@property(nonatomic, assign)NSUInteger lastRequestPage;
/**
 *  上拉刷新 下拉加载的 UITableView
 */
@property(nonatomic, strong)UIScrollView *refreshScrollView;

/**
 * 列表的数据源
 */
@property(nonatomic, retain)NSMutableArray *baseDataArray;

/**
 * 加载页数
 */
@property(nonatomic, assign)NSInteger dataPage;

@property(nonatomic, assign)BOOL canGetMore;

/**
 *  每页个数  当新请求页数的数据个数少于 每页个数 或者为 0 时，上拉加载 功能不可用（此时说明已经没有更多数据了）
 
 两种处理方式： 1.禁止上拉功能 ，并隐藏上拉加载动画   [self.baseTableView clearFoorView];
 并且有足够数据时 显示此功能   [self.baseTableView canShowFootView];
 2.禁止上拉功能， 上拉提示语 改成 没有更多信息  self.baseTableView.reachedTheEnd = YES;
 
 2.每页个数  当新请求页数的数据个数少于 每页个数 或者为 0 ，
 
 */

@property(nonatomic, assign)NSUInteger  numberOfEachPage;

/**
 * 数据总数
 */
@property(nonatomic, assign)NSUInteger sumDataNum;

/**
 * YES 刷新  ，NO 加载,用于请求结果的判断
 */
@property(nonatomic, assign) BOOL isReFreshing;

/**
 *首页 的 page值 默认为 1
 */
@property(nonatomic, assign)NSUInteger firstPage;

/**
 * 两次刷新 允许的时间差 小于 则不自动刷新 大于 则自动刷新 默认 20分钟
 */
@property(nonatomic, assign)CFAbsoluteTime betweenRefreshTimes;

/**
 * 请求数据,子类 重写该方法
 */
-(void)requestData;

/**
 * 请求成功 ,自动处理 上拉 下拉 加载的 数据处理
 
 封装功能：array 加到baseDataArray，停止刷新动画，刷新Tableview(reloadData)
 */
-(void)requestSuccessArray:(NSMutableArray *)array;

-(void)requestSuccessArray:(NSMutableArray *)array toDataArray:(NSMutableArray *)dataArray;



/**
 *  开始请求
 */
-(void)startRequest;

/**
 * 刷新数据为第一页
 */
-(void)refreshTableListData;

/**
 *  请求失败处理
 */
-(void)failRequest:(NSError *)error;

/**
 * 刷新  条件是 两次刷新之间的时间差
 */
-(void)refreshTableListDataIfNeed;

// 不能同时 两次，canPullRefresh 控制
-(void)refreshTableListDataNoPull;
-(void)refreshTableListDataNoLoading;

@property(nonatomic, assign)BOOL canNoPullRefresh;



// 设置 TableView代理 和 数据源
-(void)setScrollViewDelegateFY;

-(void)refreshTableListDataaAtFirstTime;

- (UIScrollView *)getScrollViewYF;
- (void)setRefreshHeadViewYF;

- (void)pullToRefreshTableView;

@end
