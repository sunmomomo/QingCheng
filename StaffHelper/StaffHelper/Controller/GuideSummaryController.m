//
//  GuideSummaryController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideSummaryController.h"

#import "MOTextView.h"

@interface GuideSummaryController ()<UITextViewDelegate>

@property(nonatomic,strong)MOTextView *textView;

@property(nonatomic,strong)UIButton *confirmButton;

@end

@implementation GuideSummaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"描述您的健身房";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(133))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.textView = [[MOTextView alloc]initWithFrame:CGRectMake(Width320(16)-5, Height320(10), MSW-Width320(32)+10, Height320(123))];
    
    self.textView.placeholder = @"描述下您的健身房";
    
    self.textView.delegate = self;
    
    self.textView.text = self.gym.summary;
    
    self.textView.font = AllFont(14);
    
    [topView addSubview:self.textView];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.confirmButton];
    
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    self.gym.summary = self.textView.text;
    
    return YES;
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    self.gym.summary = self.textView.text;
    
}

-(void)confirm
{
    
    if (self.fillFinish) {
        self.fillFinish(self.gym);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
