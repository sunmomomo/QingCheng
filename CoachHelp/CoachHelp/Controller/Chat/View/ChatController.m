//
//  ChatController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatController.h"

#import "ChatInfoController.h"

#import "RootController.h"

#import "PictureShowController.h"

#import "ChatCell.h"

#import "MOActionSheet.h"

#import "ChatToolView.h"

#import "KeyboardManager.h"

#import <AVFoundation/AVFoundation.h>

#import "ChatSoundRecorder.h"

#import "MOTool.h"

// 聊天图片缩约图最大高度
#define kChatPicThumbMaxHeight 190.f
// 聊天图片缩约图最大宽度
#define kChatPicThumbMaxWidth 66.f

static NSString *textIdentifier = @"Text";

static NSString *imageIdentifier = @"Image";

static NSString *voiceIdentifier = @"Voice";

static NSString *timeIdentifier = @"Time";

static NSString *systemIdentifier = @"System";

@interface ChatController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MOActionSheetDelegate,TIMMessageListener,ChatCellFunctionDelegate>
//工具栏
@property (nonatomic,strong) ChatToolView *toolView;
//音量图片
@property (strong, nonatomic) UIImageView *volumeImageView;

@property(nonatomic,strong)NSArray *chats;

@property(nonatomic,strong)UITableView *tableView;
//从相册获取图片
@property (strong, nonatomic)UIImagePickerController *imagePiceker;

@property(nonatomic,strong)ChatInfo *info;

@property(nonatomic,strong)TIMConversation *conversation;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)UIImage *image;

@end

@implementation ChatController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(void)createData
{
    
    [[TIMManager sharedInstance]addMessageListener:self];
        
    TIMConversation * conversation = [[TIMManager sharedInstance] getConversation:self.chatListModel.type == ChatListModelTypeChatSingle?TIM_C2C:TIM_GROUP receiver:self.chatListModel.identifier];
    
    self.conversation = conversation;
    
    [conversation setReadMessage];
    
    self.info = [[ChatInfo alloc]init];
    
    [self.info requestWithModel:self.chatListModel result:^(BOOL success, NSString *error) {
        
        self.chats = [self.info.chats copy];
        
        [self.tableView reloadData];
        
        if (self.tableView.contentSize.height>self.tableView.height) {
            
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height-self.tableView.height) animated:NO];
            
        }
        
    }];
    
    [[RootController sharedSliderController]reloadMessageData];
    
}

-(void)onNewMessage:(NSArray *)msgs
{
    
    [self reloadData];
    
}

-(void)updateData
{
    
    NSUInteger count = self.info.chats.count;
    
    [self.info requestForwardWithModel:self.chatListModel result:^(BOOL success, NSString *error) {
        
        self.chats = [self.info.chats copy];
        
        [self.tableView reloadData];
        
        if (count <self.info.chats.count) {
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.info.chats.count-count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        }
        
    }];
    
}

