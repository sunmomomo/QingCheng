//
//  CheckinManualController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinManualController.h"

#import "MOCell.h"

#import "CheckSuccessView.h"

#import "CheckinCardCell.h"

#import "CheckinManualInfo.h"

#import "ChestSearchController.h"

#import "Checkin.h"

#import "CheckinInfo.h"

#import "CardRechargeChooseSpecController.h"

#import "CardCreateChooseKindController.h"

#import "UpYun.h"

#import "CheckinPhotoHistoryInfo.h"

#import <AVFoundation/AVFoundation.h>

#import "PictureShowController.h"

static NSString *identifier = @"Cell";

@interface CheckinManualController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UILabel *cardNameLabel;

@property(nonatomic,strong)UILabel *cardRemainLabel;

@property(nonatomic,strong)UIView *noEnoughView;

@property(nonatomic,strong)UIView *sep;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)MOCell *ChestCell;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)UIView *courseView;

@property(nonatomic,strong)UIView *courseTop;

@property(nonatomic,strong)UIImageView *bottomView;

@property(nonatomic,strong)UIButton *iconView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UIImageView *sexImg;

@property(nonatomic,strong)UILabel *phoneLabel;

@property(nonatomic,strong)CheckSuccessView *successView;

@property(nonatomic,strong)UIView *cardBackView;

@property(nonatomic,strong)UITableView *cardTableView;

@property(nonatomic,strong)Card *chooseCard;

@property(nonatomic,strong)NSArray *cardArray;

@property(nonatomic,strong)UIView *noCardView;

