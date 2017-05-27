//
//  CoursePlanPayOnlineController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanPayOnlineController.h"

#import "MOSwitchCell.h"

#import "MONumberPickerView.h"

#import "QCKeyboardView.h"

#import "KeyboardManager.h"

@interface CoursePlanWayOrderCell : UIButton

{
    
    UILabel *_textLabel;
    
    UIImageView *_choosedImg;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL choosed;

@end

@implementation CoursePlanWayOrderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(16), 0, Width(200), frame.size.height)];
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(14);
        
        [self addSubview:_textLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width(16), frame.size.height-OnePX, MSW-Width(16), OnePX)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:line];
        
        _choosedImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width(30), Height(13), Width(14), Height(14))];
        
        _choosedImg.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _choosedImg.layer.borderWidth = OnePX;
        
        _choosedImg.layer.cornerRadius = _choosedImg.width/2;
        
        [self addSubview:_choosedImg];
        
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)click
{
    
    self.choosed = !_choosed;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _choosedImg.image = _choosed?[UIImage imageNamed:@"selected"]:nil;
    
    _choosedImg.layer.borderWidth = _choosed?0:OnePX;
    
}

@end

@interface CoursePlanPayOnlineController ()<UITextFieldDelegate,QCKeyboardViewDelegate,MOSwitchCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)CoursePlanWayOrderCell *loginCell;

@property(nonatomic,strong)CoursePlanWayOrderCell *followingCell;

@property(nonatomic,strong)CoursePlanWayOrderCell *normalCell;

@property(nonatomic,strong)UIView *onlinePayView;

@property(nonatomic,strong)MOSwitchCell *onlinPayCell;

@property(nonatomic,strong)QCTextField *onlinePayPriceTF;

@property(nonatomic,strong)MOSwitchCell *astrictCell;

@property(nonatomic,strong)QCTextField *astrictNumberTF;

@property(nonatomic,strong)QCTextField *astrictTypeTF;

@property(nonatomic,strong)MONumberPickerView *astrictPickerView;

@property(nonatomic,strong)NSArray *onlinePays;

@end

@implementation CoursePlanPayOnlineController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)reloadData
{
    
    if (self.onlinePays.count) {
        
        OnlinePay *pay = [self.onlinePays firstObject];
        
        self.onlinPayCell.on = pay.isUsed;
        
        self.onlinPayCell.noLine = !pay.isUsed;
        
        if (pay.isUsed) {
            
            self.onlinePayPriceTF.text = pay.costStr;
            
            self.onlinePayPriceTF.hidden = NO;
            
            self.astrictCell.hidden = NO;
            
            if (pay.astrict) {
                
                [self.onlinePayView changeHeight:Height(40)*5];
                
                self.astrictCell.on = YES;
                
                self.astrictNumberTF.hidden = NO;
                
                self.astrictTypeTF.hidden = NO;
                
                if (pay.astrictNumber) {
                    
                    self.astrictNumberTF.text = [NSString stringWithFormat:@"%ld",(long)pay.astrictNumber];
                    
                }else{
                    
                    self.astrictNumberTF.text = @"";
                    
                }
                
                self.loginCell.choosed = pay.astrictNewLogin;
                
                self.followingCell.choosed = pay.astrictFollowing;
                
                self.normalCell.choosed = pay.astrictNormal;
                
                NSMutableArray *astrictArray = [NSMutableArray array];
                
                if (pay.astrictNewLogin) {
                    
                    [astrictArray addObject:@"新注册"];
                    
                }
                
                if (pay.astrictFollowing) {
                    
                    [astrictArray addObject:@"已接洽"];
                    
                }
                
                if (pay.astrictNormal) {
                    
                    [astrictArray addObject:@"会员"];
                    
                }
                
                if (astrictArray.count) {
                    
                    self.astrictTypeTF.text = [astrictArray componentsJoinedByString:@"、"];
                    
                }else{
                    
                    self.astrictTypeTF.text = @"";
                    
                }
                
            }else{
                
                self.astrictCell.on = NO;
                
                [self.onlinePayView changeHeight:Height(40)*3];
                
                self.astrictNumberTF.hidden = YES;
                
                self.astrictTypeTF.hidden = YES;
                
                self.astrictNumberTF.text = @"";
                
            }
            
        }else{
            
            [self.onlinePayView changeHeight:Height(40)*1];
            
            self.onlinePayPriceTF.hidden = YES;
            
            self.astrictCell.hidden = YES;
            
            self.astrictNumberTF.hidden = YES;
            
            self.astrictTypeTF.hidden = YES;
            
            self.astrictNumberTF.text = @"";
            
        }
        
    }
    
}

-(void)createData
{
    
    self.onlinePays = self.plan?self.plan.onlinePays:self.batch.onlinePays;
    
    if (!self.onlinePays.count) {
        
        OnlinePay *wechatPay = [[OnlinePay alloc]init];
        
        wechatPay.name = @"在线支付";
        
        self.onlinePays = @[wechatPay];
        
    }
    
    [self reloadData];
    
}

