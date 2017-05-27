//
//  YFAddOriginVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFAddOriginVC.h"
#import "YFAppService.h"
#import "UIView+YFLoadAniView.h"

@interface YFAddOriginVC ()<UITextViewDelegate>

@end

@implementation YFAddOriginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *whiiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, MSW, XFrom6YF(140))];
    whiiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiiteView];
    
    [self.view addSubview:self.textView];
    self.view.backgroundColor = RGB_YF(246, 246, 246);
    
    
    self.rightTitle = @"确定";
    
    self.view.loadViewYF.frame = CGRectMake(0, 64.0, MSW, MSH - 64.0);
}

- (YFTextView *)textView
{
    if (!_textView)
    {
        _textView = [[YFTextView alloc] initWithFrame:CGRectMake(15, 64.0 + 11, MSW - 30, XFrom6YF(140) - 16)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = FontSizeFY(14.0);
        _textView.placeHolder = _placeHolderText;
        _textView.placeHolderTextColor = RGB_YF(140, 140, 140);
        _textView.textColor = RGB_YF(51, 51, 51);
        _textView.delegate = self;
        _textView.text = _valueText;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _textView.width, 1)];
        view.backgroundColor = [UIColor whiteColor];
        [_textView addSubview:view];
        
    }
    return _textView;
}


- (void)textViewDidChange:(UITextView *)textView
{
    [self.textView setNeedsDisplay];
}

- (void)naviRightClick
{
    if (self.selelctBlock)
    {
        if (self.textView.text.length == 0)
        {
            [YFAppService showAlertMessage:@"内容不能为空"];
        }else
        {
            self.selelctBlock(self.textView.text);
        }
    }
 
}

@end
