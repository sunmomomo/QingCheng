//
//  EditTestController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/2.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "EditTestController.h"

#import <AVFoundation/AVFoundation.h>

#import "UpYun.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "TestPictureView.h"

@interface EditTestController ()<QCKeyboardViewDelegate,UITextFieldDelegate,TestPictureViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)QCTextField *testTimeTF;

@property(nonatomic,strong)NSMutableArray *basicTextFields;

@property(nonatomic,strong)NSMutableArray *otherTextFields;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)NSMutableArray *photoViews;

@property(nonatomic,strong)UIView *photoView;

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,assign)BOOL isUploading;

@end

@implementation EditTestController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self createUI];
    
    if (self.isAdd) {
        
        [self createData];
        
    }else
    {
        
        [self reloadUI];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.testInfo = [[BodyTestInfo alloc]init];
    
    [self.testInfo getAddInfoWithStudent:self.stu];
    
    __weak typeof(self)weakS = self;
    
    self.testInfo.request = ^(BOOL success){
       
        [weakS reloadUI];
        
    };
    
}


-(void)createUI
{
    
    self.title = self.isAdd?@"添加体测数据":@"编辑体测数据";
    
    self.rightTitle = @"保存";
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(44))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:topView];
    
    topView.layer.shadowColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.shadowOffset = CGSizeMake(0, 1);
    
    topView.layer.shadowOpacity = 0.3;
    
    self.testTimeTF = [[QCTextField alloc]initWithFrame: CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(38))];
    
    self.testTimeTF.placeholder = @"体测日期";
    
    self.testTimeTF.noLine = YES;
    
    self.testTimeTF.delegate = self;
    
    [topView addSubview:self.testTimeTF];
    
    QCKeyboardView *timeKV = [QCKeyboardView defaultKeboardView];
    
    timeKV.delegate = self;
    
    timeKV.tag = 101;
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.datePicker.date = [NSDate date];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.datePicker.maximumDate = [NSDate date];
    
    timeKV.keyboard = self.datePicker;
    
    self.testTimeTF.inputView = timeKV;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom, self.testTimeTF.width, topView.height)];
    
    label.text = @"体测数据";
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.font = STFont(14);
    
    [self.mainView addSubview:label];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    self.hud.mode = MBProgressHUDModeText;
        
}

-(void)reloadUI
{
    
    self.testTimeTF.text = self.testInfo.date;
    
    self.basicTextFields = [NSMutableArray array];
    
    self.otherTextFields = [NSMutableArray array];
    
    UIView *secView = [[UIView alloc]initWithFrame:CGRectMake(0,Height320(88), MSW, Height320(44)*(self.testInfo.basicTypes.count+self.testInfo.otherTypes.count))];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secView.layer.shadowColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secView.layer.shadowOffset = CGSizeMake(0, 1);
    
    secView.layer.shadowOpacity = 0.3;
    
    [self.mainView addSubview:secView];
    
    [self.mainView setContentSize:CGSizeMake(0, secView.bottom+Height320(20))];
    
    for (NSInteger i = 0;i<self.testInfo.basicTypes.count;i++) {
        
        QCTextField *textField = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), i*Height320(44), MSW-Width320(32), Height320(44))];
        
        BodyTestType *type = self.testInfo.basicTypes[i];
        
        textField.placeholder = type.unit.length?[NSString stringWithFormat:@"%@(%@)",type.typeName,type.unit]:type.typeName;
        
        textField.placeholderColor = UIColorFromRGB(0x999999);
        
        textField.text = type.value;
        
        textField.delegate = self;
        
        textField.tag = i;
        
        [textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
        if (!self.testInfo.otherTypes.count && i == self.testInfo.basicTypes.count-1) {
            
            textField.noLine = YES;
            
        }
        
        [self.basicTextFields addObject:textField];
        
        [secView addSubview:textField];
        
    }
    
    for (NSInteger i = 0;i<self.testInfo.otherTypes.count;i++) {
        
        QCTextField *textField = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), (i+self.testInfo.basicTypes.count)*Height320(44), MSW-Width320(32), Height320(44))];
        
        BodyTestType *type = self.testInfo.otherTypes[i];
        
        textField.placeholder = type.unit.length?[NSString stringWithFormat:@"%@(%@)",type.typeName,type.unit]:type.typeName;
        
        textField.placeholderColor = UIColorFromRGB(0x999999);
        
        textField.text = type.value;
        
        textField.delegate = self;
        
        if (i == self.testInfo.otherTypes.count-1) {
            
            textField.noLine = YES;
            
        }
        
        textField.tag = i;
        
        [textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [self.otherTextFields addObject:textField];
        
        [secView addSubview:textField];

    }
    
    UILabel *photoLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), secView.bottom, Width320(200), Height320(44))];
    
    photoLabel.text = @"体测照片";
    
    photoLabel.textColor = UIColorFromRGB(0x999999);
    
    photoLabel.font = STFont(14);
    
    [self.mainView addSubview:photoLabel];
    
    self.photoView = [[UIView alloc]initWithFrame:CGRectMake(0, photoLabel.bottom, MSW, Height320(200))];
    
    [self.mainView addSubview:self.photoView];
    
    [self reloadPhotoView];
    
    if (!self.isAdd) {
        
        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.photoView.bottom, MSW, Height320(44))];
        
        self.deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.deleteButton setTitle:@"删除体测数据" forState:UIControlStateNormal];
        
        [self.deleteButton setTitleColor:UIColorFromRGB(0xEA6161) forState:UIControlStateNormal];
        
        self.deleteButton.titleLabel.font = STFont(16);
        
        [self.mainView addSubview:self.deleteButton];
        
        [self.deleteButton addTarget:self action:@selector(deleteTest:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView setContentSize:CGSizeMake(0, self.deleteButton.bottom)];
        
    }

}

