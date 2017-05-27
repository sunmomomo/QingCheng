//
//  YFConditionPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFConditionPopView.h"
#import "YFAppConfig.h"
#import "YFFailView.h"
#import "YFAppService.h"

@interface YFConditionPopView ()

@property(nonatomic,strong)UIView *emptyView;
@property(nonatomic, strong)YFFailView *failView;

/**
 * 上一次 请求的 页数
 */
@property(nonatomic, assign)NSUInteger lastRequestPage;

@end

@implementation YFConditionPopView
{
    UIControl *_chirderViewSuperView;
}
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame
{
    self = [super initWithFrame: frame superView:superView childrenFrame:childrenFrame];
    if (self) {
        self.isCanShow = YES;
        
        [self initChildrenViewWithFrame:childrenFrame];
        self.clipsToBounds = YES;
        self.dataPage = 1;
        _firstPage = 1;
        _canGetMore = YES;
        self.backgroundColor = [UIColor clearColor];
        self.hideAlpha = 1.0;
        self.chirdrenHeight = 0.0;
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame superView:superView];
    if (self)
    {
        self.isCanShow = YES;

        [self initChildrenViewWithFrame:self.bounds];
        self.clipsToBounds = YES;
        self.dataPage = 1;
        _firstPage = 1;
        _canGetMore = YES;
        self.backgroundColor = [UIColor clearColor];
        self.hideAlpha = 1.0;
        self.chirdrenHeight = 0.0;
    }
    return self;
}

- (void)hideControlAction:(id)sender
{
    [super hideControlAction:sender];
    
    if (self.cancelBlock) {
        self.cancelBlock(nil);
    }
}

-(void)initChildrenViewWithFrame:(CGRect)frame
{
    self.originFrame = frame;
    
    _chirderViewSuperView = [[UIControl alloc] initWithFrame:self.originFrame];

    [_chirderViewSuperView addTarget:self action:@selector(hideControlAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hiddenFrame = CGRectMake(0, - frame.size.height, self.width, frame.size.height);
    
    self.childredView = [[UIView alloc] initWithFrame:self.hiddenFrame];
    
    self.childredView .backgroundColor = [UIColor whiteColor];
    [_chirderViewSuperView addSubview:self.childredView];


    _chirderViewSuperView.clipsToBounds = YES;
    _chirderViewSuperView.backgroundColor = [UIColor clearColor];
    _chirderViewSuperView.frame = self.originFrame;
    
    [self addSubview:_chirderViewSuperView];
    
}

- (void)setOriginFrame:(CGRect)originFrame
{
    [super setOriginFrame:originFrame];
    
    _chirderViewSuperView.frame = self.originFrame;
    
    self.hiddenFrame = CGRectMake(0, - originFrame.size.height, originFrame.size.width, originFrame.size.height);
}

- (void)setRefreshViewSettingto:(UIScrollView *)scrollView
{
        if (scrollView.mj_header == nil)
        {
            
            self.refreshScrollView = scrollView;
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefreshTableView)];
            
            scrollView.mj_header = header;
            header.lastUpdatedTimeLabel.hidden = YES;
            
            [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
            
            [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
            
            [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
        }
}

- (void)setLoadViewSettingto:(UIScrollView *)scrollView
{
    if (scrollView.mj_footer == nil)
    {
        self.refreshScrollView = scrollView;
        scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullToLoadTableView)];
    }
}


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
        [self.refreshScrollView.mj_footer endRefreshing];
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

-(void)requestData
{
    
}

-(void)clearAllRemindView
{
    [self.emptyView removeFromSuperview];
    [self hideFailView];
}

- (void)hideFailView
{
    [self.failView removeSelfFromView];
    self.failView.backgroundColor = YFMainBackColor;
}
- (void)reloadNetDataYF
{
    [self refreshTableListData];
}
-(void)reloadData
{
    [self reloadNetDataYF];
}

#pragma mark Getter
- (YFFailView *)failView
{
    if (_failView == nil)
    {
        DebugLogYF(@"000000000000");
        weakTypesYF
        _failView = [[YFFailView alloc] initWithFrame:self.bounds LoadBlock:^{
            [weakS refreshTableListDataNOPull];
        }];
    }
    return _failView;
}

#pragma mark  请求成功 数据 处理逻辑
#pragma mark 请求成功 数据处理
-(void)requestSuccessArray:(NSMutableArray *)array
{
    if (self.isReFreshing)
    {
        self.baseDataArray = array;
        
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
            [self.baseDataArray addObjectsFromArray:array];
        }
        
        if (array.count < _numberOfEachPage || array.count == 0)
        {
            //没有更多数据
            //            self.refreshScrollView.reachedTheEnd = YES;
            self.refreshScrollView.mj_footer.state = MJRefreshStateNoMoreData;
            
        }
    }
    [self.refreshScrollView.mj_footer endRefreshing];
    [self.refreshScrollView.mj_header endRefreshing];
    
    [(UITableView *)self.refreshScrollView reloadData];
    
    
    
    
    
    //    [self.refreshScrollView tableViewDidFinishedLoading];
    
    [self stopLoadingViewWithMessage:nil];
    
    if (self.baseDataArray.count == 0)
    {
        [self emptyDataReminderAction];
    }
    DebugLogYF(@"列表总数------:%@",@(self.baseDataArray.count));
}

