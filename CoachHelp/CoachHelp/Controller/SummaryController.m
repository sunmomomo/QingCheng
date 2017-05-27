//
//  SummaryController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SummaryController.h"

#import "MOTextView.h"

@interface SummaryController ()

@property(nonatomic,strong)MOTextView *textView;

@end

@implementation SummaryController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.text = @"";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.rightTitle = @"完成";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(133))];
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.textView = [[MOTextView alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(133))];
    
    self.textView.placeholder = self.placeholder;
    
    self.textView.text = self.text;
    
    [topView addSubview:self.textView];
    
}

-(void)naviRightClick
{
    
    if (self.summaryFinish) {
        self.summaryFinish(self.textView.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
