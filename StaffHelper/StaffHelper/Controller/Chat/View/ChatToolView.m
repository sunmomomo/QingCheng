//
//  ChatToolView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatToolView.h"

#import "ChatButton.h"

#import <AVFoundation/AVFoundation.h>

@interface ChatToolView ()<UITextFieldDelegate,AVAudioRecorderDelegate,UITextViewDelegate,ChatSoundRecorderDelegate>
//最左边发送语音的按钮
@property (nonatomic, strong) UIButton *voiceChangeButton;

//发送语音的按钮
@property (nonatomic, strong) ChatButton *sendVoiceButton;

//文本视图
@property (nonatomic, strong) UITextView *sendTextView;

//切换键盘
@property (nonatomic, strong) UIButton *changeKeyBoardButton;

//More
@property (nonatomic, strong) UIButton *moreButton;

//键盘坐标系的转换
@property (nonatomic, assign) CGRect endKeyBoardFrame;

//传输文字的block回调
@property (strong, nonatomic) MyTextBlock textBlock;

//传输录音地址
@property (strong, nonatomic) AudioBlock audioBlock;

@property(strong,nonatomic) PictureBlock picBlock;


//添加录音功能的属性
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSString *audioPath;

@end

@implementation ChatToolView

-(void)setMyTextBlock:(MyTextBlock)block
{
    self.textBlock = block;
}

-(void)setAudioSendBlock:(AudioBlock)block
{
    self.audioBlock = block;
}

-(void)setPictureBlock:(PictureBlock)block
{
    
    self.picBlock = block;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xfafafa);
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = OnePX;
        
        [self addSubview];
        
    }
    return self;
}