-(void)emptyDataReminderAction
{
    if (self.emptyView)
    {
        
        [self addSubview:self.emptyView];
        
        [self bringSubviewToFront:self.emptyView];
    }else
        [YFAppService showAlertMessage:@"未查询到数据"];
}

//   ing 失败掉的 方法
-(void)failRequest:(NSError *)error
{
    [self stopLoadingViewWithMessage:nil];
    self.dataPage --;
    if (self.failView) {
        [self showFailViewOnSuperView:nil];
    }else
        [YFAppService showAlertMessageWithError:error];
}


- (void)showFailViewOnSuperView:(UIView *)superView
{
    if (superView == nil)
    {
        superView = self;
    }
    self.failView.frame = superView.bounds;
    [superView addSubview:self.failView];
    [superView bringSubviewToFront:self.failView];
    self.failView.hidden = NO;
    
    DebugLogYF(@"--000---000000");
}


-(void)refreshTableListData
{
    self.isReFreshing = YES;
    
    if ([NSThread mainThread])
    {
//        NSLog(@"主线程");
    }
    [self setRefreshViewSettingto:self.refreshScrollView];
    
    [self.refreshScrollView.mj_header beginRefreshing];
    
}

-(void)refreshTableListDataNOPull
{
    self.isReFreshing = YES;
    [self showLoadingViewWithMessage:nil];
    [self requestDataYF];
}

- (void)show
{
    if (self.isCanShow == NO)
    {
        [self showWhenCannotShow];
        return;
    }
    [super show];
}

- (void)setChirdrenHeight:(CGFloat)chirdrenHeight
{
    _chirdrenHeight = chirdrenHeight;
    self.hiddenFrame = CGRectMake(self.hiddenFrame.origin.x, -self.chirdrenHeight, self.hiddenFrame.size.width, self.chirdrenHeight);

}

-(void)showAnimate:(BOOL)isAmate
{
    
    CGFloat intemerTime = 0;
    CGFloat intemerTime2 = 0;
    if (isAmate)
    {
        intemerTime = 0.3;
        intemerTime2 = 0.1;
    }
    
    if (self.hidden == NO)
    {
        return;
    }
    
    [[[UIApplication sharedApplication].delegate window]endEditing:YES];
    
    [self.superView addSubview:self];
    
    self.hidden = NO;
    
    self.userInteractionEnabled = YES;
    
    if (self.childredView)
    {
        self.childredView.alpha = self.hideAlpha;
        
        if (CGRectEqualToRect(self.originFrame, self.childredView.frame) == NO)
        {
            if (self.chirdrenHeight)
            {
                self.childredView.frame = CGRectMake(self.hiddenFrame.origin.x, -self.chirdrenHeight, self.hiddenFrame.size.width, self.chirdrenHeight);
            }else
            {
                self.childredView.frame = self.hiddenFrame;
            }

            
            UIViewAnimationOptions option;
            
            if (self.hiddenFrame.origin.y > self.childredView.frame.origin.y) {
                option = UIViewAnimationOptionTransitionCurlDown;
            }else
            {
                option = UIViewAnimationOptionTransitionCurlDown;
            }
            
            CGRect toFrame;
            
            if (self.chirdrenHeight)
            {
                toFrame = CGRectMake(0, 0, _chirderViewSuperView.width, self.chirdrenHeight);
            }else
            {
                toFrame = _chirderViewSuperView.bounds;
            }

            [UIView animateWithDuration:intemerTime delay:0 options:option animations:^{
                
                self.childredView.alpha = 1.;
                
                self.childredView.frame = toFrame;
                
            } completion:^(BOOL finished) {
                
            }];
        }else
        {
            [UIView animateWithDuration:intemerTime2 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                
                self.alpha = 1.;
                
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
            }];
        }
    }
}


-(void)showWhenCannotShow
{
    
}

- (void)afterSetAllConditionsParam:(NSDictionary *)patamDic
{
    
}

- (void)afterSetRightVCAllConditionsParam:(NSDictionary *)patamDic
{
    
}

- (void)reloadConditionData
{
    
}

- (NSDictionary *)conditionsParam
{
    if (_conditionsParam.count) {
        return _conditionsParam;
    }
    return self.param;
}

@end