@property(nonatomic,strong)Checkin *checkin;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CheckinManualController

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
    
    self.checkin = [[Checkin alloc]init];
    
    self.checkin.chest = nil;
    
    self.checkin.student = self.stu;
    
    if (self.checkin.student.photo.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.checkin.student.photo forState:UIControlStateNormal];
        
    }else{
        
        [self.iconView setImage:[UIImage imageNamed:@"checkin_photo_add"] forState:UIControlStateNormal];
        
    }
    
    [self.iconView addTarget:self action:@selector(editPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    CheckinManualInfo *info = [[CheckinManualInfo alloc]init];
    
    [info requestCoursesWithStudent:self.stu result:^(BOOL success, NSString *error) {
        
        [self setCourseBatches:info.courses];
        
    }];
    
    CheckinManualInfo *cardInfo = [[CheckinManualInfo alloc]init];
    
    [cardInfo requsetCardsWithStudent:self.stu result:^(BOOL success, NSString *error) {
        
        [self createCardArrayWithArray:cardInfo.cards];
        
        self.cardArray = cardInfo.cards;
        
        self.chooseCard = [self.cardArray firstObject];
        
        [self checkRemain];
        
        if (self.cardArray.count*Height320(60)+Height320(30)>=Height320(368)) {
            
            [self.cardTableView changeHeight:MSH-Height320(368)];
            
        }else{
            
            [self.cardTableView changeHeight:self.cardArray.count*Height320(60)+Height320(30)];
            
        }
        
        [self.cardTableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    CheckinManualInfo *cardInfo = [[CheckinManualInfo alloc]init];
    
    [cardInfo requsetCardsWithStudent:self.stu result:^(BOOL success, NSString *error) {
        
        [self createCardArrayWithArray:cardInfo.cards];
        
        self.cardArray = cardInfo.cards;
        
        self.chooseCard = [self.cardArray firstObject];
        
        [self checkRemain];
        
        if (self.cardArray.count*Height320(60)+Height320(30)>=Height320(368)) {
            
            [self.cardTableView changeHeight:MSH-Height320(368)];
            
        }else{
            
            [self.cardTableView changeHeight:self.cardArray.count*Height320(60)+Height320(30)];
            
        }
        
        [self.cardTableView reloadData];
        
    }];
    
}

-(void)createCardArrayWithArray:(NSArray *)array
{
    
    for (Card *card in array) {
        
        for (CardKind *cardKind in self.settingInfo.cardKinds) {
            
            if (card.cardKind.cardKindId == cardKind.cardKindId) {
                
                card.cardKind.cost = cardKind.cost;
                
                break;
                
            }
            
        }
        
    }
    
}

-(void)createUI
{
    
    self.title = @"手动签到";
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(78))];
    
    topView.backgroundColor = UIColorFromRGB(0x8CB5BA);
    
    [self.mainView addSubview:topView];
    
    self.iconView = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), Height320(14), Width320(50), Height320(50))];
    
    self.iconView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    [topView addSubview:self.iconView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(10), Width320(20), MSW-self.iconView.right-Width320(30), Height320(18))];
    
    self.nameLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.nameLabel.font = AllFont(14);
    
    self.nameLabel.text = self.stu.name;
    
    [self.nameLabel autoWidth];
    
    [topView addSubview:self.nameLabel];
    
    self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.nameLabel.right+Width320(5), Height320(23), Width320(12), Height320(12))];
    
    self.sexImg.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.sexImg.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    self.sexImg.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.sexImg.layer.cornerRadius = self.sexImg.width/2;
    
    self.sexImg.layer.masksToBounds = YES;
    
    self.sexImg.image = [UIImage imageNamed:self.stu.sex == SexTypeMan?@"sex_male":@"sex_female"];
    
    [topView addSubview:self.sexImg];
    
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom+Height320(5), MSW-self.nameLabel.left, Height320(14))];
    
    self.phoneLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.phoneLabel.font = AllFont(12);
    
    self.phoneLabel.text = self.stu.phone;
    
    [topView addSubview:self.phoneLabel];
    
    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, Height320(134))];
    
    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.secView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:self.secView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(54))];
    
    [button addTarget:self action:@selector(cardChoose:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.secView addSubview:button];
    
    CGSize cardTitleSize = [@"会员卡：" boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    UILabel *cardTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, cardTitleSize.width, Height320(54))];
    
    cardTitleLabel.text = @"会员卡：";
    
    cardTitleLabel.textColor = UIColorFromRGB(0x999999);
    
    cardTitleLabel.font = AllFont(14);
    
    [button addSubview:cardTitleLabel];
    
    self.cardNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(cardTitleLabel.right, Height320(11), MSW-Width320(31)-cardTitleLabel.right, Height320(16))];
    
    self.cardNameLabel.textColor = UIColorFromRGB(0x333333);
    
    self.cardNameLabel.font = AllFont(14);
    
    self.cardNameLabel.textAlignment = NSTextAlignmentRight;
    
    [button addSubview:self.cardNameLabel];
    
    self.cardRemainLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.cardNameLabel.left, self.cardNameLabel.bottom+Height320(2), self.cardNameLabel.width, Height320(14))];
    
    self.cardRemainLabel.textColor = UIColorFromRGB(0x999999);
    
    self.cardRemainLabel.font = AllFont(12);
    
    self.cardRemainLabel.textAlignment = NSTextAlignmentRight;
    
    [button addSubview:self.cardRemainLabel];
    
    CGSize rightChargeSize = [@"立即购买" boundingRectWithSize:CGSizeMake(MSW, Height320(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    CGSize leftChargeSize = [@"无适用会员卡，" boundingRectWithSize:CGSizeMake(MSW, Height320(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    self.noCardView = [[UIView alloc]initWithFrame:CGRectMake(MSW-Width320(31)-rightChargeSize.width-leftChargeSize.width, 0, leftChargeSize.width+rightChargeSize.width, Height320(54))];
    
    [button addSubview:self.noCardView];
    
    self.noCardView.hidden = YES;
    
    UILabel *noCardLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftChargeSize.width, self.noCardView.height)];
    
    noCardLabel.textColor = UIColorFromRGB(0x666666);
    
    noCardLabel.textAlignment = NSTextAlignmentRight;
    
    noCardLabel.font = AllFont(14);
    
    noCardLabel.text = @"无适用会员卡，";
    
    [self.noCardView addSubview:noCardLabel];
    
    UIButton *chargeButton = [[UIButton alloc]initWithFrame:CGRectMake(noCardLabel.right, 0, rightChargeSize.width, self.noCardView.height)];
    
    [chargeButton setTitle:@"立即购买" forState:UIControlStateNormal];
    
    [chargeButton setTitleColor:UIColorFromRGB(0xf9944e) forState:UIControlStateNormal];
    
    chargeButton.titleLabel.font = AllFont(14);
    
    [self.noCardView addSubview:chargeButton];
    
    [chargeButton addTarget:self action:@selector(chargeCard:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *buttonArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), Height320(21), Width320(6), Height320(12))];
    
    buttonArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [button addSubview:buttonArrow];
    
    self.sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), button.height-OnePX, MSW-Width320(32), OnePX)];
    
    self.sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [button addSubview:self.sep];
    
    if (self.settingInfo.autoChest) {
        
        self.ChestCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), Height320(54), MSW-Width320(32), Height320(40))];
        
        self.ChestCell.titleLabel.text = @"更衣柜：";
        
        self.ChestCell.placeholder = @"请选择更衣柜";
        
        [self.secView addSubview:self.ChestCell];
        
        [self.ChestCell addTarget:self action:@selector(chestChoose:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.settingInfo.autoChest?self.ChestCell.bottom:Height320(54), MSW, Height320(40))];
    
    [self.secView addSubview:self.confirmButton];
    
    UIImageView *confirmImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(124), Height320(12), Width320(14), Height320(14))];
    
    confirmImg.image = [UIImage imageNamed:@"checkin_button"];
    
    [self.confirmButton addSubview:confirmImg];
    
    UILabel *confirmLabel = [[UILabel alloc]initWithFrame:CGRectMake(confirmImg.right+Width320(6), 0, Width320(100), Height320(40))];
    
    confirmLabel.text = @"确认签到";
    
    confirmLabel.textColor = UIColorFromRGB(0x0DB14B);
    
    confirmLabel.font = AllFont(13);
    
    [self.confirmButton addSubview:confirmLabel];
    
    [_confirmButton addTarget:self action:@selector(checkin:) forControlEvents:UIControlEventTouchUpInside];
    
    self.noEnoughView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(54), MSW, Height320(32))];
    
    self.noEnoughView.backgroundColor = [UIColorFromRGB(0xf9944e) colorWithAlphaComponent:0.13];
    
    [self.secView addSubview:self.noEnoughView];
    
    CGSize rightRechargeSize = [@"立即充值" boundingRectWithSize:CGSizeMake(MSW, Height320(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    CGSize leftRechargeSize = [@"会员卡余额不足，" boundingRectWithSize:CGSizeMake(MSW, Height320(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    UIButton *rechargeButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(31)-rightRechargeSize.width, 0, rightRechargeSize.width, self.noEnoughView.height)];
    
    [rechargeButton setTitle:@"立即充值" forState:UIControlStateNormal];
    
    [rechargeButton setTitleColor:UIColorFromRGB(0xf9944e) forState:UIControlStateNormal];
    
    rechargeButton.titleLabel.font = AllFont(12);
    
    [rechargeButton addTarget:self action:@selector(rechargeCard:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.noEnoughView addSubview:rechargeButton];
    
    UILabel *noEnoughLabel = [[UILabel alloc]initWithFrame:CGRectMake(rechargeButton.left-leftRechargeSize.width, 0, leftRechargeSize.width, self.noEnoughView.height)];
    
    noEnoughLabel.textColor = UIColorFromRGB(0x666666);
    
    noEnoughLabel.textAlignment = NSTextAlignmentRight;
    
    noEnoughLabel.font = AllFont(12);
    
    noEnoughLabel.text = @"会员卡余额不足，";
    
    [self.noEnoughView addSubview:noEnoughLabel];
    
    self.noEnoughView.hidden = YES;
    
    self.courseView = [[UIView alloc]initWithFrame:CGRectMake(0, self.secView.bottom+Height320(12), MSW, Height320(100))];
    
    self.courseView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.courseView.layer.shadowOffset = CGSizeMake(0, Height320(2));
    
    self.courseView.layer.shadowOpacity = 0.12;
    
    [self.mainView addSubview:self.courseView];
    
    self.courseTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(92))];
    
    self.courseTop.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.courseView addSubview:self.courseTop];
    
    self.bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.courseTop.bottom, MSW, Height320(8))];
    
    self.bottomView.image = [UIImage imageNamed:@"checkin_bottom"];
    
    [self.courseView addSubview:self.bottomView];
    
    self.cardBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    self.cardBackView.hidden = YES;
    
    [self.view addSubview:self.cardBackView];
    
    UIView *cardBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    cardBack.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    
    [cardBack addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCardView)]];
    
    [self.cardBackView addSubview:cardBack];
    
    self.cardTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MSH, MSW, MSH) style:UITableViewStylePlain];
    
    self.cardTableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.cardTableView registerClass:[CheckinCardCell class] forCellReuseIdentifier:identifier];
    
    self.cardTableView.tableFooterView = [UIView new];
    
    self.cardTableView.dataSource = self;
    
    self.cardTableView.delegate = self;
    
    [self.cardBackView addSubview:self.cardTableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)setCourseBatches:(NSArray *)courseBatches
{
    
    if (courseBatches.count) {
        
        [self.mainView addSubview:_courseView];
        
        [_courseTop changeHeight:Height320(30)+courseBatches.count*Height320(40)];
        
        [_bottomView changeTop:_courseTop.bottom];
        
        [_courseView changeHeight:_bottomView.bottom];
        
        [_courseTop removeAllView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), Height320(11), Width320(3), Height320(11)+Height320(40)*courseBatches.count)];
        
        lineView.backgroundColor = UIColorFromRGB(0x8CB5BA);
        
        [_courseView addSubview:lineView];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(25), Height320(9), Width320(200), Height320(14))];
        
        numLabel.text = [NSString stringWithFormat:@"当天预约课程（%ld）",(unsigned long)courseBatches.count];
        
        numLabel.textColor = UIColorFromRGB(0x999999);
        
        numLabel.font = AllFont(12);
        
        [_courseView addSubview:numLabel];
        
        for (NSInteger i = 0 ; i<courseBatches.count; i++) {
            
            CoursePlanBatch *batch = courseBatches[i];
            
            Course *course = batch.course;
            
            UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(25), numLabel.bottom+Height320(40)*i+Height320(2), Width320(40), Height320(14))];
            
            timeLabel.text = batch.start;
            
            timeLabel.textColor = UIColorFromRGB(0x666666);
            
            timeLabel.font = AllFont(12);
            
            [_courseView addSubview:timeLabel];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeLabel.right, timeLabel.top, MSW-Width320(12)-timeLabel.right, Height320(14))];
            
            nameLabel.text = course.name;
            
            nameLabel.textColor = UIColorFromRGB(0x666666);
            
            nameLabel.font = AllFont(12);
            
            [_courseView addSubview:nameLabel];
            
            UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom+Height320(3), nameLabel.width, nameLabel.height)];
            
            Yard *yard = [batch.yards firstObject];
            
            subLabel.text = [NSString stringWithFormat:@"教练：%@    场地：%@",batch.coach.name,yard.name];
            
            subLabel.textColor = UIColorFromRGB(0x999999);
            
            subLabel.font = AllFont(12);
            
            [_courseView addSubview:subLabel];
            
        }
        
    }else{
        
        [_courseView removeFromSuperview];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cardArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CheckinCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Card *card = self.cardArray[indexPath.row];
    
    cell.cardName = card.cardKind.cardKindName;
    
    if (card.cardKind.type == CardKindTypePrepaid) {
        
        cell.remain = [NSString stringWithFormat:@"余额：%.0f元",card.remain];
        
    }else if (card.cardKind.type == CardKindTypeCount){
        
        cell.remain = [NSString stringWithFormat:@"余额：%.0f次",card.remain];
        
    }else{
        
        cell.remain = [NSString stringWithFormat:@"有效期至：%@",[card.end substringToIndex:10]];
        
    }
    
    cell.choosed = card.cardId == self.chooseCard.cardId;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(60);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Card *card = self.cardArray[indexPath.row];
    
    self.chooseCard = card;
    
    [self hideCardView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(30);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(30))];
    
    view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UILabel *cardHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(200), Height320(30))];
    
    cardHeaderLabel.text = @"选择会员卡";
    
    cardHeaderLabel.textColor = UIColorFromRGB(0x999999);
    
    cardHeaderLabel.font = AllFont(12);
    
    [view addSubview:cardHeaderLabel];
    
    return view;
    
}

