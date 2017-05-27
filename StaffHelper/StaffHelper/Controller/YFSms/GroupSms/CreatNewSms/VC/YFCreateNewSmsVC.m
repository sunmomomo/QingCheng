//
//  YFCreateNewSmsVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//
//http://www.pc6.com/mac/137931.html
#import "YFCreateNewSmsVC.h"

#import "YFAddSmsPeopleCModel.h"

#import "YFModuleManager.h"

#import "YFTextView.h"

#import "YFSmsCreateViewModel.h"

#import "UIActionSheet+YFAdditions.h"

#import "YFAppService.h"

#import "UIView+YFLoadAniView.h"

#import "YFTagCollectionView.h"

#import "IQKeyboardManager.h"

@interface YFCreateNewSmsVC ()<UITextViewDelegate>

@property(nonatomic, strong)YFSmsCreateViewModel *viewModel;

// 判断编辑时 是否改动了
@property(nonatomic, assign)BOOL isSelectUsersArray;
@property(nonatomic, assign)BOOL isChangeText;

// 标签View
@property(nonatomic, strong)YFTagCollectionView *tagView;
// 删除标签 Block
@property(nonatomic, copy)void(^deleteBlock)(id);

@property(nonatomic, strong)UILabel *textNumberLabel;
@property(nonatomic, strong)UILabel *textMaxLabel;

@end

@implementation YFCreateNewSmsVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isSelectUsersArray = NO;
        _isChangeText = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    weakTypesYF
    [self setDeleteBlock:^(Student *model) {
        if ([weakS.tagView.modelArray containsObject:model])
        {
            NSUInteger totalCount = weakS.tagView.modelArray.count;
            NSUInteger index = [weakS.tagView.modelArray indexOfObject:model];
            DebugLogParamYF(@"删除%@",@(index));
            [weakS.tagView.modelArray removeObjectAtIndex:index];
            DebugLogParamYF(@"还剩%@",@(weakS.tagView.modelArray.count));
            
            weakS.isSelectUsersArray = YES;
            if (totalCount > MaxShowCount )
            {
                // 因为 删除 还得 保持collectionview的数据源个数不变，所以不能删除
                [weakS.tagView.collectionView reloadData];
            }else
            {
                [weakS.tagView.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
            }
        }
    }];
    
    [self initView];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 100;
}

- (void)initView
{
    // 编辑草稿 时，会预先设置
    if (self.title.length == 0)
    {
        self.title = @"新建群发短信";
    }
    self.leftTitle = @"取消";
    self.leftColor = [UIColor whiteColor];
    
    self.rightTitle = @"发送";
    
    if (self.editModel.users.count <=0  ||  self.editModel.content.length <= 0)
    {
        self.navi.rightButton.alpha = 0.5;
        self.navi.rightButton.enabled = NO;
    }
    [self.view addSubview:self.tagView];
    [self changeBottomLabelFrameToBottom];
}

- (void)requestData
{        // 编辑信息 self.editModel.title.length > 0 表示一定有值，users 里可能有空值（空值是为了显示空的收件人Cell）
    if (self.editModel.users.count && self.editModel.title.length)
    {
        [self.tagView addTagModelsArray:self.editModel.users];

    }else
    {
        // 初始化 信息
        [self.tagView addTagModelsArray:nil];
    }
    if (self.editModel.content.length)
    {
        self.tagView.textView.text = [self.tagView.textView.text stringByAppendingString:self.editModel.content];
     
        if ([self getText].length > 70)
        {
            [self showTextLabelNumIndicat];
        }
        [self setAttriStringToNumLabel];
    }
}

- (void)addActin:(YFAddSmsPeopleCModel *)model
{
  
    weakTypesYF
    UIViewController *chooseVC = [YFModuleManager chooseStudentViewControllerGym:self.gym  choosedArray:[self.tagView getTagModelsArray] isShowSelectView:NO chooseBlock:^(NSMutableArray * array) {
        
        DebugLogParamYF(@"-----------*****:%@",@(array.count));
        weakS.isSelectUsersArray = YES;
        [weakS.tagView addTagModelsArray:array];
        [weakS.navigationController popViewControllerAnimated:YES];
        [weakS checkRightButtonEnable];

    }];
    
    [self.navigationController pushViewController:chooseVC animated:YES];
}


