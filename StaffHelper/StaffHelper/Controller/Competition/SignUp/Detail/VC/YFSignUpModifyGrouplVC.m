//
//  YFSignUpModifyGrouplVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpModifyGrouplVC.h"

#import "QCTextField.h"

#import "YFSignUpViewModel.h"

#import "UIView+lineViewYF.h"

@interface YFSignUpModifyGrouplVC ()

@property(nonatomic,strong)QCTextField *textField;

@property(nonatomic, strong)YFSignUpViewModel *viewModel;


@end

@implementation YFSignUpModifyGrouplVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];

}


-(void)createUI
{
    
    self.title = @"组名";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightTitle = @"保存";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 79, MSW, 50)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.textField = [[QCTextField alloc]initWithFrame:CGRectMake(15, 0, MSW-30, 50)];
    
    
    self.textField.font = FontSizeFY(15);
    
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.textField.textAlignment = NSTextAlignmentLeft;

    self.textField.placeholder = @"";
    
    self.textField.noLine = YES;
    
    self.textField.text = self.groupName;
    
    [topView addSubview:self.textField];
    
    [topView addLinewViewToTop];
    
    [topView addLinewViewToBottom];

}

- (void)naviRightClick
{
    if (self.sureNameBlock)
    {
        if (self.textField.text.length)
        {
            self.sureNameBlock(self.textField.text);
        }
    }
}


@end
