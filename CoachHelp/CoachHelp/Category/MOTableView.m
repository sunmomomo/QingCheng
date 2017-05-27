//
//  MOTableView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOTableView.h"

#import "MOViewController.h"

@interface QCTableViewHUD ()

{
    
    UIImageView *_outsideImage;
    
    UIImageView *_pointerImage;
    
    BOOL _animation;
    
}

@end

@implementation QCTableViewHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _outsideImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(32), Height320(125), Height320(64), Width320(64))];
        
        _outsideImage.image = [UIImage imageNamed:@"ic_loading_outside"];
        
        [self addSubview:_outsideImage];
        
        _pointerImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(13.5), Height320(148), Width320(27), Height320(27))];
        
        _pointerImage.image = [UIImage imageNamed:@"ic_loading_pointer"];
        
        [self addSubview:_pointerImage];
        
        UILabel *loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _outsideImage.bottom+Height320(12), MSW, Height320(18))];
        
        loadingLabel.text = @"正在加载...";
        
        loadingLabel.textColor = UIColorFromRGB(0x666666);
        
        loadingLabel.font = AllFont(14);
        
        loadingLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:loadingLabel];
        
    }
    return self;
}

-(void)loading
{
    
    _animation = YES;
    
    [self.superview bringSubviewToFront:self];
    
    [self startAnimation];
    
    self.hidden = NO;
    
}

-(void)startAnimation
{
    
    if (_animation) {
        
        CABasicAnimation *animation = [CABasicAnimation
                                       animationWithKeyPath:@"transform"];
        
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        
        animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI*(179.0f/180.0f), 0, 0, 1.0) ];
        animation.duration = 0.4;
        
        animation.cumulative = YES;
        animation.repeatCount = 2;
        
        [_pointerImage.layer addAnimation:animation forKey:@"transform"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self startAnimation];
            
        });
        
    }else{
        
        [_pointerImage.layer removeAnimationForKey:@"transform"];
        
    }
    
}

-(void)stopLoading
{
    
    _animation = NO;
    
    [_pointerImage.layer removeAnimationForKey:@"transform"];
    
    self.hidden = YES;
    
}

-(void)dealloc
{
    
    _animation = NO;
    
    [UIView beginAnimations:@"QCLoadingHUDAnimation" context:nil];
    
    [UIView setAnimationDelegate:nil];
    
    [UIView setAnimationDidStopSelector:nil];
    
    [UIView commitAnimations];
    
}

@end

@interface MOTableView ()

{
    
    QCTableViewHUD *_loadingView;
    
    UIView *_failView;
    
    BOOL _haveLoaded;
    
}

@end

@implementation MOTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [UIView new];
        
        _loadingView = [[QCTableViewHUD alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_loadingView];
        
        [_loadingView loading];
        
        _failView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _failView.backgroundColor = UIColorFromRGB(0xffffff);
        
        UIImageView *failImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(80), MSW/3, MSW/3)];
        
        failImg.image = [UIImage imageNamed:@"fail"];
        
        [_failView addSubview:failImg];
        
        UIButton *refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2-Width320(40), failImg.bottom+Height320(30), Width320(80), Height320(30))];
        
        refreshButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        refreshButton.layer.borderColor = kMainColor.CGColor;
        
        refreshButton.layer.borderWidth = 1;
        
        refreshButton.layer.cornerRadius = 4;
        
        [refreshButton setTitle:@"重试" forState:UIControlStateNormal];
        
        [refreshButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        refreshButton.titleLabel.font = AllFont(14);
        
        [refreshButton addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        
        [_failView addSubview:refreshButton];
        
        [self addSubview:_failView];
        
        _failView.hidden = YES;
        
    }
    
    return self;
    
}

-(void)refresh
{
    
    MOViewController *datasource = (MOViewController*)self.dataSource;
    
    if ([datasource respondsToSelector:@selector(reloadData)]) {
        
        [datasource reloadData];
        
    }
    
}

-(void)setDataSuccess:(BOOL)dataSuccess
{
    
    _dataSuccess = dataSuccess;
    
    self.tableHeaderView.hidden = NO;
    
    self.tableFooterView.hidden = NO;
    
    _haveLoaded = YES;
    
    [_loadingView stopLoading];
    
    [_loadingView removeFromSuperview];
    
    _loadingView = nil;
    
}

-(void)reloadData
{
    
    [super reloadData];
    
    if (self.mj_header) {
        
        [self.mj_header endRefreshing];
        
    }
    
    if (self.mj_footer) {
        
        [self.mj_footer endRefreshing];
        
    }
    
    self.tableHeaderView.hidden = YES;
    
    self.tableFooterView.hidden = YES;
    
    if (_haveLoaded) {
        
        self.tableHeaderView.hidden = NO;
        
        self.tableFooterView.hidden = NO;
        
        if (!self.dataSuccess) {
            
            _failView.hidden = NO;
            
            [_emptyView removeFromSuperview];
            
            _emptyView = nil;
            
        }else
        {
            
            NSInteger count = 0;
            
            if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
                
                for (NSInteger i = 0 ; i<[self.dataSource numberOfSectionsInTableView:self]; i++) {
                    
                    count += [self.dataSource tableView:self numberOfRowsInSection:i];
                    
                }
                
            }else{
                
                count = [self.dataSource tableView:self numberOfRowsInSection:0];
                
            }
            
            if (!count) {
                
                if (!_emptyView) {
                    
                    id<MOTableViewDatasource> datasource = (id<MOTableViewDatasource>) self.dataSource;
                    
                    if ([datasource respondsToSelector:@selector(emptyViewForTableView:)]) {
                        
                        _emptyView = [datasource emptyViewForTableView:self];
                        
                    }
                    
                }
                
                if (_emptyView) {
                    
                    [self addSubview:_emptyView];
                    
                }
                
                _failView.hidden = YES;
                
            }else
            {
                
                _emptyView.hidden = YES;
                
                [_emptyView removeFromSuperview];
                
                _emptyView = nil;
                
                _failView.hidden = YES;
                
            }
            
        }
        
    }
    
}

-(void)setDataSource:(id<MOTableViewDatasource>)dataSource
{
    
    [super setDataSource:dataSource];
    
    _emptyDatasource = dataSource;
    
}

-(void)dealloc
{
    
    if (self.mj_header) {
        
        self.mj_header = nil;
        
    }
    
    if (self.mj_footer) {
        
        self.mj_footer = nil;
        
    }
    
}

@end