- (void)moreTagAction:(id )model
{
    
    weakTypesYF
    UIViewController *chooseVC = [YFModuleManager chooseStudentViewControllerGym:self.gym  choosedArray:[self.tagView getTagModelsArray] isShowSelectView:YES chooseBlock:^(NSMutableArray * array) {
        
        DebugLogParamYF(@"-----------*****:%@",@(array.count));
        weakS.isSelectUsersArray = YES;
        [weakS.tagView addTagModelsArray:array];
        [weakS.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.navigationController pushViewController:chooseVC animated:YES];
}






- (void)naviRightClick
{
    if ([self.tagView isHaveTagData] && [self getText].length > 0)
    {
        DebugLogParamYF(@"发送");
        
        self.viewModel.send = @"1";
        if (self.editModel)
        {
            // 更新 短信
            [self updateSms];
        }
        else
        {
        [self sendOrSave];
        }
    }
    else
    {
        DebugLogParamYF(@"信息不全");
    }
}

- (void)naviLeftClick
{
    //1. 如果是新建，收件人和内容一项填写，就提示保存
    //2. 如果是编辑，只要改变了文字，和重新选择了收件人 就提示保存
    if ((([self.tagView isHaveTagData] || [self getText].length > 0) && !self.editModel) || (self.editModel && (self.isSelectUsersArray || self.isChangeText)))
    {
        weakTypesYF
        [UIActionSheet actionSWithCallBackBlock:^(NSInteger buttonIndex) {
    
            switch (buttonIndex) {
                case 0:
                {
                    DebugLogParamYF(@"不保存草稿");
                    [self.navigationController popViewControllerAnimated:YES];
                }
                    break;
                case 1:
                {
                    DebugLogParamYF(@"保存草稿");
                    weakS.viewModel.send = nil;
                    if (self.editModel)
                    {
                        // 更新 短信
                        [self updateSms];
                    }
                    else
                    {
                    [weakS sendOrSave];
                    }
                }
                    break;
                default:
                    break;
            }
        } title:@"取消编辑" destructiveButtonTitle:@"不保存" cancelButtonName:@"取消" otherButtonTitles:@"保存为草稿", nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (void)sendOrSave
{
    weakTypesYF
    self.viewModel.content = [self getText];
    
    [self.viewModel setChooseArrayForIds:[self.tagView getTagModelsArray]];
    self.view.loadViewYF.frame = CGRectMake(0, 64.0, self.view.width, self.view.height - 64.0);
    
    [self.viewModel sendSMSDatashowLoadingOn:self.view gym:self.gym successBlock:^{
        
        if (weakS.viewModel.send)
        {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostSenderGroupSmsSuccessIdtifierYF object:nil];
        }else
        {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddSmsDraftSuccessIdtifierYF object:nil];
        }
    } failBlock:^{
        [YFAppService showAlertMessage:@"网络不给力" sureTitle:@"重新发送" sureBlock:^{
            [weakS sendOrSave];
        }];
    }];
}

- (void)updateSms
{
    self.viewModel.message_id = self.editModel.sms_id;
    self.viewModel.content = [self getText];
    [self.viewModel setChooseArrayForIds:[self.tagView getTagModelsArray]];
    
    self.view.loadViewYF.frame = CGRectMake(0, 64.0, self.view.width, self.view.height - 64.0);
    weakTypesYF
    [self.viewModel updateSMSDatashowLoadingOn:self.view gym:self.gym successBlock:^{
        
        if (weakS.viewModel.send)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kPostSenderGroupDraftSmsSuccessIdtifierYF object:nil];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kPostUpdataSmsDraftSuccessIdtifierYF object:nil];
        }
    } failBlock:^{
       

    }];
}

- (void)checkRightButtonEnable
{
    if ([self.tagView isHaveTagData] <=0  ||  [self getText].length <= 0)
    {
        self.navi.rightButton.alpha = 0.5;
        self.navi.rightButton.enabled = NO;
    }else
    {
        self.navi.rightButton.alpha = 1.0;
        self.navi.rightButton.enabled = YES;

    }
}


- (YFSmsCreateViewModel *)viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [YFSmsCreateViewModel dataModel];
    }
    
    return _viewModel;
}