-(void)reloadData
{
    
    [[RootController sharedSliderController]reloadMessageData];
    
    self.info = [[ChatInfo alloc]init];
    
    [self.info requestWithModel:self.chatListModel result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.title = self.chatListModel.type == ChatListModelTypeChatSingle?self.chatListModel.user.username:[NSString stringWithFormat:@"%@(%ld)",self.chatListModel.group.name,(long)self.chatListModel.group.userCount];
            
        }
        
        self.chats = [self.info.chats copy];
        
        [self.tableView reloadData];
        
        if (self.tableView.contentSize.height>self.tableView.height) {
            
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height-self.tableView.height) animated:NO];
            
        }
        
    }];
    
    [[RootController sharedSliderController]reloadMessageData];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.title = self.chatListModel.type == ChatListModelTypeChatSingle?self.chatListModel.user.username:[NSString stringWithFormat:@"%@(%ld)",self.chatListModel.group.name,(long)self.chatListModel.group.userCount];
    
    if (self.chatListModel.type == ChatListModelTypeChatGroup) {
        
        self.rightImg = [UIImage imageNamed:@"chat_right_member_group"];
        
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-52-64) style:UITableViewStylePlain];
    
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardReturn)]];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[ChatTextCell class] forCellReuseIdentifier:textIdentifier];
    
    [self.tableView registerClass:[ChatImageCell class] forCellReuseIdentifier:imageIdentifier];
    
    [self.tableView registerClass:[ChatVoiceCell class] forCellReuseIdentifier:voiceIdentifier];
    
    [self.tableView registerClass:[ChatTimeCell class] forCellReuseIdentifier:timeIdentifier];
    
    [self.tableView registerClass:[ChatSystemCell class] forCellReuseIdentifier:systemIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 15)];
    
    [self.view addSubview:self.tableView];
    
    //工具栏
    _toolView = [[ChatToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, MSW, 52)];
    [self.view addSubview:_toolView];

    //设置工具栏的回调
    [self setToolViewBlock];
    
    //获取通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //注册为被通知者
    [notificationCenter addObserver:self selector:@selector(keyChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [_toolView becomeFirstResponder];
    
}

-(void)keyboardReturn
{
    
    [self.view endEditing:YES];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}

//实现工具栏的回调
-(void)setToolViewBlock
{
    
    __weak typeof(self)weakS = self;
    //通过block回调接收到toolView中的text
    [self.toolView setMyTextBlock:^(NSString *myText) {
        
        TIMTextElem *elem = [[TIMTextElem alloc]init];
        
        elem.text = myText;
        
        TIMMessage *message = [[TIMMessage alloc]init];
        
        [message addElem:elem];
        
        [weakS.conversation sendMessage:message succ:^{
            
            [weakS reloadData];
            
        } fail:^(int code, NSString *msg) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:weakS.view];
            
            [weakS.view addSubview:hud];
            
            hud.mode = MBProgressHUDModeText;
            
            hud.label.text = @"发送失败";
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }];
        
    }];
    
    [self.toolView setAudioSendBlock:^(TIMMessage *msg) {
        
        [weakS.conversation sendMessage:msg succ:^{
            
            [weakS reloadData];
            
        } fail:^(int code, NSString *msg) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:weakS.view];
            
            [weakS.view addSubview:hud];
            
            hud.mode = MBProgressHUDModeText;
            
            hud.label.text = @"发送失败";
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }];
        
    }];
    
    //图片回调
    [self.toolView setPictureBlock:^{
        
        MOActionSheet *sheet = [MOActionSheet actionSheetWithTitie:@"发送图片" delegate:weakS destructiveButtonTitle:nil cancelButtonTitle:@"取消" otherButtonTitles:@"打开摄像头",@"从相册选择",nil];
        
        [sheet show];
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.chats.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatModel *model = self.chats[indexPath.row];
    
    if (self.chatListModel.type == ChatListModelTypeChatSingle) {
        
        return model.cellHeight;
        
    }else{
        
        if (model.type != ChatTypeTime && model.type != ChatTypeSystem) {
            
            return model.cellHeight+Height(17);
            
        }else{
            
            return model.cellHeight;
            
        }
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatModel *model = self.chats[indexPath.row];
    
    if (model.type == ChatTypeLabel) {
        
        ChatTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textIdentifier];
        
        cell.isMine = model.isMine;
        
        cell.content = model.content;
        
        cell.iconURL = model.user.iconURL;
        
        cell.userName = model.user.username;
        
        cell.isGroup = self.chatListModel.type == ChatListModelTypeChatGroup;
        
        cell.tag = indexPath.row;
        
        cell.index = model.tag;
        
        cell.delegate = nil;
        
        return cell;
        
    }else if (model.type == ChatTypeImage){
        
        ChatImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imageIdentifier];
        
        cell.isGroup = self.chatListModel.type == ChatListModelTypeChatGroup;
        
        cell.isMine = model.isMine;
        
        cell.imageHeight = model.imageHeight;
        
        cell.imageURL = model.imageThumbURL;
        
        cell.iconURL = model.user.iconURL;
        
        cell.userName = model.user.username;
        
        cell.tag = indexPath.row;
        
        cell.index = model.tag;
        
        cell.delegate = self;
        
        return cell;
        
    }else if (model.type == ChatTypeVoice){
        
        ChatVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:voiceIdentifier];
        
        cell.isMine = model.isMine;
        
        cell.isGroup = self.chatListModel.type == ChatListModelTypeChatGroup;
        
        cell.voiceLength = model.voiceLength;
        
        cell.iconURL = model.user.iconURL;
        
        cell.userName = model.user.username;
        
        cell.tag = indexPath.row;
        
        cell.index = model.tag;
        
        cell.delegate = self;
        
        cell.unread = model.unRead;
        
        return cell;
        
    }else if(model.type == ChatTypeTime){
        
        ChatTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:timeIdentifier];
        
        cell.time = [MOTool formatAllShowTimeStringWithDate:model.date];
        
        return cell;
        
    }else{
        
        ChatSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:systemIdentifier];
        
        cell.content = model.content;
        
        return cell;
        
    }
    
}

-(void)actionSheet:(MOActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if(buttonIndex == 1)
    {
        
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            
            
            [[[UIAlertView alloc]initWithTitle:@"提示" message:@"相机访问受限，请到设置-隐私-相机中允许【健身房管理】访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
        }
        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 2)
    {
        //从相册选择
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else
    {
        return;
    }
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        [self performSelector:@selector(showCamera:) withObject:[NSNumber numberWithInteger:sourceType] afterDelay:1.0f];
        
    }else
    {
        
        self.imagePickerController = [[UIImagePickerController alloc] init];
        
        self.imagePickerController.delegate = self;
        
        self.imagePickerController.allowsEditing = NO;
        
        self.imagePickerController.sourceType = sourceType;
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{}];
        
    }
    
}

