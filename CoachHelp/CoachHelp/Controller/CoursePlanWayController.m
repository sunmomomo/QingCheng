//
//  CoursePlanWayController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanWayController.h"

#import "MOSwitchCell.h"

#import "Card.h"

#import "QCKeyboardView.h"

#import "QCTextField.h"

#import "QCTextFieldCell.h"

#import "MONumberPickerView.h"

#import "CardKindListInfo.h"

#import "OnlinePay.h"

#define GroupMaxCapacity 300

#define PrivateMaxCapacity 10

static NSString *identifier = @"Cell";

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
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), frame.size.height)];
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(14);
        
        [self addSubview:_textLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), frame.size.height-OnePX, MSW-Width320(16), OnePX)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:line];
        
        _choosedImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(30), Height320(13), Width320(14), Height320(14))];
        
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

@interface CoursePlanWayController ()<UITableViewDataSource,UITableViewDelegate,QCKeyboardViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *tableHeader;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)MOSwitchCell *needPayCell;

@property(nonatomic,strong)UILabel *freeHintLabel;

@property(nonatomic,strong)UIView *onlinePayView;

@property(nonatomic,strong)MOSwitchCell *onlinPayCell;

@property(nonatomic,strong)UIView *onlinePayHeaderView;

@property(nonatomic,strong)UILabel *headerLabel;

@property(nonatomic,strong)QCTextField *onlinePayPriceTF;

@property(nonatomic,strong)MOSwitchCell *astrictCell;

@property(nonatomic,strong)QCTextField *astrictNumberTF;

@property(nonatomic,strong)QCTextField *astrictTypeTF;

@property(nonatomic,strong)CoursePlanWayOrderCell *loginCell;

@property(nonatomic,strong)CoursePlanWayOrderCell *followingCell;

@property(nonatomic,strong)CoursePlanWayOrderCell *normalCell;

@property(nonatomic,strong)MONumberPickerView *astrictPickerView;

@property(nonatomic,strong)MONumberPickerView *capacityPickerView;

@property(nonatomic,strong)NSIndexPath *currentIndexPath;

@property(nonatomic,strong)CardKindListInfo *info;

@property(nonatomic,strong)NSArray *cardKinds;

@property(nonatomic,assign)BOOL canClick;

@property(nonatomic,strong)NSArray *onlinePays;

@end

@implementation CoursePlanWayController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    [self reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    
    BOOL isFree = self.plan?self.plan.isFree:self.batch.isFree;
    
    CourseType courseType = self.plan?self.plan.course.type:self.batch.course.type;
    
    if (!isFree) {
        
        self.freeHintLabel.hidden = YES;
        
        for (CardKind *cardKind in self.cardKinds) {
            
            if (!cardKind.isUsed) {
                
                [cardKind.costs removeAllObjects];
                
            }else
            {
                
                if (cardKind.type != CardKindTypeTime) {
                    
                    if (cardKind.costs.count<[self.capacityTF.text integerValue]) {
                        
                        for (NSInteger i = cardKind.costs.count ; i<[self.capacityTF.text integerValue]; i++) {
                            
                            CardCost *cost = [[CardCost alloc]init];
                            
                            cost.fromNumber = i+1;
                            
                            cost.toNumber = i+2;
                            
                            if (courseType == CourseTypeGroup) {
                                
                                CardCost *tempCost = [cardKind.costs firstObject];
                                
                                cost.perCost = tempCost.perCost;
                                
                                cost.costString = tempCost.costString;
                                
                            }
                            
                            [cardKind.costs addObject:cost];
                            
                        }
                        
                    }else if (cardKind.costs.count > [self.capacityTF.text integerValue]){
                        
                        cardKind.costs = [[cardKind.costs subarrayWithRange:NSMakeRange(0, [self.capacityTF.text integerValue])] mutableCopy];
                        
                    }
                    
                }
                
            }
            
        }
        
        if (self.onlinePays.count) {
            
            OnlinePay *pay = [self.onlinePays firstObject];
            
            self.onlinPayCell.on = pay.isUsed;
            
            self.onlinPayCell.noLine = !pay.isUsed;
            
            if (pay.isUsed) {
                
                self.onlinePayPriceTF.text = pay.costStr;
                
                self.onlinePayPriceTF.hidden = NO;
                
                self.astrictCell.hidden = NO;
                
                if (pay.astrict) {
                    
                    [self.tableHeader changeHeight:Height320(60)+Height320(40)*8+Height320(12)];
                    
                    [self.onlinePayView changeHeight:Height320(40)*5];
                    
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
                        
                        [astrictArray addObject:@"跟进中"];
                        
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
                    
                    [self.tableHeader changeHeight:Height320(60)+Height320(40)*6+Height320(12)];
                    
                    [self.onlinePayView changeHeight:Height320(40)*3];
                    
                    self.astrictNumberTF.hidden = YES;
                    
                    self.astrictTypeTF.hidden = YES;
                    
                    self.astrictNumberTF.text = @"";
                    
                }
                
                [self.headerLabel changeTop:self.onlinePayView.bottom];
                
            }else{
                
                [self.tableHeader changeHeight:Height320(60)+Height320(40)*4+Height320(12)];
                
                [self.onlinePayView changeHeight:Height320(40)*1];
                
                self.onlinePayPriceTF.hidden = YES;
                
                self.astrictCell.hidden = YES;
                
                self.astrictNumberTF.hidden = YES;
                
                self.astrictTypeTF.hidden = YES;
                
                self.astrictNumberTF.text = @"";
                
                [self.headerLabel changeTop:self.onlinePayView.bottom];
                
            }
            
        }
        
    }else{
        
        self.freeHintLabel.hidden = NO;
        
        self.onlinePayHeaderView.hidden = YES;
        
    }
    
    self.tableView.tableHeaderView = self.tableHeader;
    
    [self.tableView reloadData];
    
    [self check];
    
}