- (YFTagCollectionView *)tagView
{
    if (_tagView == nil)
    {
        YFTagCollectionView *tagView = [[YFTagCollectionView alloc] initWithFrame:CGRectMake(0, 64.0, MSW, MSH - 64.0)];

        tagView.textView.delegate = self;
        
        
        
        weakTypesYF
        [tagView setAddTagBlock:^(id model) {
            [weakS addActin:model];
        }];
        
        [tagView setMoreTagBlock:^(id model) {
            [weakS moreTagAction:model];
        }];
        
        tagView.deleteBlock = self.deleteBlock;
        _tagView = tagView;
    }
    return _tagView;
}

-(NSString *)getText
{
    NSString *text = [self.tagView.textView.text stringByReplacingCharactersInRange:NSMakeRange(0, YFSpaceTextLength) withString:@""];
    
    return text;
}


- (void)textViewDidChange:(UITextView *)textView
{
//    [self.tagView.textView setNeedsDisplay];
    [self checkRightButtonEnable];
    _isChangeText = YES;
    
    if ([self getText].length > 70)
    {
        [self showTextLabelNumIndicat];
    }
    else
    {
        [self hideTextLabelNumIndicat];
    }
    [self setAttriStringToNumLabel];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location <= YFSpaceTextLength - 1)
    {
        return NO;
    }
    return YES;
}

- (UILabel *)textNumberLabel
{
    if (!_textNumberLabel)
    {
        _textNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, MSW - 30, 18)];
        
        _textNumberLabel.textAlignment = NSTextAlignmentRight;
        
       _textNumberLabel.alpha = 0;
        
       [self.view addSubview:_textNumberLabel];
    }
    return _textNumberLabel;
}

-(void)setAttriStringToNumLabel
{
    NSString *content = [self getText];
 
    if (content.length <= 70)
    {
        return;
    }
    NSString *string = [NSString stringWithFormat:@"%@/70",@(content.length)];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attri addAttribute:NSFontAttributeName value:FontSizeFY(13.0) range:NSMakeRange(0, attri.length)];
    
    [attri addAttribute:NSForegroundColorAttributeName value:RGB_YF(249, 148, 78) range:NSMakeRange(0, attri.length - 3)];
    
    [attri addAttribute:NSForegroundColorAttributeName value:RGB_YF(136, 136, 136) range:NSMakeRange(attri.length - 3, 3)];
    
    [_textNumberLabel setAttributedText:attri];
}

- (UILabel *)textMaxLabel
{
    if (!_textMaxLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, MSW - 30, 17)];
        
        label.text = @"字数超过运营商限制，将被拆分成多条发送";
        
        label.font = FontSizeFY(13.0);
        
        label.textColor = RGB_YF(187, 187, 187);
        label.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:label];
        label.alpha = 0;
        _textMaxLabel = label;
    }
    return _textMaxLabel;
}

#pragma mark - UIKeyboad Notification methods
-(void)keyboardWillShow:(NSNotification*)aNotification
{
   CGRect kbFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [self.tagView.textView changeHeight:MSH - 64.0 - 53 - kbFrame.size.height];
   
    [self setAttriStringToNumLabel];
    
    [self.textMaxLabel changeTop:MSH - kbFrame.size.height - 5 - self.textMaxLabel.height];
    [self.textNumberLabel changeTop:MSH - kbFrame.size.height - self.textNumberLabel.height - self.textMaxLabel.height - 9];
}

-(void)keyboardWillHide:(NSNotification*)aNotification
{
    [self changeBottomLabelFrameToBottom];
    [self.tagView.textView changeHeight:self.tagView.footerModel.cellSize.height - 10];
}

- (void)showTextLabelNumIndicat
{

    [UIView animateWithDuration:0.2 animations:^{
        self.textMaxLabel.alpha = 1.0;
        self.textNumberLabel.alpha = 1.0;
        [self.tagView changeHeight:MSH - 64.0 - self.textNumberLabel.height - self.textMaxLabel.height - 10];
    }];
}
- (void)changeBottomLabelFrameToBottom
{
    [self.textMaxLabel changeTop:MSH  - 5 - self.textMaxLabel.height];
    [self.textNumberLabel changeTop:MSH  - self.textNumberLabel.height - self.textMaxLabel.height - 9];
 
}

- (void)hideTextLabelNumIndicat
{
    self.textMaxLabel.alpha = 0;
    self.textNumberLabel.alpha = 0;
    
    [self.tagView changeHeight:MSH - 64.0];
}


@end
