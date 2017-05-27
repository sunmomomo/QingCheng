//
//  TestShowController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/2.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "TestShowController.h"

#import "PictureShowController.h"

#import "EditTestController.h"

#import "BodyTestInfo.h"

#import "QCTextField.h"

@interface TestShowController ()<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView *bodyTestImg;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)BodyTestInfo *testInfo;

@property(nonatomic,strong)NSMutableArray *imageViews;

@end

@implementation TestShowController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.testInfo = [[BodyTestInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    [self.testInfo getInfoWithTest:self.bodyTest];
    
    self.testInfo.request = ^(BOOL success){
        
        [weakS reloadUI];
        
    };
    
}

-(void)createUI
{

    self.rightType = MONaviRightTypeEdit;
    
    self.title = @"体测数据";
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    self.bodyTestImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(72.5), (MSH-64)/2-Width320(210), Width320(145), Height320(420))];
    
    self.bodyTestImg.contentMode = UIViewContentModeScaleAspectFit;
    
    self.bodyTestImg.image = [UIImage imageNamed:[self.bodyTest.student.gender isEqualToString:@"女"]?@"body_test_female":@"body_test_male"];
    
    [self.mainView addSubview:self.bodyTestImg];
    
}

-(void)reloadUI
{
    
    [self.mainView removeAllView];
    
    [self.mainView addSubview:self.bodyTestImg];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(8), Height320(16), Width320(150), Height320(18))];
    
    timeLabel.text = [NSString stringWithFormat:@"%@体测数据",self.testInfo.date];
    
    timeLabel.textColor = UIColorFromRGB(0x222222);
    
    timeLabel.font = AllFont(13);
    
    [self.mainView addSubview:timeLabel];
    
    UILabel *bodyLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(14), Height320(129),[self.testInfo getTypeForTypeName:@"上臂围（左）"]?Width320(120):0, Height320(17))];
    
    bodyLabel1.text = [self.testInfo getTypeForTypeName:@"上臂围（左）"].value.length?[NSString stringWithFormat:@"上臂围（左）  %@cm",[self.testInfo getTypeForTypeName:@"上臂围（左）"].value]:@"";
    
    bodyLabel1.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel1.font = AllFont(13);
    
    bodyLabel1.textAlignment = NSTextAlignmentRight;
    
    [self.mainView addSubview:bodyLabel1];
    
    UILabel *bodyLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(190), Height320(129),[self.testInfo getTypeForTypeName:@"上臂围（右）"]?Width320(120):0, Height320(17))];
    
    bodyLabel2.text = [self.testInfo getTypeForTypeName:@"上臂围（右）"].value.length?[NSString stringWithFormat:@"上臂围（右）  %@cm",[self.testInfo getTypeForTypeName:@"上臂围（右）"].value]:@"";
    
    bodyLabel2.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel2.font = AllFont(13);
    
    [self.mainView addSubview:bodyLabel2];
    
    UILabel *bodyLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(159), Height320(155), Width320(100),[self.testInfo getTypeForTypeName:@"胸围"]?Height320(17):0)];
    
    bodyLabel3.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel3.font = AllFont(13);
    
    bodyLabel3.text = [self.testInfo getTypeForTypeName:@"胸围"].value.length?[NSString stringWithFormat:@"胸围  %@cm",[self.testInfo getTypeForTypeName:@"胸围"].value]:@"";
    
    bodyLabel3.textAlignment = NSTextAlignmentCenter;
    
    [self.mainView addSubview:bodyLabel3];
    
    UILabel *bodyLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(106), Height320(201), Width320(120), [self.testInfo getTypeForTypeName:@"腰围"]?Height320(17):0)];
    
    bodyLabel4.text = [self.testInfo getTypeForTypeName:@"腰围"].value.length?[NSString stringWithFormat:@"腰围  %@cm",[self.testInfo getTypeForTypeName:@"腰围"].value]:@"";
    
    bodyLabel4.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel4.font = AllFont(13);
    
    bodyLabel4.textAlignment = NSTextAlignmentCenter;
    
    [self.mainView addSubview:bodyLabel4];
    
    UILabel *bodyLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(68), Height320(249), Width320(110), [self.testInfo getTypeForTypeName:@"臀围"]?Height320(17):0)];
    
    bodyLabel5.text = [self.testInfo getTypeForTypeName:@"臀围"].value.length?[NSString stringWithFormat:@"臀围  %@cm",[self.testInfo getTypeForTypeName:@"臀围"].value]:@"";
    
    bodyLabel5.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel5.font = AllFont(13);
    
    bodyLabel5.textAlignment = NSTextAlignmentCenter;
    
    [self.mainView addSubview:bodyLabel5];
    
    UILabel *bodyLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), Height320(281), Width320(140), [self.testInfo getTypeForTypeName:@"大腿围（左）"]?Height320(17):0)];
    
    bodyLabel6.text = [self.testInfo getTypeForTypeName:@"大腿围（左）"].value.length?[NSString stringWithFormat:@"大腿围（左）  %@cm",[self.testInfo getTypeForTypeName:@"大腿围（左）"].value]:@"";
    
    bodyLabel6.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel6.font = AllFont(13);
    
    bodyLabel6.textAlignment = NSTextAlignmentRight;
    
    [self.mainView addSubview:bodyLabel6];
    
    UILabel *bodyLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(167), Height320(281), Width320(140), [self.testInfo getTypeForTypeName:@"大腿围（右）"]?Height320(17):0)];
    
    bodyLabel7.text = [self.testInfo getTypeForTypeName:@"大腿围（右）"].value.length?[NSString stringWithFormat:@"大腿围（右）  %@cm",[self.testInfo getTypeForTypeName:@"大腿围（右）"].value]:@"";
    
    bodyLabel7.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel7.font = AllFont(13);
    
    [self.mainView addSubview:bodyLabel7];
    
    UILabel *bodyLabel8 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(15), Height320(386), Width320(140), [self.testInfo getTypeForTypeName:@"小腿围（左）"]?Height320(17):0)];
    
    bodyLabel8.text = [self.testInfo getTypeForTypeName:@"小腿围（左）"].value.length?[NSString stringWithFormat:@"小腿围（左）  %@cm",[self.testInfo getTypeForTypeName:@"小腿围（左）"].value]:@"";
    
    bodyLabel8.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel8.font = AllFont(13);
    
    bodyLabel8.textAlignment = NSTextAlignmentRight;
    
    [self.mainView addSubview:bodyLabel8];
    
    UILabel *bodyLabel9 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(160), Height320(386), Width320(140), [self.testInfo getTypeForTypeName:@"小腿围（右）"]?Height320(17):0)];
    
    bodyLabel9.text = [self.testInfo getTypeForTypeName:@"小腿围（右）"].value.length?[NSString stringWithFormat:@"小腿围（右）  %@cm",[self.testInfo getTypeForTypeName:@"小腿围（右）"].value]:@"";
    
    bodyLabel9.textColor = UIColorFromRGB(0x222222);
    
    bodyLabel9.font = AllFont(13);
    
    [self.mainView addSubview:bodyLabel9];
    
    UILabel *otherLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(238), Height320(36), Width320(90), [self.testInfo getTypeForTypeName:@"身高"]?Height320(18):0)];
    
    otherLabel1.textColor = UIColorFromRGB(0x222222);
    
    otherLabel1.font = AllFont(13);
    
    if ([self.testInfo getTypeForTypeName:@"身高"].value.length) {
        
        NSMutableAttributedString *astr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"身高  %@",[self.testInfo getTypeForTypeName:@"身高"].value]];
        
        [astr1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaaaaa) range:NSMakeRange(0, 2)];
        
        otherLabel1.attributedText = astr1;
        
    }
    
    [self.mainView addSubview:otherLabel1];
    
    UILabel *otherLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(238), otherLabel1.bottom, Width320(90), [self.testInfo getTypeForTypeName:@"体重"]?Height320(18):0)];
    
    otherLabel2.textColor = UIColorFromRGB(0x222222);
    
    otherLabel2.font =AllFont(13);
    
    if ([self.testInfo getTypeForTypeName:@"体重"].value.length) {
        
        NSMutableAttributedString *astr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"体重  %@",[self.testInfo getTypeForTypeName:@"体重"].value]];
        
        [astr2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaaaaa) range:NSMakeRange(0, 2)];
        
        otherLabel2.attributedText = astr2;
        
    }
    
    [self.mainView addSubview:otherLabel2];
    
    UILabel *otherLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(238), otherLabel2.bottom, Width320(90), [self.testInfo getTypeForTypeName:@"BMI"]?Height320(18):0)];
    
    otherLabel3.textColor = UIColorFromRGB(0x222222);
    
    otherLabel3.font = AllFont(13);
    
    if ([self.testInfo getTypeForTypeName:@"BMI"].value.length) {
        
        NSMutableAttributedString *astr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"BMI  %@",[self.testInfo getTypeForTypeName:@"BMI"].value]];
        
        [astr3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaaaaa) range:NSMakeRange(0, 3)];
        
        otherLabel3.attributedText = astr3;
        
    }
    
    [self.mainView addSubview:otherLabel3];
    
    UILabel *otherLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(238), otherLabel3.bottom, Width320(90), [self.testInfo getTypeForTypeName:@"体脂"]?Height320(18):0)];
    
    otherLabel4.textColor = UIColorFromRGB(0x222222);
    
    otherLabel4.font = AllFont(13);
    
    if ([self.testInfo getTypeForTypeName:@"体脂"].value.length) {
        
        NSMutableAttributedString *astr4 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"体脂  %@",[self.testInfo getTypeForTypeName:@"体脂"].value]];
        
        [astr4 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xaaaaaa) range:NSMakeRange(0, 2)];
        
        otherLabel4.attributedText = astr4;
        
    }
    
    [self.mainView addSubview:otherLabel4];
    
    UIView *secView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bodyTestImg.bottom+Height320(22), MSW, Height320(44)*self.testInfo.otherTypes.count)];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secView.layer.borderWidth = 1;
    
    [self.mainView addSubview:secView];
    
    for (BodyTestType *type in self.testInfo.otherTypes) {
        
        QCTextField *textField = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), [self.testInfo.otherTypes indexOfObject:type]*Height320(44), MSW-Width320(32), Height320(44))];
        
        textField.placeholder = type.unit.length?[NSString stringWithFormat:@"%@(%@)",type.typeName,type.unit]:type.typeName;
        
        textField.placeholderColor = UIColorFromRGB(0x999999);
        
        textField.text = type.value;
        
        textField.userInteractionEnabled = NO;
        
        textField.delegate = self;
        
        [secView addSubview:textField];
        
    }
    
    [self.mainView setContentSize:CGSizeMake(0, secView.bottom+Height320(20))];
    
    if (self.testInfo.photos.count) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), secView.bottom+Height320(10), Width320(200), Height320(28))];
        
        label.text = @"体测照片";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font =AllFont(14);
        
        [self.mainView addSubview:label];
        
        float width = (MSW-Width320(20))/3;
        
        for (NSInteger i = 0; i<self.testInfo.photos.count; i++) {
            
            NSURL *url = self.testInfo.photos[i];
            
            NSInteger row = i%3;
            
            NSInteger section = i/3;
            
            UIButton *image = [[UIButton alloc]initWithFrame:CGRectMake(Width320(5)+row*(width+Width320(5)), label.bottom+Height320(6)+section*(width+Height320(5)), width, width)];
            
            [image sd_setImageWithURL:url forState:UIControlStateNormal];
            
            image.tag = i;
            
            [image addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.mainView addSubview:image];
            
        }
        
        NSInteger totalSection = (self.testInfo.photos.count-1)/3+1;
        
        [self.mainView setContentSize:CGSizeMake(0, label.bottom+Height320(26)+totalSection*(width+Height320(5)))];
        
    }
    
}

-(void)naviRightClick
{
    
    EditTestController *svc = [[EditTestController alloc]init];
    
    svc.testInfo = [self.testInfo copy];
    
    svc.stu = self.bodyTest.student;

    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^(BodyTestInfo *testInfo){
        
        if (weakS.editFinish) {
            weakS.editFinish();
        }
        
        weakS.testInfo = testInfo;
       
        [weakS reloadUI];
        
    };
    
    svc.deleteTest = ^{
        
        if (weakS.editFinish) {
            weakS.editFinish();
        }
        
        [weakS.navigationController popViewControllerAnimated:YES];

    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)imageClick:(UIButton*)button
{
    
    NSString *urlStr = self.testInfo.photos[button.tag];
    
    if (urlStr.length) {
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = [NSURL URLWithString:urlStr];
        
        [self presentViewController:svc animated:YES completion:nil];
        
    }
    
}

@end