-(void)createData
{
    
    BOOL isFree = self.plan?self.plan.isFree:self.batch.isFree;
    
    NSArray *cardKinds = self.plan?self.plan.cardKinds:self.batch.cardKinds;
    
    self.needPayCell.on = !isFree;
    
    NSArray *onlinePays = self.plan?self.plan.onlinePays:self.batch.onlinePays;
    
    if (!isFree) {
        
        self.freeHintLabel.hidden = YES;
        
        self.info = [[CardKindListInfo alloc]init];
        
        [self.info requestResult:^(BOOL success, NSString *error) {
            
            self.cardKinds = self.info.cardKinds;
            
            [self.cardKinds enumerateObjectsUsingBlock:^(CardKind *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                for (CardKind *cardKind in cardKinds) {
                    
                    if (cardKind.cardKindId == obj.cardKindId) {
                        
                        obj.costs = [cardKind.costs mutableCopy];
                        
                        obj.isUsed = YES;
                        
                        break;
                        
                    }
                    
                }
                
            }];
            
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"isUsed" ascending:NO];
            
            NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
            
            self.cardKinds = [[self.cardKinds sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
            
            [self.tableView reloadData];
            
            [self check];
            
        }];
        
        if (onlinePays.count) {
            
            self.onlinePays = [onlinePays copy];
            
            [self.tableView reloadData];
            
        }else{
            
            OnlinePay *wechatPay = [[OnlinePay alloc]init];
            
            wechatPay.name = @"在线支付";
            
            self.onlinePays = @[wechatPay];
            
            [self.tableView reloadData];
            
        }
        
        NSInteger capacity = self.plan?self.plan.course.capacity:self.batch.course.capacity;
        
        if (!capacity) {
            
            if (self.plan) {
                
                self.plan.course.capacity = 1;
                
            }else{
                
                self.batch.course.capacity = 1;
                
            }
            
            self.capacityTF.text = @"1";
            
        }
        
    }else{
        
        self.freeHintLabel.hidden = NO;
        
        self.onlinePayHeaderView.hidden = YES;
        
        [self check];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"设置结算方式";
    
    self.rightTitle = @"确定";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[QCTextFieldCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(500))];
    
    self.tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = self.tableHeader;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.tableHeader addSubview:topView];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.capacityTF.placeholder = @"单节课可约人数";
    
    self.capacityTF.delegate = self;
    
    self.capacityTF.noLine = YES;
    
    [topView addSubview:self.capacityTF];
    
    NSInteger capacity = self.plan?self.plan.course.capacity:self.batch.course.capacity;
    
    if (capacity) {
        
        self.capacityTF.text = [NSString stringWithFormat:@"%ld",(long)capacity];
        
        self.capacityTF.rightViewMode = UITextFieldViewModeNever;
        
    }
    
    QCKeyboardView *keyboardView = [QCKeyboardView defaultKeboardView];
    
    keyboardView.tag = 0;
    
    keyboardView.delegate = self;
    
    self.capacityTF.inputView = keyboardView;
    
    self.capacityPickerView = [[MONumberPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.capacityPickerView.minNumber = 1;
    
    CourseType courseType = self.plan?self.plan.course.type:self.batch.course.type;
    
    self.capacityPickerView.maxNumber = courseType == CourseTypeGroup?GroupMaxCapacity:PrivateMaxCapacity;
    
    keyboardView.keyboard = self.capacityPickerView;
    
    UIView *needView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(40))];
    
    needView.backgroundColor = UIColorFromRGB(0xffffff);
    
    needView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    needView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.tableHeader addSubview:needView];
    
    self.needPayCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.needPayCell.titleLabel.text = @"需要结算";
    
    self.needPayCell.userInteractionEnabled = NO;
    
    [needView addSubview:self.needPayCell];
    
    UIButton *button = [[UIButton alloc]initWithFrame:self.needPayCell.frame];
    
    [button addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    
    [needView addSubview:button];
    
    self.freeHintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), needView.bottom+Height320(4), MSW-Width320(32), Height320(14))];
    
    self.freeHintLabel.text = @"设置需要结算后，会员需使用会员卡、在线支付才可约课";
    
    self.freeHintLabel.textColor = UIColorFromRGB(0x999999);
    
    self.freeHintLabel.font = AllFont(11);
    
    [self.tableHeader addSubview:self.freeHintLabel];
    
    self.onlinePayHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, needView.bottom, MSW, Height320(60))];
    
    [self.tableHeader addSubview:self.onlinePayHeaderView];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    topLabel.text = @"在线支付";
    
    topLabel.textColor = UIColorFromRGB(0xcccccc);
    
    topLabel.font = AllFont(14);
    
    [self.onlinePayHeaderView addSubview:topLabel];
    
    NSString *fstStr = @"在线支付平台：";
    
    CGSize fstSize = [fstStr boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    UILabel *fstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16),topLabel.bottom, fstSize.width, Height320(14))];
    
    fstLabel.text = fstStr;
    
    fstLabel.textColor = UIColorFromRGB(0xcccccc);
    
    fstLabel.font = AllFont(12);
    
    [self.onlinePayHeaderView addSubview:fstLabel];
    
    UIImageView *wechatImg = [[UIImageView alloc]initWithFrame:CGRectMake(fstLabel.right, fstLabel.top-Height320(1), Width320(16), Height320(16))];
    
    wechatImg.image = [UIImage imageNamed:@"pay_way_wechat"];
    
    [self.onlinePayHeaderView addSubview:wechatImg];
    
    NSString *secStr = @"微信支付";
    
    CGSize secSize = [secStr boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(wechatImg.right+Width320(4), fstLabel.top, secSize.width, Height320(14))];
    
    secLabel.text = secStr;
    
    secLabel.textColor = UIColorFromRGB(0xcccccc);
    
    secLabel.font = AllFont(12);
    
    [self.onlinePayHeaderView addSubview:secLabel];
    
    UIImageView *aliImg = [[UIImageView alloc]initWithFrame:CGRectMake(secLabel.right+Width320(12), wechatImg.top, Width320(16), Height320(16))];
    
    aliImg.image = [UIImage imageNamed:@"pay_way_ali"];
    
    aliImg.alpha = 0.3;
    
    [self.onlinePayHeaderView addSubview:aliImg];
    
    UILabel *trdLabel = [[UILabel alloc]initWithFrame:CGRectMake(aliImg.right+Width320(4), fstLabel.top, MSW-aliImg.right-Width320(4), Height320(14))];
    
    trdLabel.text = @"支付宝 (暂不支持)";
    
    trdLabel.textColor = UIColorFromRGB(0xcccccc);
    
    trdLabel.font = AllFont(12);
    
    [self.onlinePayHeaderView addSubview:trdLabel];
    
    self.onlinePayView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(60)+Height320(12), MSW, Height320(40))];
    
    self.onlinePayView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.onlinePayView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.onlinePayView.layer.borderWidth = OnePX;
    
    [self.onlinePayHeaderView addSubview:self.onlinePayView];
    
    self.onlinPayCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.onlinPayCell.userInteractionEnabled = NO;
    
    self.onlinPayCell.titleLabel.textColor = UIColorFromRGB(0xcccccc);
    
    self.onlinPayCell.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.onlinePayView addSubview:self.onlinPayCell];
    
    self.onlinPayCell.titleLabel.text = @"在线支付";
    
    self.onlinPayCell.image = [UIImage imageNamed:@"ic_pay_online"];
    
    self.onlinePayPriceTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.onlinPayCell.left, self.onlinPayCell.bottom, self.onlinPayCell.width, self.onlinPayCell.height)];
    
    self.onlinePayPriceTF.placeholder = @"单价（元/人）";
    
    self.onlinePayPriceTF.delegate = self;
    
    self.onlinePayPriceTF.textColor = UIColorFromRGB(0xcccccc);
    
    self.onlinePayPriceTF.placeholderColor = UIColorFromRGB(0xcccccc);
    
    self.onlinePayPriceTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.onlinePayView addSubview:self.onlinePayPriceTF];
    
    self.astrictCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(self.onlinePayPriceTF.left, self.onlinePayPriceTF.bottom, self.onlinePayPriceTF.width, self.onlinePayPriceTF.height)];
    
    self.astrictCell.titleLabel.text = @"预约限制";
    
    self.astrictCell.userInteractionEnabled = NO;
    
    self.astrictCell.titleLabel.textColor = UIColorFromRGB(0xcccccc);
    
    [self.onlinePayView addSubview:self.astrictCell];
    
    self.astrictNumberTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.astrictCell.left, self.astrictCell.bottom, self.astrictCell.width, self.astrictCell.height)];
    
    self.astrictNumberTF.placeholder = @"每位会员每节课可预约人数";
    
    self.astrictNumberTF.userInteractionEnabled = NO;
    
    self.astrictNumberTF.textColor = UIColorFromRGB(0xcccccc);
    
    self.astrictNumberTF.placeholderColor = UIColorFromRGB(0xcccccc);
    
    [self.onlinePayView addSubview:self.astrictNumberTF];
    
    self.astrictTypeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.astrictNumberTF.left, self.astrictNumberTF.bottom, self.astrictNumberTF.width, self.astrictNumberTF.height)];
    
    self.astrictTypeTF.type = QCTextFieldTypeCell;
    
    self.astrictTypeTF.placeholder = @"可预约对象";
    
    self.astrictTypeTF.userInteractionEnabled = NO;
    
    self.astrictTypeTF.textColor = UIColorFromRGB(0xcccccc);
    
    self.astrictTypeTF.placeholderColor = UIColorFromRGB(0xcccccc);
    
    self.astrictTypeTF.noLine = YES;
    
    [self.onlinePayView addSubview:self.astrictTypeTF];
    
    self.headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.onlinePayView.bottom, Width320(200), Height320(40))];
    
    self.headerLabel.text = @"会员卡支付";
    
    self.headerLabel.textColor = UIColorFromRGB(0xcccccc);
    
    self.headerLabel.font = AllFont(14);
    
    [self.onlinePayHeaderView addSubview:self.headerLabel];
    
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(56))];
    
    tableFooterView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = tableFooterView;
    
    [self check];
    
}


