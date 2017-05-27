//
//  YFConditionPopView.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFPopBaseView.h"


@interface YFConditionPopView : YFPopBaseView

/**
 * 包括非 请求的 条件
 */
@property(nonatomic, strong)NSDictionary *conditionsParam;


/**
 * 是否自动设置 button 的 选中
 */
@property(nonatomic, assign)BOOL isNeverTurnButtonToSelect;

@property(nonatomic, copy)void(^cancelBlock)(id);

@property(nonatomic, assign)BOOL isToGreenTitle;

@property(nonatomic,assign)BOOL isCanShow;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *value;
@property(nonatomic,strong)NSDictionary *param;

// param 是否有效
@property(nonatomic,assign)BOOL isValidParam;


@property(nonatomic, copy)void(^selectBlock)(NSString *value,NSDictionary *param);

@property(nonatomic,strong)Gym *gym;

/**
 * YES 刷新  ，NO 加载,用于请求结果的判断
 */
@property(nonatomic, assign) BOOL isReFreshing;

@property(nonatomic, strong)UIView *chirderViewSuperView;

- (void)setRefreshViewSettingto:(UIScrollView *)scrollView;
- (void)setLoadViewSettingto:(UIScrollView *)scrollView;


- (void)pullToRefreshTableView;

/**
 * 加载页数
 */
@property(nonatomic, assign)NSInteger dataPage;


/**
 *首页 的 page值 默认为 1
 */
@property(nonatomic, assign)NSUInteger firstPage;

-(void)requestData;

/**
 * 列表的数据源
 */
@property(nonatomic, retain)NSMutableArray *baseDataArray;

@property(nonatomic, assign)BOOL canGetMore;
/**
 *  上拉刷新 下拉加载的 UITableView
 */
@property(nonatomic, strong)UIScrollView *refreshScrollView;

/**
 * 请求成功 ,自动处理 上拉 下拉 加载的 数据处理
 
 封装功能：array 加到baseDataArray，停止刷新动画，刷新Tableview(reloadData)
 */
-(void)requestSuccessArray:(NSMutableArray *)array;

/**
 *  每页个数  当新请求页数的数据个数少于 每页个数 或者为 0 时，上拉加载 功能不可用（此时说明已经没有更多数据了）
 
 两种处理方式： 1.禁止上拉功能 ，并隐藏上拉加载动画   [self.baseTableView clearFoorView];
 并且有足够数据时 显示此功能   [self.baseTableView canShowFootView];
 2.禁止上拉功能， 上拉提示语 改成 没有更多信息  self.baseTableView.reachedTheEnd = YES;
 
 2.每页个数  当新请求页数的数据个数少于 每页个数 或者为 0 ，
 
 */

@property(nonatomic, assign)NSUInteger  numberOfEachPage;

/**
 *  请求失败处理
 */
-(void)failRequest:(NSError *)error;

-(void)refreshTableListData;

-(void)emptyDataReminderAction;

// isCanShow == NO，调用该方法
-(void)showWhenCannotShow;

-(void)refreshTableListDataNOPull;

- (void)showFailViewOnSuperView:(UIView *)superView;
/**
 * 所有 筛选条件的 Param
 */
- (void)afterSetAllConditionsParam:(NSDictionary *)patamDic;


/**
 * 所有 右侧 左滑 页面 条件的 Param
 */
- (void)afterSetRightVCAllConditionsParam:(NSDictionary *)patamDic;


- (void)reloadConditionData;

/**
 * 默认0 不设置
 */
@property(nonatomic, assign)CGFloat chirdrenHeight;

@end