-(void) addSubview
{
    
    [ChatSoundRecorder sharedInstance].delegate = self;
    
    self.voiceChangeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 32, 32)];
    [self.voiceChangeButton setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateNormal];
    [self.voiceChangeButton addTarget:self action:@selector(tapVoiceChangeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.voiceChangeButton];
    
    self.sendVoiceButton = [[ChatButton alloc] initWithFrame:CGRectMake(self.voiceChangeButton.right+10, 7, MSW-62-self.voiceChangeButton.right, 38)];
    [self.sendVoiceButton setBackgroundColor:UIColorFromRGB(0xfafafa)];
    self.sendVoiceButton.layer.cornerRadius = 2;
    
    [self.sendVoiceButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    
    self.sendVoiceButton.layer.masksToBounds = YES;
    
    self.sendVoiceButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.sendVoiceButton.layer.borderWidth = OnePX;
    
    [self.sendVoiceButton setBackgroundImage:[UIImage imageWithColor:RGBAOF(0xFAFAFA, 1)] forState:UIControlStateNormal];
    
    [self.sendVoiceButton setBackgroundImage:[UIImage imageWithColor:RGBAOF(0xe5e5e5, 1)] forState:UIControlStateSelected];
    
    [self.sendVoiceButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self.sendVoiceButton setTitle:@"松开 结束" forState:UIControlStateSelected];
    
    self.sendVoiceButton.titleLabel.font = kAppMiddleTextFont;
    
    __weak typeof(self)weakS = self;
    
    self.sendVoiceButton.touch = ^{
       
        [weakS onClickRecordTouchDown:weakS.sendVoiceButton];
        
    };
    
    [self.sendVoiceButton addTarget:self action:@selector(onClickRecordDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self.sendVoiceButton addTarget:self action:@selector(onClickRecordDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [self.sendVoiceButton addTarget:self action:@selector(onClickRecordTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [self.sendVoiceButton addTarget:self action:@selector(onClickRecordTouchUpOutside:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendVoiceButton.hidden = YES;
    [self addSubview:self.sendVoiceButton];
    
    self.sendTextView = [[UITextView alloc] initWithFrame:self.sendVoiceButton.frame];
    [self.sendTextView setBackgroundColor:UIColorFromRGB(0xffffff)];
    self.sendTextView.layer.cornerRadius = 2;
    
    self.sendTextView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.sendTextView.layer.borderWidth = OnePX;
    
    self.sendTextView.returnKeyType = UIReturnKeySend;
    
    self.sendTextView.font = AllFont(15);
    
    self.sendTextView.delegate = self;
    [self addSubview:self.sendTextView];
    
    self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(MSW-42, 10, 32, 32)];
    [self.moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [self.moreButton addTarget:self action:@selector(tapMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreButton];
    
    self.KVOController = [FBKVOController controllerWithObserver:self];
    __weak ChatToolView *ws = self;
    [self.KVOController observe:[ChatSoundRecorder sharedInstance] keyPath:@"recordState" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        [ws onRecordStoped];
    }];
}


- (void)onRecordStoped
{
    if ([ChatSoundRecorder sharedInstance].recordState == EChatRecorder_Stoped)
    {
        self.sendVoiceButton.selected = NO;
        [self.sendVoiceButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.sendVoiceButton setTitle:@"松开 结束" forState:UIControlStateSelected];
    }
}


-(void)sendVoiceWithSound:(NSData *)data duration:(NSInteger)dur
{
    
    TIMSoundElem *elem = [[TIMSoundElem alloc] init];
    elem.data = data;
    elem.second = (int)dur;
    
    TIMMessage *msg = [[TIMMessage alloc]init];
    
    [msg addElem:elem];
    
    self.audioBlock(msg);
    
}

- (void)onClickRecordTouchDown:(UIButton *)button
{
    self.sendVoiceButton.selected = YES;
    [[ChatSoundRecorder sharedInstance] startRecord];
}

- (void)onClickRecordDragExit:(UIButton *)button
{
    self.sendVoiceButton.selected = YES;
    [self.sendVoiceButton setTitle:@"按住 说话" forState:UIControlStateSelected];
    [[ChatSoundRecorder sharedInstance] willCancelRecord];
}

- (void)onClickRecordDragEnter:(UIButton *)button
{
    // 通知界面界面
    [[ChatSoundRecorder sharedInstance] continueRecord];
}

- (void)onClickRecordTouchUpOutside:(UIButton *)button
{
    self.sendVoiceButton.selected = NO;
    [self.sendVoiceButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [self.sendVoiceButton setTitle:@"松开 结束" forState:UIControlStateSelected];
    
    [[ChatSoundRecorder sharedInstance] stopRecord];
}

//轻击sendText切换键盘
-(void)tapGesture:(UITapGestureRecognizer *) sender
{
   
    if (![self.sendTextView isFirstResponder])
    {
        [self.sendTextView becomeFirstResponder];
    }
}

//切换声音按键和文字输入框
-(void)tapVoiceChangeButton:(UIButton *) sender
{
    
    if (self.sendVoiceButton.hidden == YES)
    {
        self.sendTextView.hidden = YES;
        self.sendVoiceButton.hidden = NO;
        
        self.sendTextView.userInteractionEnabled = NO;
        
        [self.voiceChangeButton setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateNormal];
        
        if ([self.sendTextView isFirstResponder]) {
            [self.sendTextView resignFirstResponder];
        }
    }
    else
    {
        self.sendTextView.hidden = NO;
        
        self.sendTextView.userInteractionEnabled = YES;
        
        self.sendVoiceButton.hidden = YES;
        [self.voiceChangeButton setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateNormal];
        
        if (![self.sendTextView isFirstResponder]) {
            [self.sendTextView becomeFirstResponder];
        }
    }
}

//发送信息（点击return）
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        
        //通过block回调把text的值传递到Controller中共
        self.textBlock(self.sendTextView.text);
        
        self.sendTextView.text = @"";
        
        return NO;
    }
    return YES;
}

//发送声音按钮回调的方法
-(void)tapSendVoiceButton:(UIButton *) sender
{
    //点击发送按钮没有触发长按手势要做的事儿
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"按住录音" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [alter show];
}

-(void)tapMoreButton:(UIButton*)button
{
    
    if ([self.sendTextView isFirstResponder])
    {
        [self.sendTextView resignFirstResponder];
    }
    
    self.picBlock();
    
}

-(void)dealloc
{
    [ChatSoundRecorder destory];
    [ChatSoundPlayer destory];
}

-(BOOL)becomeFirstResponder
{
    
    [self.sendTextView becomeFirstResponder];
    
    return YES;
    
}

@end