-(void)reloadPhotoView
{
    
    [self.photoView removeAllView];
    
    self.photoViews = [NSMutableArray array];
    
    CGFloat width = (MSW-Width320(20))/3;
    
    for (NSInteger i = 0; i<=self.testInfo.photos.count; i++) {
        
        NSInteger row = i%3;
        
        NSInteger section = i/3;
        
        TestPictureView *pictureView = [[TestPictureView alloc]initWithFrame:CGRectMake(Width320(5)+row*(width+Width320(5)), Height320(6)+section*(width+Height320(5)), width, width)];
        
        if (i<self.testInfo.photos.count) {
            
            NSString *urlStr = self.testInfo.photos[i];
            
            if ([urlStr rangeOfString:@"!/watermark/"].length) {
                
                pictureView.imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@!120x120/watermark/%@",[[urlStr componentsSeparatedByString:@"!/watermark/"]firstObject],[[urlStr componentsSeparatedByString:@"!/watermark/"]lastObject]]];
                
            }else if ([urlStr rangeOfString:@"/watermark/"].length){
                
                pictureView.imgUrl = [NSURL URLWithString:urlStr];
                
            }else{
                
                pictureView.imgUrl = [NSURL URLWithString:[urlStr stringByAppendingString:@"!120x120"]];
                
            }
            
            pictureView.canDelete = YES;
            
        }else
        {
            
            pictureView.image = [UIImage imageNamed:@"body_test_add"];
            
            pictureView.canDelete = NO;
            
        }
        
        pictureView.tag = i;
        
        pictureView.delegate = self;
        
        [self.photoView addSubview:pictureView];
        
        [self.photoViews addObject:pictureView];
        
        [self.photoView changeHeight:self.isAdd?pictureView.bottom+Height320(20):pictureView.bottom+Height320(64)];
        
        [self.mainView setContentSize:CGSizeMake(0, self.photoView.bottom)];
        
    }
    
    if (!self.isAdd) {
        
        [self.deleteButton changeTop:self.photoView.bottom+Height320(10)];
        
        [self.mainView setContentSize:CGSizeMake(0, self.deleteButton.bottom)];
        
    }

}

-(void)deleteTest:(UIButton*)button
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除这条体测信息吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    alert.tag = 1;
    
    [alert show];
    
}

-(void)pictureViewClick:(TestPictureView *)pictureView
{
    
    self.currentIndex = pictureView.tag;
    
    UIActionSheet *actionSheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        
    }else{
        
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
        
    }
    
    actionSheet.delegate = self;
    
    actionSheet.tag = pictureView.tag;
    
    [actionSheet showInView:self.view];
    
}


