//
//  YFSignUpListSelectShowViewVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListSelectShowViewVC.h"

@interface YFSignUpListSelectShowViewVC ()

@end

@implementation YFSignUpListSelectShowViewVC

- (void)initBaseMOView
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.baseTableView.frame = CGRectMake(0, MSH, MSW, Height320(300));
    
    self.baseTableView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor clearColor];

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    
    [self.view addSubview:backView];
    
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];

    [self.view sendSubviewToBack:backView];
    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
}


- (void)setBaseDataArray:(NSMutableArray *)baseDataArray
{
    [super setBaseDataArray:baseDataArray];
    
    [self.baseTableView reloadData];
}


-(void)show
{
    [self.baseTableView changeTop:MSH];
    
    self.view.hidden = NO;
    
    [self.view.superview bringSubviewToFront:self.view];
    
    if (self.baseTableView.contentSize.height>Height320(350)) {
        
        [self.baseTableView changeHeight:Height320(350)];
        
    }else
    {
        [self.baseTableView changeHeight:self.baseTableView.contentSize.height];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.baseTableView changeTop:MSH-self.baseTableView.height];
    }];
    
}

-(void)close
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.baseTableView changeTop:MSH];
        
    } completion:^(BOOL finished) {
        
        self.view.hidden = YES;
        
    }];
    
}

-(void)reloadData
{
    
    [self.baseTableView reloadData];
    
    if (self.baseTableView.contentSize.height>Height320(350)) {
        
        [self.baseTableView changeHeight:Height320(350)];
        
    }else{
        
        [self.baseTableView changeHeight:self.baseTableView.contentSize.height];
        
    }
    
    [self.baseTableView changeTop:MSH-self.baseTableView.height];
    
}


@end
