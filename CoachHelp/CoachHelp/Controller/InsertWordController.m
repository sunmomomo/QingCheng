//
//  InsertWordController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/25.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "InsertWordController.h"

#import "MOTextView.h"

@interface InsertWordController ()<MOTextViewDelegate>

@property(nonatomic,strong)MOTextView *textView;

@end

@implementation InsertWordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self createUI];
    
}

-(void)naviRightClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.inputFinish) {
        
        self.inputFinish(self.textView.text);
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeTitle;
    
    self.rightTitle = @"完成";
    
    self.title = self.isEdit?@"编辑文字":@"添加文字";
        
    self.textView = [[MOTextView alloc]initWithFrame:CGRectMake(Width320(18.6), Height320(16)+64, MSW-Width320(37.2), MSH-Height320(32))];
    
    self.textView.textColor = UIColorFromRGB(0x222222);
    
    self.textView.font = STFont(14);
    
    self.textView.textDelegate = self;
    
    self.textView.needNext = YES;
    
    self.textView.placeholder = @"输入一段文字";
    
    if (self.text) {
        
        self.textView.text = self.text;
        
    }
    
    [self.textView becomeFirstResponder];
    
    [self.view addSubview:self.textView];
    
}

-(void)textViewShouldReturn
{
    
    [self naviRightClick];
    
}

@end
