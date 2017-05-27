//
//  CardRechargeChooseSpecController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRechargeChooseSpecController.h"

#import "CardBackView.h"

#import "QCTextField.h"

#import "SpecCell.h"

#import "SpecListInfo.h"

#import "MOSwitchCell.h"

#import "QCKeyboardView.h"

#import "CardImproveController.h"

static NSString *identifier = @"Cell";

@interface CardRechargeChooseSpecController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,QCKeyboardViewDelegate,MOSwitchCellDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *rechargeTF;

@property(nonatomic,strong)QCTextField *receiveTF;

@property(nonatomic,strong)MOSwitchCell *validCell;

@property(nonatomic,strong)QCTextField *validStartTF;

@property(nonatomic,strong)QCTextField *validEndTF;

@property(nonatomic,strong)UIView *thirdView;

@property(nonatomic,strong)SpecListInfo *info;

@property(nonatomic,strong)Spec *selectedSpec;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *validStartDP;

@property(nonatomic,strong)UIDatePicker *validEndDP;

@property(nonatomic,strong)NSMutableArray *specs;

@property(nonatomic,strong)NSDateFormatter *dateFormatter;

@end

@implementation CardRechargeChooseSpecController

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
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    
    self.dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.info = [[SpecListInfo alloc]init];
    
    [self.info requestWithCardKind:self.card.cardKind result:^(BOOL success, NSString *error) {
        
        self.specs = [NSMutableArray array];
        
        for (Spec *spec in self.info.specs) {
            
            if (spec.canRecharge) {
                
                [self.specs addObject:spec];
                
            }
            
        }
        
        Spec *spec = [[Spec alloc]init];
        
        spec.type = SpecTypeOther;
        
        [self.specs addObject:spec];
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"会员卡规格";
    
    self.rightTitle = @"下一步";
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.card.cardKind.type == CardKindTypeTime?Height320(272):Height320(304))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:topView];
    
    CardBackView *cardBackView = [[CardBackView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), MSW-Width320(20),Height320(86))];
    
    cardBackView.image = [UIImage imageNamed:@"card_recharge_back"];
    
    cardBackView.backColor = self.card.color;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cardBackView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = cardBackView.bounds;
    maskLayer.path = maskPath.CGPath;
    cardBackView.layer.mask = maskLayer;
    
    [topView addSubview:cardBackView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18)                                                                                                                                                                , Height320(24), MSW-Width320(36), Height320(18))];
    
    titleLabel.text = [NSString stringWithFormat:@"%@（%ld）",self.card.cardName,(long)self.card.cardId];
    
    titleLabel.textColor = UIColorFromRGB(0xffffff);
    
    titleLabel.font = AllFont(14);
    
    [topView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom+Height320(4), titleLabel.width, Height320(16))];
    
    timeLabel.text = self.card.cardKind.type == CardKindTypeTime?[NSString stringWithFormat:@"有效期：%@ 至 %@",self.card.start,self.card.end]:self.card.checkValid?[NSString stringWithFormat:@"有效期：%@ 至 %@",self.card.validFrom,self.card.validTo]:@"有效期：不限";
    
    timeLabel.textColor = UIColorFromRGB(0xffffff);
    
    timeLabel.font = AllFont(12);
    
    [self.mainView addSubview:timeLabel];
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeLabel.left, timeLabel.bottom+Height320(4), Width320(190), Height320(16))];
    
    NSString *str = @"";
    
    for (NSInteger i = 0; i<self.card.users.count; i++) {
        
        Student *stu = self.card.users[i];
        
        str = [str stringByAppendingString:stu.name];
        
        if (i<self.card.users.count-1) {
            
            str = [str stringByAppendingString:@"、"];
            
        }
        
    }
    
    userLabel.text = str;
    
    userLabel.textColor = UIColorFromRGB(0xffffff);
    
    userLabel.font = AllFont(12);
    
    [topView addSubview:userLabel];
    
    UILabel *remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(userLabel.right, userLabel.top, MSW-Width320(18)-userLabel.right, Height320(16))];
    
    remainLabel.text = [NSString stringWithFormat:@"余额：%ld%@",(long)self.card.remain,self.card.cardKind.type == CardKindTypePrepaid?@"元":self.card.cardKind.type == CardKindTypeTime?@"天":@"次"];
    
    remainLabel.textColor = UIColorFromRGB(0xffffff);
    
    remainLabel.textAlignment = NSTextAlignmentRight;
    
    remainLabel.font = AllFont(12);
    
    [topView addSubview:remainLabel];
    
    UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16),cardBackView.bottom+Height320(11), Width320(150), Height320(14))];
    
    chooseLabel.text = @"选择充值规格";
    
    chooseLabel.textColor = UIColorFromRGB(0x666666);
    
    chooseLabel.font = AllFont(12);
    
    [topView addSubview:chooseLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(Width320(88), self.card.cardKind.type == CardKindTypeTime?Height320(58):Height320(74));
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,chooseLabel.bottom, MSW, self.card.cardKind.type == CardKindTypeTime?Height320(152):Height320(184)) collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.collectionView.bounces = YES;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[SpecCell class] forCellWithReuseIdentifier:identifier];
    
    [topView addSubview:self.collectionView];
    
    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(10), MSW, Height320(40))];
    
    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.secView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:self.secView];
    
    self.secView.hidden = YES;
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.startTF.placeholder = @"开始日期";
    
    self.startTF.mustInput = YES;
    
    self.startTF.textPlaceholder = @"请选择";
    
    self.startTF.delegate = self;
    
    self.startTF.type = QCTextFieldTypeCell;
    
    self.startTF.noLine = YES;
    
    [self.secView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.delegate = self;
    
    startKV.tag = 101;
    
    self.startTF.inputView = startKV;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    startKV.keyboard = self.startDP;
    
    if (self.card.cardKind.type != CardKindTypeTime) {
        
        self.rechargeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.rechargeTF.placeholder = self.card.cardKind.type == CardKindTypePrepaid?@"充值金额（元）":@"充值次数（次）";
        
        self.rechargeTF.mustInput = YES;
        
        self.rechargeTF.delegate = self;
        
        self.rechargeTF.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self.secView addSubview:self.rechargeTF];
        
    }
    
    self.receiveTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.card.cardKind.type == CardKindTypeTime?Height320(40)*2:Height320(40), MSW-Width320(32), Height320(40))];
    
    self.receiveTF.placeholder = @"实收金额（元）";
    
    self.receiveTF.mustInput = YES;
    
    self.receiveTF.delegate = self;
    
    self.receiveTF.noLine = YES;
    
    self.receiveTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.secView addSubview:self.receiveTF];
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(100), MSW, Height320(40))];
    
    self.thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.thirdView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:self.thirdView];
    
    self.thirdView.hidden = YES;
    
    self.validCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.validCell.titleLabel.text = @"设置有效期";
    
    self.validCell.delegate = self;
    
    [self.thirdView addSubview:self.validCell];
    
    self.validStartTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.card.cardKind.type == CardKindTypeTime?0:Height320(40), MSW-Width320(32), Height320(40))];
    
    self.validStartTF.placeholder = @"开始日期";
    
    self.validStartTF.mustInput = self.card.cardKind.type == CardKindTypeTime;
    
    self.validStartTF.textPlaceholder = @"请选择";
    
    self.validStartTF.delegate = self;
    
    self.validStartTF.type = QCTextFieldTypeCell;
    
    self.validStartTF.hidden = YES;
    
    [self.card.cardKind.type == CardKindTypeTime?self.secView:self.thirdView addSubview:self.validStartTF];
    
    QCKeyboardView *validStartKV = [QCKeyboardView defaultKeboardView];
    
    validStartKV.delegate = self;
    
    validStartKV.tag = 102;
    
    self.validStartTF.inputView = validStartKV;
    
    self.validStartDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.validStartDP.datePickerMode = UIDatePickerModeDate;
    
    validStartKV.keyboard = self.validStartDP;
    
    self.validEndTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.validStartTF.left, self.validStartTF.bottom, self.validStartTF.width, self.validStartTF.height)];
    
    self.validEndTF.placeholder = @"结束日期";
    
    self.validEndTF.mustInput = self.card.cardKind.type == CardKindTypeTime;
    
    self.validEndTF.textPlaceholder = @"请选择";
    
    self.validEndTF.delegate = self;
    
    self.validEndTF.type = QCTextFieldTypeCell;
    
    self.validEndTF.hidden = YES;
    
    self.validEndTF.noLine = self.card.cardKind.type != CardKindTypeTime;
    
    [self.card.cardKind.type == CardKindTypeTime?self.secView:self.thirdView addSubview:self.validEndTF];
    
    QCKeyboardView *validEndKV = [QCKeyboardView defaultKeboardView];
    
    validEndKV.delegate = self;
    
    validEndKV.tag = 103;
    
    self.validEndTF.inputView = validEndKV;
    
    self.validEndDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.validEndDP.datePickerMode = UIDatePickerModeDate;
    
    validEndKV.keyboard = self.validEndDP;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.specs.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SpecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    Spec *spec = self.specs[indexPath.row];
    
    cell.choosed = spec.choosed;
    
    cell.cardKindType = self.card.cardKind.type;
    
    cell.type = spec.type;
    
    cell.price = spec.charge;
    
    cell.cost = spec.price;
    
    cell.validTime = spec.validTime;
    
    cell.checkValid = spec.checkValid;
    
    cell.onlyStaffCanSee = spec.onlyStaffCanSee;
    
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Height320(12);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Height320(12);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(Height320(12), Width320(16), Height320(12), Width320(16));
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == self.specs.count -1) {
        
        if (![PermissionInfo sharedInfo].permissions.cardKindPermission.editState) {
            
            SpecListInfo *info = [[SpecListInfo alloc]init];
            
            [info requestPositionsResult:^(BOOL success, NSString *error) {
                
                if (info.positions.count) {
                    
                    NSString *str = [info.positions componentsJoinedByString:@"，"];
                    
                    [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"仅限%@使用“其他”规格",str] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                    
                }else{
                    
                    [[[UIAlertView alloc]initWithTitle:@"无权限使用“其他”规格" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                    
                }
                
            }];
            
            return;
            
        }
        
    }
    
    for (Spec *spec in self.specs) {
    
        spec.choosed = [self.specs indexOfObject:spec] == indexPath.row;
        
    }
    
    self.selectedSpec = self.specs[indexPath.row];
    
    [self reload];
    
    [self.collectionView reloadData];
    
}

-(void)reload
{
    
    if (self.selectedSpec.type != SpecTypeOther) {
        
        if (self.card.cardKind.type == CardKindTypeTime) {
            
            self.secView.hidden = NO;
            
            [self.secView changeHeight:self.card.remain<=0?Height320(40):0];
            
            self.validStartTF.hidden = self.card.remain>0;
            
            self.validStartTF.noLine = YES;
            
            self.validEndTF.hidden = YES;
            
            self.receiveTF.hidden = YES;
            
            self.thirdView.hidden = YES;
            
            self.startTF.hidden = YES;
            
            self.rechargeTF.hidden = YES;
            
        }else
        {
            
            self.secView.hidden = !self.selectedSpec.checkValid;
            
            self.rechargeTF.hidden = YES;
            
            self.receiveTF.hidden = YES;
            
            self.validStartTF.hidden = YES;
            
            self.validEndTF.hidden = YES;
            
            self.startTF.hidden = self.secView.hidden;
            
            [self.secView changeHeight:Height320(40)];
            
            self.thirdView.hidden = YES;
            
        }
        
        [self.mainView setContentSize:CGSizeMake(0, self.thirdView.bottom+Height320(20))];
        
    }else
    {
        
        self.secView.hidden = NO;
        
        self.startTF.hidden = YES;
        
        if (self.card.cardKind.type != CardKindTypeTime) {
            
            self.rechargeTF.hidden = NO;
            
            self.validStartTF.hidden = !self.validCell.on;
            
            self.validEndTF.hidden = !self.validCell.on;
            
        }else
        {
            
            self.startTF.hidden = YES;
            
            self.rechargeTF.hidden = YES;
            
            self.validStartTF.hidden = NO;
            
            self.validStartTF.noLine = NO;
            
            self.validEndTF.hidden = NO;
            
        }
        
        self.receiveTF.hidden = NO;
        
        [self.secView changeHeight:self.card.cardKind.type == CardKindTypeTime?Height320(40)*3:Height320(40)*2];
        
        self.thirdView.hidden = self.card.cardKind.type == CardKindTypeTime;
        
        [self.mainView setContentSize:CGSizeMake(0, self.thirdView.bottom+Height320(20))];
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    [self.thirdView changeHeight:cell.on?Height320(40)*3:Height320(40)];
    
    self.validCell.noLine = !cell.on;
    
    self.validStartTF.hidden = !cell.on;
    
    self.validEndTF.hidden = !cell.on;
    
    [self.mainView setContentSize:CGSizeMake(0, self.thirdView.bottom+Height320(20))];
    
}

-(void)naviRightClick
{
    
    if (!self.selectedSpec) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择充值规格" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.startTF.hidden  && !self.startTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.rechargeTF && !self.rechargeTF.hidden && !self.rechargeTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:self.card.cardKind.type == CardKindTypePrepaid?@"请填写充值金额":@"请填写充值次数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.receiveTF.hidden && !self.receiveTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写实收金额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.validStartTF.hidden  && !self.validStartTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.validEndTF.hidden  && !self.validEndTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    Spec *spec = self.selectedSpec;
    
    Card *card = [self.card copy];
    
    CardImproveController *svc = [[CardImproveController alloc]init];
    
    if (self.card.cardKind.type == CardKindTypeTime) {
        
        card.checkValid = YES;
        
        if (card.remain<=0) {
            
            card.start = self.validStartTF.text;
            
        }
        
        if (spec.type == SpecTypeOther) {
            
            card.end = self.validEndTF.text;
            
            spec.price = self.receiveTF.text;
            
            card.remain = 0;
            
            NSInteger i = [[self.dateFormatter dateFromString:card.end] timeIntervalSinceDate:[[self.dateFormatter dateFromString:card.start] timeIntervalSinceDate:[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:[NSDate date]]]]<0?[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:[NSDate date]]]:[self.dateFormatter dateFromString:card.start]]/86400+1;
            
            spec.charge = [NSString stringWithInteger:i];
            
        }else
        {
            
            if (card.remain<=0) {
                
                card.remain = 0;
                
                card.end = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:([spec.charge integerValue]-1)*86400 sinceDate:[self.dateFormatter dateFromString:self.validStartTF.text]]];
                
            }else{
                
                card.end = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:([spec.charge integerValue]+card.remain-1)*86400 sinceDate:[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:[NSDate date]]]]];
                
            }
            
        }
        
    }else
    {
        
        if (spec.type == SpecTypeOther) {
            
            spec.charge = self.rechargeTF.text;
            
            spec.price = self.receiveTF.text;
            
            spec.checkValid = self.validCell.on;
            
            if (spec.checkValid) {
                
                card.validFrom = self.validStartTF.text;
                
                card.validTo = self.validEndTF.text;
                
                card.checkValid = YES;
                
            }
            
        }else
        {
            
            if (spec.checkValid) {
                
                NSDateFormatter *df = [[NSDateFormatter alloc]init];
                
                df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
                
                df.dateFormat = @"yyyy-MM-dd";
                
                card.validFrom = self.startTF.text;
                
                card.validTo = [df stringFromDate:[NSDate dateWithTimeInterval:(spec.validTime-1)*86400 sinceDate:[df dateFromString:card.validFrom]]];
                
                card.checkValid = YES;
                
            }
            
        }

    }
    
    svc.card = card;
    
    svc.spec = spec;
    
    svc.gym = self.gym;
    
    svc.type = PayTypeRecharge;
    
    [self.navigationController pushViewController: svc animated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    if (keyboardView.tag == 101) {
        
        self.startTF.text = [self.dateFormatter stringFromDate:self.startDP.date];
        
        [self.view endEditing:YES];
        
    }else if(keyboardView.tag == 102){
        
        if (self.validEndTF.text.length) {
            
            if ([[self.dateFormatter dateFromString:self.validEndTF.text] timeIntervalSinceDate:[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:self.validStartDP.date]]]<0) {
                
                [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.validStartTF.text = [self.dateFormatter stringFromDate:self.validStartDP.date];
        
        [self.view endEditing:YES];
        
    }else if (keyboardView.tag == 103){
        
        if (self.validStartTF.text.length) {
            
            if ([[self.dateFormatter dateFromString:self.validStartTF.text] timeIntervalSinceDate:[self.dateFormatter dateFromString:[self.dateFormatter stringFromDate:self.validEndDP.date]]]>0) {
                
                [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.validEndTF.text = [self.dateFormatter stringFromDate:self.validEndDP.date];
                
        [self.view endEditing:YES];
        
    }
    
}
@end