-(void)showCamera:(NSNumber*)typeNumber
{
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    
    self.imagePickerController.delegate = self;
    
    self.imagePickerController.allowsEditing = NO;
    
    self.imagePickerController.sourceType = [typeNumber integerValue];
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    TIMImageElem *elem = [[TIMImageElem alloc]init];
    
    UIImage *image = [[info objectForKey:UIImagePickerControllerOriginalImage]fixOrientation];
    
    CGFloat scale = 1;
    scale = MIN(kChatPicThumbMaxHeight/image.size.height, kChatPicThumbMaxWidth/image.size.width);
    
    CGFloat picHeight = image.size.height;
    CGFloat picWidth = image.size.width;
    NSInteger picThumbHeight = (NSInteger) (picHeight * scale + 1);
    NSInteger picThumbWidth = (NSInteger) (picWidth * scale + 1);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *nsTmpDIr = NSTemporaryDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@uploadFile%3.f", nsTmpDIr, [NSDate timeIntervalSinceReferenceDate]];
    BOOL isDirectory = NO;
    NSError *err = nil;
    
    // 当前sdk仅支持文件路径上传图片，将图片存在本地
    if ([fileManager fileExistsAtPath:filePath isDirectory:&isDirectory])
    {
        [fileManager removeItemAtPath:nsTmpDIr error:&err];
    }
    
    [fileManager createFileAtPath:filePath contents:UIImageJPEGRepresentation(image, 1) attributes:nil];
    
    NSString *thumbPath = [NSString stringWithFormat:@"%@uploadFile%3.f_ThumbImage", nsTmpDIr, [NSDate timeIntervalSinceReferenceDate]];
    UIImage *thumbImage = [image thumbnailWithSize:CGSizeMake(picThumbWidth, picThumbHeight)];
    
    [fileManager createFileAtPath:thumbPath contents:UIImageJPEGRepresentation(thumbImage, 1) attributes:nil];
    
    elem.path = filePath;
    
    TIMMessage *message = [[TIMMessage alloc]init];
    
    [message addElem:elem];
    
    MBProgressHUD *imgHUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:imgHUD];
    
    imgHUD.mode = MBProgressHUDModeIndeterminate;
    
    imgHUD.label.text = @"发送中...";
    
    [imgHUD showAnimated:YES];
    
    [self.conversation sendMessage:message succ:^{
        
        if (self) {
            
            imgHUD.mode = MBProgressHUDModeText;
            
            imgHUD.label.text = @"发送成功";
            
            [imgHUD hideAnimated:YES afterDelay:1.5];
            
            [self reloadData];
            
        }
        
    } fail:^(int code, NSString *msg) {
        
        if (self) {
            
            imgHUD.mode = MBProgressHUDModeText;
            
            imgHUD.label.text = @"发送失败";
            
            [imgHUD hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//键盘出来的时候调整tooView的位置
-(void) keyChange:(NSNotification *) notify
{
    
    NSDictionary *userInfo = notify.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        
        if (keyboardF.origin.y >= MSH) {
            
            [self.tableView changeHeight:MSH-64-52];
            
            [self.toolView changeTop:self.tableView.bottom];
            
        }else
        {
            
            [self.tableView changeHeight:MSH-self.tableView.top-keyboardF.size.height-52];
            
            self.tableView.contentOffset = CGPointMake(0, self.tableView.contentSize.height-self.tableView.height);
            
            [self.toolView changeTop:self.tableView.bottom];
            
        }
        
    }];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (self.tableView.contentSize.height>self.tableView.height) {
        
        if (scrollView == self.tableView) {
            
            if (self.tableView.contentOffset.y<20) {
                
                [self updateData];
                
            }
            
        }
        
    }
    
}

-(void)naviRightClick
{
    
    ChatInfoController *vc = [[ChatInfoController alloc]init];
    
    vc.model = self.chatListModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)functionWithCell:(ChatCell *)cell
{
    
    [self.view endEditing:YES];
    
    ChatModel *model = self.chats[cell.tag];
    
    if (model.type == ChatTypeLabel) {
        
        return ;
        
    }else if (model.type == ChatTypeImage){
        
        NSURL *imageURL = model.imageURL;
        
        PictureShowController *vc = [[PictureShowController alloc]init];
        
        vc.imageURL = imageURL;
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }else if (model.type == ChatTypeVoice){
        
        NSString *voicePath = model.voicePath;
        
        NSData *data = [[NSData alloc]initWithContentsOfFile:voicePath];
        
        [[ChatSoundPlayer sharedInstance]stopPlay];
        
        ChatVoiceCell *voiceCell = (ChatVoiceCell*)cell;
        
        [voiceCell play];
        
        [self.info setReadAtIndex:cell.index];
        
        [[ChatSoundPlayer sharedInstance]playWith:data finish:^{
            
            [voiceCell stop];
            
        }];
        
    }
    
}

-(void)dealloc
{
    
    [[ChatSoundPlayer sharedInstance]stopPlay];
    
    [ChatSoundPlayer destory];
    
}

@end