-(void)naviRightClick
{
    
    if (!self.capacityTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请设置课程可约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.plan) {
        
        self.plan.course.capacity = [self.capacityTF.text integerValue];
        
    }else{
        
        self.batch.course.capacity = [self.capacityTF.text integerValue];
        
    }
    
    if (self.setFinish) {
        
        self.setFinish(self.batch);
        
    }
    
    if (self.setPlanFinish) {
        
        self.setPlanFinish(self.plan);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(void)payClick
{
    
    [self showAppAlertWithTitle:@"支付方式" andSubtitle:nil];
    
}

-(void)check
{
    
    if (self.plan) {
        
        if (self.plan.isFree) {
            
            if (![self.capacityTF.text integerValue]) {
                
                self.canClick = NO;
                
                return;
                
            }
            
            self.canClick = YES;
            
            return;
            
        }
        
    }else{
        
        if (self.batch.isFree) {
            
            if (![self.capacityTF.text integerValue]) {
                
                self.canClick = NO;
                
                return;
                
            }
            
            self.canClick = YES;
            
            return;
            
        }
        
    }
    
    OnlinePay *pay = [self.onlinePays firstObject];
    
    if (pay.isUsed && !pay.costStr.length) {
        
        self.canClick = NO;
        
        return;
        
    }
    
    if (![self.capacityTF.text integerValue]) {
        
        self.canClick = NO;
        
        return;
        
    }
    
    NSInteger cardUsedCount = 0;
    
    for (CardKind *cardKind in self.cardKinds) {
        
        if (cardKind.isUsed) {
            cardUsedCount ++;
        }
        
    }
    
    if (!cardUsedCount &&!pay.isUsed) {
        
        self.canClick = NO;
        
        return;
        
    }
    
    __block BOOL empty = NO;
    
    [self.cardKinds enumerateObjectsUsingBlock:^(CardKind *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        for (CardCost *cost in obj.costs) {
            
            if (!cost.costString.length) {
                
                empty = YES;
                
                *stop = YES;
                
                break;
                
            }
            
        }
        
    }];
    
    if (empty) {
        
        self.canClick = NO;
        
        return;
        
    }
    
    self.canClick = YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.view endEditing:YES];
    
    if (keyboardView.tag == 0) {
        
        self.capacityTF.text = [NSString stringWithFormat:@"%ld",(long)self.capacityPickerView.currentNumber];
        
        [self reloadData];
        
    }else if (keyboardView.tag == 1){
        
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
    
    [self check];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.plan) {
        
        if (!self.plan.isFree) {
            
            return self.cardKinds.count;
            
        }else{
            
            return 0;
            
        }
        
    }else{
        
        if (!self.batch.isFree) {
            
            return self.cardKinds.count;
            
        }else{
            
            return 0;
            
        }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    CardKind *cardKind = self.cardKinds[section];
    
    if (cardKind.isUsed) {
        
        if (self.plan) {
            
            return cardKind.type == CardKindTypeTime?0:self.plan.course.type == CourseTypePrivate?[self.capacityTF.text integerValue]:1;
            
        }else{
            
            return cardKind.type == CardKindTypeTime?0:self.batch.course.type == CourseTypePrivate?[self.capacityTF.text integerValue]:1;
            
        }
        
    }else
    {
        
        return 0;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(40);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    MOSwitchCell *cell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    cell.titleLabel.textColor = UIColorFromRGB(0xcccccc);
    
    cell.backgroundColor = UIColorFromRGB(0xffffff);
    
    CardKind *cardKind = self.cardKinds[section];
    
    cell.titleLabel.text = cardKind.cardKindName;
    
    cell.on = cardKind.isUsed;
    
    cell.userInteractionEnabled = NO;
    
    [header addSubview:cell];
    
    UIView *topSep = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1/[UIScreen mainScreen].scale)];
    
    topSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:topSep];
    
    UIView *bottomSep = [[UIView alloc]initWithFrame:CGRectMake(cardKind.isUsed&&cardKind.type!=CardKindTypeTime?Width320(16):0, cell.height-OnePX, cardKind.isUsed?cell.width-Width320(32):MSW, OnePX)];
    
    bottomSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:bottomSep];
    
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return Height320(12);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, -1/[UIScreen mainScreen].scale, MSW, 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [footer addSubview:sep];
    
    return footer;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QCTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardKind *cardKind = self.cardKinds[indexPath.section];
    
    CourseType courseType = self.plan?self.plan.course.type:self.batch.course.type;
    
    if (courseType == CourseTypeGroup) {
        
        if (cardKind.type == CardKindTypePrepaid) {
            
            cell.textField.placeholder = @"单价（元/人）";
            
        }else if (cardKind.type == CardKindTypeCount){
            
            cell.textField.placeholder = @"单价（次/人）";
            
        }
        
    }else
    {
        
        if (cardKind.type == CardKindTypePrepaid) {
            
            cell.textField.placeholder = [NSString stringWithFormat:@"1对%ld单价（元/人）",(long)indexPath.row+1];
            
        }else if (cardKind.type == CardKindTypeCount){
            
            cell.textField.placeholder = [NSString stringWithFormat:@"1对%ld单价（次/人）",(long)indexPath.row+1];
            
        }
        
    }
    
    cell.textField.placeholderColor = UIColorFromRGB(0xcccccc);
    
    cell.textField.textColor = UIColorFromRGB(0xcccccc);
    
    cell.textField.userInteractionEnabled = NO;
    
    cell.textField.mustInput = YES;
    
    CardCost *cost = cardKind.costs[indexPath.row];
    
    cell.textField.text  = cost.costString.length?[NSString stringWithFormat:@"%ld",(long)cost.perCost]:@"";
    
    cell.keyboardType = UIKeyboardTypeNumberPad;
    
    if (courseType == CourseTypeGroup) {
        
        cell.textField.noLine = YES;
        
    }else{
        
        cell.textField.noLine = indexPath.row == [self.capacityTF.text integerValue]-1;
        
    }
    
    cell.indexPath = indexPath;
    
    return cell;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.astrictNumberTF) {
        
        self.astrictPickerView.minNumber = 1;
        
        self.astrictPickerView.maxNumber = [self.capacityTF.text integerValue];
        
    }
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [self check];
    
    return YES;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}

@end