-(void)hideCardView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.cardTableView changeTop:MSH];
        
    } completion:^(BOOL finished) {
        
        self.cardBackView.hidden = YES;
        
        [self checkRemain];
        
    }];
    
}

-(void)chestChoose:(MOCell *)cell
{
    
    ChestSearchController *svc = [[ChestSearchController alloc]init];
    
    if (self.checkin.chest) {
        
        svc.chest = self.checkin.chest;
        
    }
    
    __weak typeof(self)weakS = self;
    
    svc.chooseChestFinish = ^(Chest *chest){
       
        weakS.checkin.chest = chest;
        
        weakS.ChestCell.subtitle = chest.name;
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)cardChoose:(UIButton*)button
{
    
    self.cardBackView.hidden = NO;
    
    [self.cardTableView reloadData];
    
    [self.view bringSubviewToFront:self.cardBackView];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.cardTableView changeTop:MSH-self.cardTableView.height];
        
    }];
    
}

-(void)chargeCard:(UIButton*)button
{
    
    CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
    
    svc.gym = AppGym;
    
    svc.student = self.stu;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)rechargeCard:(UIButton*)button
{
    
    CardRechargeChooseSpecController *svc = [[CardRechargeChooseSpecController alloc]init];
    
    svc.card = self.chooseCard;
    
    svc.gym = AppGym;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)checkRemain
{
    
    if (!self.cardArray.count) {
        
        self.noEnoughView.hidden = YES;
        
        self.noCardView.hidden = NO;
        
        if (self.settingInfo.autoChest) {
            
            [self.ChestCell changeTop:Height320(54)];
            
        }else{
            
            [self.confirmButton changeTop:Height320(54)];
            
        }
        
    }else{
        
        self.cardNameLabel.text = self.chooseCard.cardNumber.length?[NSString stringWithFormat:@"%@（%@）",self.chooseCard.cardKind.cardKindName,self.chooseCard.cardNumber]:self.chooseCard.cardKind.cardKindName;
    
        NSString *remain = @"";
        
        switch (self.chooseCard.cardKind.type) {
            case CardKindTypePrepaid:
                
                remain = [NSString stringWithFormat:@"余额：%.0f元",self.chooseCard.remain];
                
                break;
                
            case CardKindTypeCount:
                
                remain = [NSString stringWithFormat:@"余额：%.0f次",self.chooseCard.remain];
                
                break;
            case CardKindTypeTime:
                
                if (self.chooseCard.end.length) {
                    
                    remain = [NSString stringWithFormat:@"有效期至：%@",[self.chooseCard.end substringToIndex:10]];
                    
                }
                
                break;
                
            default:
                break;
        }
        
        self.cardRemainLabel.text = self.chooseCard.cardKind.type == CardKindTypeTime?remain:[NSString stringWithFormat:@"%@ 每次签到扣费%ld%@/人",remain,(long)self.chooseCard.cardKind.cost,self.chooseCard.cardKind.type == CardKindTypePrepaid?@"元":@"次"];
        
        self.noEnoughView.hidden = YES;
        
        self.noCardView.hidden = YES;
        
        if (self.settingInfo.autoChest) {
            
            [self.ChestCell changeTop:Height320(54)];
            
            [self.confirmButton changeTop:self.ChestCell.bottom];
            
        }else{
            
            [self.confirmButton changeTop:Height320(54)];
            
        }
        
        if (self.chooseCard.remain<=0) {
            
            self.noEnoughView.hidden = NO;
            
            if (self.settingInfo.autoChest) {
                
                [self.ChestCell changeTop:self.noEnoughView.bottom];
                
                [self.confirmButton changeTop:self.ChestCell.bottom];
                
            }else{
                
                [self.confirmButton changeTop:self.noEnoughView.bottom];
                
            }
            
        }else{
            
            for (CardKind *cardKind in self.settingInfo.cardKinds) {
                
                if (cardKind.cardKindId == self.chooseCard.cardKind.cardKindId) {
                    
                    if (self.chooseCard.remain < cardKind.cost) {
                        
                        self.noEnoughView.hidden = NO;
                        
                        if (self.settingInfo.autoChest) {
                            
                            [self.ChestCell changeTop:self.noEnoughView.bottom];
                            
                            [self.confirmButton changeTop:self.ChestCell.bottom];
                            
                        }else{
                            
                            [self.confirmButton changeTop:self.noEnoughView.bottom];
                            
                        }
                        
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    [self.secView changeHeight:self.confirmButton.bottom];
    
    [self.courseView changeTop:self.secView.bottom+Height320(12)];
    
}

-(void)checkin:(UIButton*)button
{
    
    if (!self.chooseCard) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择签到会员卡" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.chooseCard.remain<=0) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择签到会员卡" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.checkin.card = self.chooseCard;
    
    CheckinInfo *info = [[CheckinInfo alloc]init];
    
    button.userInteractionEnabled = NO;
    
    [info checkinWithCheckin:self.checkin result:^(BOOL success, NSString *error) {
        
        button.userInteractionEnabled = YES;
        
        if (success) {
            
            CheckSuccessView *successView = [CheckSuccessView defaultSuccessView];
            
            successView.title = [NSString stringWithFormat:@"%@签到成功",self.stu.name];
            
            [self.view addSubview:successView];
            
            [successView show];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewControllerAndReloadData];
                
            });
            
        }else{
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            hud.label.text = error;
            
            hud.label.numberOfLines = 0;
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)editPhoto
{
    
    if (self.checkin.student.photo.absoluteString.length) {
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = self.checkin.student.photo;
        
        [self presentViewController:svc animated:YES completion:nil];
        
        return;
        
    }
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState||[PermissionInfo sharedInfo].permissions.personalUserPermission.editState) {
        
        UIActionSheet *actionSheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        }else{
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
        }
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
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
                
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"相机访问受限，请到设置-隐私-相机中允许【健身房管理】访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
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
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        [self performSelector:@selector(showCamera:) withObject:[NSNumber numberWithInteger:sourceType] afterDelay:1.0f];
        
    }else
    {
        
        self.imagePickerController = [[UIImagePickerController alloc] init];
        
        self.imagePickerController.delegate = self;
        
        self.imagePickerController.allowsEditing = YES;
        
        self.imagePickerController.sourceType = sourceType;
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{}];
        
    }
    
}

-(void)showCamera:(NSNumber*)typeNumber
{
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    
    self.imagePickerController.delegate = self;
    
    self.imagePickerController.allowsEditing = YES;
    
    self.imagePickerController.sourceType = [typeNumber integerValue];
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    self.image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    [self uploadImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage
{
    
    UpYun *uy = [[UpYun alloc] init];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        CheckinPhotoHistoryInfo *info = [[CheckinPhotoHistoryInfo alloc]init];
        
        [info uploadPhoto:self.checkin.student.photo.absoluteString student:self.checkin.student result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [self reloadData];
                
                self.hud.label.text = @"上传成功";
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
                [self.iconView sd_setImageWithURL:self.checkin.student.photo forState:UIControlStateNormal];
                
            }else{
                
                self.checkin.student.photo = nil;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
            }
            
        }];
        
    };
    
    uy.failBlocker = ^(NSError *error){
        
        self.hud.label.text = @"上传图片失败";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
    };
    
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes)
    {
        
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        
        self.hud.label.text = @"";
        
        self.hud.progress = percent;
        
        [self.hud showAnimated:YES];
        
    };
    
    NSString *url = [UpYun getSaveKey];
    
    self.checkin.student.photo = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

@end