-(void)createUI
{
    
    self.title = @"设置在线支付结算";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightTitle = @"保存";
    
    NSString *fstStr = @"在线支付平台：";
    
    CGSize fstSize = [fstStr boundingRectWithSize:CGSizeMake(MAXFLOAT, Height(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    UILabel *fstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(16),64+Height(12), fstSize.width, Height(14))];
    
    fstLabel.text = fstStr;
    
    fstLabel.textColor = UIColorFromRGB(0x666666);
    
    fstLabel.font = AllFont(12);
    
    [self.view addSubview:fstLabel];
    
    UIImageView *wechatImg = [[UIImageView alloc]initWithFrame:CGRectMake(fstLabel.right, fstLabel.top-Height(1), Width(16), Height(16))];
    
    wechatImg.image = [UIImage imageNamed:@"pay_way_wechat"];
    
    [self.view addSubview:wechatImg];
    
    NSString *secStr = @"微信支付";
    
    CGSize secSize = [secStr boundingRectWithSize:CGSizeMake(MAXFLOAT, Height(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(wechatImg.right+Width(4), fstLabel.top, secSize.width, Height(14))];
    
    secLabel.text = secStr;
    
    secLabel.textColor = UIColorFromRGB(0x666666);
    
    secLabel.font = AllFont(12);
    
    [self.view addSubview:secLabel];
    
    UIImageView *aliImg = [[UIImageView alloc]initWithFrame:CGRectMake(secLabel.right+Width(12), wechatImg.top, Width(16), Height(16))];
    
    aliImg.image = [UIImage imageNamed:@"pay_way_ali"];
    
    aliImg.alpha = 0.3;
    
    [self.view addSubview:aliImg];
    
    UILabel *trdLabel = [[UILabel alloc]initWithFrame:CGRectMake(aliImg.right+Width(4), fstLabel.top, MSW-aliImg.right-Width(4), Height(14))];
    
    trdLabel.text = @"支付宝 (暂不支持)";
    
    trdLabel.textColor = UIColorFromRGB(0xBBBBBB);
    
    trdLabel.font = AllFont(12);
    
    [self.view addSubview:trdLabel];
    
    self.onlinePayView = [[UIView alloc]initWithFrame:CGRectMake(0, Height(40)+64, MSW, Height(40))];
    
    self.onlinePayView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.onlinePayView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.onlinePayView.layer.borderWidth = OnePX;
    
    [self.view addSubview:self.onlinePayView];
    
    self.onlinPayCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width(16), 0, MSW-Width(32), Height(40))];
    
    self.onlinPayCell.titleLabel.textColor = UIColorFromRGB(0x666666);
    
    self.onlinPayCell.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.onlinPayCell.tag = 1;
    
    self.onlinPayCell.delegate = self;
    
    self.onlinPayCell.titleLabel.text = @"在线支付结算";
    
    [self.onlinePayView addSubview:self.onlinPayCell];
    
    self.onlinePayPriceTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.onlinPayCell.left, self.onlinPayCell.bottom, self.onlinPayCell.width, self.onlinPayCell.height)];
    
    self.onlinePayPriceTF.placeholder = @"单价（元/人）";
    
    self.onlinePayPriceTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.onlinePayPriceTF.delegate = self;
    
    self.onlinePayPriceTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.onlinePayView addSubview:self.onlinePayPriceTF];
    
    [self.onlinePayPriceTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.astrictCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(self.onlinePayPriceTF.left, self.onlinePayPriceTF.bottom, self.onlinePayPriceTF.width, self.onlinePayPriceTF.height)];
    
    self.astrictCell.titleLabel.text = @"预约限制";
    
    self.astrictCell.delegate = self;
    
    self.astrictCell.tag = 2;
    
    [self.onlinePayView addSubview:self.astrictCell];
    
    self.astrictNumberTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.astrictCell.left, self.astrictCell.bottom, self.astrictCell.width, self.astrictCell.height)];
    
    self.astrictNumberTF.placeholder = @"每位会员每节课可预约人数";
    
    self.astrictNumberTF.delegate = self;
    
    self.astrictNumberTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.astrictNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.onlinePayView addSubview:self.astrictNumberTF];
    
    [self.astrictNumberTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    QCKeyboardView *keyboardView = [QCKeyboardView defaultKeboardView];
    
    keyboardView.tag = 1;
    
    keyboardView.delegate = self;
    
    self.astrictNumberTF.inputView = keyboardView;
    
    self.astrictPickerView = [[MONumberPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    keyboardView.keyboard = self.astrictPickerView;
    
    self.astrictPickerView.minNumber = 1;
    
    self.astrictPickerView.maxNumber = self.plan?self.plan.course.capacity:self.batch.course.capacity;
    
    self.astrictTypeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.astrictNumberTF.left, self.astrictNumberTF.bottom, self.astrictNumberTF.width, self.astrictNumberTF.height)];
    
    self.astrictTypeTF.type = QCTextFieldTypeCell;
    
    self.astrictTypeTF.placeholder = @"可预约对象";
    
    self.astrictTypeTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.astrictTypeTF.delegate = self;
    
    self.astrictTypeTF.noLine = YES;
    
    [self.onlinePayView addSubview:self.astrictTypeTF];
    
    QCKeyboardView *typeKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, 39+Height(40)*3)];
    
    typeKV.tag = 2;
    
    typeKV.delegate = self;
    
    self.astrictTypeTF.inputView = typeKV;
    
    UIView *typeView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, MSW, Height(40)*3)];
    
    typeView.backgroundColor = UIColorFromRGB(0xffffff);
    
    typeKV.keyboard = typeView;
    
    self.loginCell = [[CoursePlanWayOrderCell alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(40))];
    
    self.loginCell.title = @"新注册";
    
    [typeView addSubview:self.loginCell];
    
    self.followingCell = [[CoursePlanWayOrderCell alloc]initWithFrame:CGRectMake(0, self.loginCell.bottom, MSW, Height(40))];
    
    self.followingCell.title = @"已接洽";
    
    [typeView addSubview:self.followingCell];
    
    self.normalCell = [[CoursePlanWayOrderCell alloc]initWithFrame:CGRectMake(0, self.followingCell.bottom, MSW, Height(40))];
    
    self.normalCell.title = @"会员";
    
    [typeView addSubview:self.normalCell];
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if (cell.tag ==1) {
        
        OnlinePay *pay = [self.onlinePays firstObject];
        
        pay.isUsed = cell.on;
        
        if (!cell.on) {
            
            OnlinePay *pay = [self.onlinePays firstObject];
            
            pay.cost = 0;
            
            pay.costStr = @"";
            
        }
        
        [self reloadData];
        
        if (cell.on) {
            
            [self.onlinePayPriceTF becomeFirstResponder];
            
        }
        
    }else if (cell.tag == 2){
        
        OnlinePay *pay = [self.onlinePays firstObject];
        
        pay.astrict = cell.on;
        
        if (cell.on) {
            
            pay.astrictNewLogin = YES;
            
            pay.astrictFollowing = YES;
            
            pay.astrictNormal = YES;
            
            if (!self.astrictNumberTF.text.length) {
                
                pay.astrictNumber = self.plan?self.plan.course.capacity:self.batch.course.capacity;
                
                self.astrictPickerView.currentNumber = pay.astrictNumber;
                
            }
            
        }else{
            
            pay.astrictNewLogin = NO;
            
            pay.astrictFollowing = NO;
            
            pay.astrictNormal = NO;
            
            pay.astrictNumber = 0;
            
        }
        
        [self reloadData];
        
    }
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.view endEditing:YES];
    
    if (keyboardView.tag == 1){
        
        OnlinePay *pay = [self.onlinePays firstObject];
        
        pay.astrictNumber = self.astrictPickerView.currentNumber;
        
        [self reloadData];
        
    }else if (keyboardView.tag == 2){
        
        if (self.loginCell.choosed || self.followingCell.choosed || self.normalCell.choosed) {
            
            OnlinePay *pay = [self.onlinePays firstObject];
            
            pay.astrictNewLogin = self.loginCell.choosed;
            
            pay.astrictFollowing = self.followingCell.choosed;
            
            pay.astrictNormal = self.normalCell.choosed;
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"请至少选择一种预约对象" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
        [self reloadData];
        
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.astrictTypeTF) {
        
        OnlinePay *pay = [self.onlinePays firstObject];
        
        self.loginCell.choosed = pay.astrictNewLogin;
        
        self.followingCell.choosed = pay.astrictFollowing;
        
        self.normalCell.choosed = pay.astrictNormal;
        
    }
    
    if (textField == self.astrictNumberTF) {
        
        self.astrictPickerView.minNumber = 1;
        
        self.astrictPickerView.maxNumber = self.plan?self.plan.course.capacity:self.batch.course.capacity;
        
    }
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    OnlinePay *pay = [self.onlinePays firstObject];
    
    if (textField == self.onlinePayPriceTF) {
        
        pay.cost = [textField.text floatValue];
        
        if (textField.text.length) {
            
            pay.costStr = textField.text;
            
        }else{
            
            pay.costStr = @"";
            
        }
        
    }else{
        
        pay.astrictNumber = [textField.text integerValue];
        
    }
    
}

-(void)naviLeftClick
{
    
    [[[UIAlertView alloc]initWithTitle:@"是否保存结算方式" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self naviRightClick];
        
    }
    
}

-(void)naviRightClick
{
    
    OnlinePay *pay = [self.onlinePays firstObject];
    
    if (pay.isUsed && !self.onlinePayPriceTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写单价" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (pay.astrict && !self.astrictNumberTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写每位会员每节课可预约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!pay.isUsed) {
        
        self.onlinePays = [NSArray array];
        
    }else{
        
        if (self.plan) {
            
            self.plan.onlinePays = self.onlinePays;
            
        }else{
            
            self.batch.onlinePays = self.onlinePays;
            
        }
        
    }
    
    if (self.plan) {
        
        if (self.setPlanFinish) {
            
            self.setPlanFinish(self.plan);
            
        }
        
    }else{
        
        if (self.setFinish) {
            
            self.setFinish(self.batch);
            
        }
        
    }
    
    [self popViewControllerAndReloadData];
    
}

@end
