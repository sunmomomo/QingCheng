//
//  FollowRecordToolView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "FollowRecordToolView.h"

#import "MOTextView.h"

@interface FollowRecordToolView ()<UITextViewDelegate,MOTextViewDelegate,UITextFieldDelegate>

{
    
    BOOL _funcShowing;
    
    UITapGestureRecognizer *_tap;
    
    UIButton *_addButton;
    
}

@property(nonatomic,strong)UIView *funcView;

@property(nonatomic,strong)MOTextView *textView;

@property(nonatomic,strong)UITextField *hideTF;

@property(nonatomic,strong)UITextField *funcTextField;

@end

@implementation FollowRecordToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xfafafa);
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(44))];
        
        topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [self addSubview:topView];
        
        self.textView = [[MOTextView alloc]initWithFrame:CGRectMake(Width320(8), Height320(6), Width320(268), Height320(32))];
        
        self.textView.layer.cornerRadius = Width320(2);
        
        self.textView.layer.masksToBounds = YES;
        
        self.textView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        self.textView.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        self.textView.delegate = self;
        
        self.textView.font = AllFont(15);
        
        self.textView.returnKeyType = UIReturnKeySend;
        
        self.textView.enablesReturnKeyAutomatically = YES;
        
        self.textView.textDelegate = self;
        
        [topView addSubview:self.textView];
        
        self.hideTF = [[UITextField alloc]initWithFrame:CGRectZero];
        
        [self addSubview:self.hideTF];
        
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.textView.right+Width320(8), Height320(8), Width320(28), Height320(28))];
        
        [_addButton setBackgroundImage:[UIImage imageNamed:@"func_tool_add"] forState:UIControlStateNormal];
        
        [self addSubview:_addButton];
        
        [_addButton addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.funcView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, Height320(103))];
        
        self.funcView.backgroundColor = UIColorFromRGB(0xfafafa);
        
        self.hideTF.inputView = self.funcView;
        
        UIButton *picButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(21), Height320(16), Width320(54), Height320(54))];
        
        [picButton setBackgroundImage:[UIImage imageNamed:@"func_tool_picture"] forState:UIControlStateNormal];
        
        picButton.tag = 1;
        
        [picButton addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.funcView addSubview:picButton];
        
        UILabel *picLabel = [[UILabel alloc]initWithFrame:CGRectMake(picButton.left, picButton.bottom+Height320(6), picButton.width, Height320(13))];
        
        picLabel.text = @"照 片";
        
        picLabel.textColor = UIColorFromRGB(0x666666);
        
        picLabel.textAlignment = NSTextAlignmentCenter;
        
        picLabel.font = AllFont(11);
        
        [self.funcView addSubview:picLabel];
        
        UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(picButton.right+Width320(21), picButton.top, picButton.width, picButton.height)];
        
        [cameraButton setBackgroundImage:[UIImage imageNamed:@"func_tool_camera"] forState:UIControlStateNormal];
        
        cameraButton.tag = 0;
        
        [cameraButton addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.funcView addSubview:cameraButton];
        
        UILabel *cameraLabel = [[UILabel alloc]initWithFrame:CGRectMake(cameraButton.left, cameraButton.bottom+Height320(6), cameraButton.width, Height320(13))];
        
        cameraLabel.text = @"拍 摄";
        
        cameraLabel.textColor = UIColorFromRGB(0x666666);
        
        cameraLabel.textAlignment = NSTextAlignmentCenter;
        
        cameraLabel.font = AllFont(11);
        
        [self.funcView addSubview:cameraLabel];
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        _tap.enabled = NO;
        
        [self addGestureRecognizer:_tap];
        
    }
    
    return self;
    
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    
    [[[UIAlertView alloc]initWithTitle:@"抱歉，您无该功能权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}


-(BOOL)resignFirstResponder
{
    
    [self.textView resignFirstResponder];
    
    [self.hideTF resignFirstResponder];
    
    return YES;
    
}
-(void)setDelegate:(id<FollowRecordToolViewDelegate>)delegate
{
    
    _delegate = delegate;
    
}

-(void)moreClick:(UIButton*)button
{
    
    _funcShowing = !_funcShowing;
    
    if (_funcShowing) {
        
        [self.textView resignFirstResponder];
        
        [self.hideTF becomeFirstResponder];
        
    }else
    {
        
        [self.hideTF resignFirstResponder];
        
        [self.textView becomeFirstResponder];
        
    }
    
}

-(void)imageClick:(UIButton*)button
{
    
    [self.delegate uploadPictureWithIndex:button.tag];
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    _funcShowing = NO;
    
    return YES;
    
}

-(void)textViewShouldReturn
{
    
    _funcShowing = NO;
    
    [self.delegate sendText:self.textView.text];
    
}

-(void)setText:(NSString *)text
{
    
    _text = text;
    
    self.textView.text = text;
    
}

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    
    self.textView.userInteractionEnabled = _addButton.userInteractionEnabled = userInteractionEnabled;
    
    _tap.enabled = !userInteractionEnabled;
    
    self.backgroundColor = userInteractionEnabled?UIColorFromRGB(0xfafafa):[UIColorFromRGB(0x000000) colorWithAlphaComponent:0.09];
    
    self.textView.backgroundColor = userInteractionEnabled?UIColorFromRGB(0xfafafa):[UIColorFromRGB(0x000000) colorWithAlphaComponent:0.09];
    
}

@end