-(void)deleteClick:(UIButton *)btn
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除该照片吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = btn.tag+100;
    
    [alert show];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if(buttonIndex == 0)
        {
            
            NSString *mediaType = AVMediaTypeVideo;
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"摄像头访问受限，请到设置-隐私-相机中允许健身教练助手访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
            }
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            
        }else if(buttonIndex == 1)
        {
            //从相册选择
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else
        {
            return;
        }
    }else{
        if (buttonIndex == 0) {
            
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
        }else
        {
            
            return;
            
        }
        
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
        self.currentIndex = actionSheet.tag;
        
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self uploadImgae:[UIImage imageWithData:UIImageJPEGRepresentation([UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]], 0.5)] withIndex:self.currentIndex];
    
}

-(void)uploadImgae:(UIImage *)image withIndex:(NSInteger)index
{
    
    NSString *url = [UpYun getSaveKey];
    
    if (index >= self.testInfo.photos.count) {
        
        [self.testInfo.photos addObject:@""];
        
    }else
    {
        
        [self.testInfo.photos replaceObjectAtIndex:index withObject:@""];
        
    }
    
    [self reloadPhotoView];
    
    TestPictureView *pictureView = self.photoViews[index];
    
    UpYun *uy = [[UpYun alloc]init];
    
    self.isUploading = YES;
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        [self.testInfo.photos replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
        
        [self reloadPhotoView];
        
        self.isUploading = NO;
        
    };
    
    uy.failBlocker = ^(NSError *error){
        
        [self.testInfo.photos removeObjectAtIndex:index];
        
        [self reloadPhotoView];
        
        self.isUploading = NO;
        
    };
    
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes)
    {
        
        pictureView.progress = percent;
        
    };
    
    [uy uploadImage:image savekey:url];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1) {
        
        if (buttonIndex == 1) {
            
            [self.testInfo deleteInfo];
            
            __weak typeof(self)weakS = self;
            
            self.testInfo.deleteFinish = ^(BOOL success){
                
                if (success) {
                    [weakS deleteSuccess];
                }else
                {
                    
                    [weakS changeErrorWithMsg:@"删除失败，请稍后重试"];
                    
                }
                
            };
            
        }
        
    }else if (alertView.tag >=100) {
        
        if (buttonIndex == 1) {
            
            [self.testInfo.photos removeObjectAtIndex:alertView.tag-100];
            
            [self reloadPhotoView];
            
        }
        
    }
    
}

-(void)allResignFirstResponder
{
    
    [self.view endEditing:YES];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    if (keyboadeView.tag == 101) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        self.testTimeTF.text = [dateFormatter stringFromDate:self.datePicker.date];
        
        self.testInfo.date = self.testTimeTF.text;
        
        [self allResignFirstResponder];
        
    }
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if ([self.basicTextFields containsObject:textField]) {
        
        NSInteger i = [self.basicTextFields indexOfObject:textField];
        
        BodyTestType *type = self.testInfo.basicTypes[i];
        
        type.value = textField.text;
        
    }else if ([self.otherTextFields containsObject:textField])
    {
        
        NSInteger i = [self.otherTextFields indexOfObject:textField];
        
        BodyTestType *type = self.testInfo.otherTypes[i];
        
        type.value = textField.text;
        
    }
    
}

-(void)naviRightClick
{
    
    if (self.isUploading) {
        
        [[[UIAlertView alloc]initWithTitle:@"正在上传图片，请稍后" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    [self.testInfo changeInfoWithIsAdd:self.isAdd];
    
    __weak typeof(self)weakS = self;
    
    self.testInfo.changeFinish = ^(BOOL success){
        
        if (success) {
            
            [weakS changeSuccess];
            
        }else
        {
            
            [weakS changeErrorWithMsg:@"修改失败，请稍后重试"];
            
        }
        
    };
    
}

-(void)deleteSuccess
{
    
    self.hud.label.text = @"删除成功";
    
    [self.hud showAnimated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.navigationController popViewControllerAnimated:NO];
        
        if (self.deleteTest) {
            self.deleteTest();
        }
        
    });
    
}

-(void)changeSuccess
{
    
    self.hud.label.text = self.isAdd?@"添加成功":@"修改成功";
    
    [self.hud showAnimated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.editFinish) {
            self.editFinish(self.testInfo);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    });
    
}

-(void)changeErrorWithMsg:(NSString *)message
{
    
    self.hud.label.text = message;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0];
    
}

@end
