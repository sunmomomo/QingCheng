//
//  UserChooseView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "UserChooseView.h"

@interface UserChooseView ()

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation UserChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [self addSubview:backView];
        
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height320(300)) style:UITableViewStylePlain];
        
        self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.tableView.tableFooterView = [UIView new];
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(96), 0, 0);
        
        [self addSubview:self.tableView];
        
    }
    
    return self;
    
}

-(void)setDatasource:(id<UserChooseViewDatasource>)datasource
{
    
    _datasource = datasource;
    
    self.tableView.dataSource = _datasource;
    
    self.tableView.delegate = _datasource;
    
}

-(void)setTag:(NSInteger)tag
{
    
    [super setTag:tag];
    
    self.tableView.tag = tag;
    
}

-(void)show
{
    
    [self.tableView changeTop:MSH];
    
    self.hidden = NO;
    
    [self.superview bringSubviewToFront:self];
    
    if (self.tableView.contentSize.height>Height320(350)) {
        
        [self.tableView changeHeight:Height320(350)];
        
    }else{
        
        [self.tableView changeHeight:self.tableView.contentSize.height];
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.tableView changeTop:MSH-self.tableView.height];
        
    }];
    
}

-(void)close
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.tableView changeTop:MSH];
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        
    }];
    
}

-(void)reloadData
{
    
    [self.tableView reloadData];
    
    if (self.tableView.contentSize.height>Height320(350)) {
        
        [self.tableView changeHeight:Height320(350)];
        
    }else{
        
        [self.tableView changeHeight:self.tableView.contentSize.height];
        
    }
    
    [self.tableView changeTop:MSH-self.tableView.height];
    
}

@end
