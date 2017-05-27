//
//  IntegralSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralSettingController.h"

#import "MOSwitchCell.h"

#import "IntegralSettingInfo.h"

#import "IntegralsettingCell.h"

#import "IntegralBasicSettingController.h"

#import "IntegralAwardController.h"

#import "IntegralListController.h"

static NSString *identifier = @"Cell";

@interface IntegralSettingController ()<UITableViewDelegate,UITableViewDataSource,MOSwitchCellDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)MOSwitchCell *switchCell;

@property(nonatomic,strong)UIView *tableHeader;

@property(nonatomic,strong)IntegralSetting *setting;

@property(nonatomic,strong)MOSwitchCell *useCell;

@property(nonatomic,strong)UILabel *changerLabel;

@property(nonatomic,strong)UIView *basicView;

@property(nonatomic,strong)UIView *firstHeader;

@property(nonatomic,assign)BOOL showExpire;

@end

@implementation IntegralSettingController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)reloadHeader
{
    
    self.useCell.on = self.setting.used;
    
    if (self.setting.used) {
        
        self.basicView.hidden = NO;
        
        self.firstHeader.hidden = NO;
        
        self.changerLabel.text = self.setting.changer.name.length?[NSString stringWithFormat:@"修改时间  %@  由%@操作",self.setting.changeTime,self.setting.changer.name]:[NSString stringWithFormat:@"修改时间  %@",self.setting.changeTime];
        
        for (UIView *subView in self.basicView.subviews) {
            
            if ([subView isKindOfClass:[UILabel class]]) {
                
                [subView removeFromSuperview];
                
            }
            
        }
        
        float top = Height320(60)+Height320(15);
        
        if (self.setting.groupSetting.used) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), top, MSW-Width320(36), Height320(14))];
            
            label.text = [NSString stringWithFormat:@"团课预约    %@分/次",[NSString formatStringWithFloat:self.setting.groupSetting.integral]];
            
            label.textColor = UIColorFromRGB(0x999999);
            
            label.font = AllFont(12);
            
            [self.basicView addSubview:label];
            
            top = label.bottom+Height320(2);
            
        }
        
        if (self.setting.privateSetting.used) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), top, MSW-Width320(36), Height320(14))];
            
            label.text = [NSString stringWithFormat:@"私教预约    %@分/次",[NSString formatStringWithFloat:self.setting.privateSetting.integral]];
            
            label.textColor = UIColorFromRGB(0x999999);
            
            label.font = AllFont(12);
            
            [self.basicView addSubview:label];
            
            top = label.bottom+Height320(2);
            
        }
        
        if (self.setting.checkinSetting.used) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), top, MSW-Width320(36), Height320(14))];
            
            label.text = [NSString stringWithFormat:@"签到            %@分/次",[NSString formatStringWithFloat:self.setting.checkinSetting.integral]];
            
            label.textColor = UIColorFromRGB(0x999999);
            
            label.font = AllFont(12);
            
            [self.basicView addSubview:label];
            
            top = label.bottom+Height320(2);
            
        }
        
        if (self.setting.chargeUsed) {
            
            UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), top, Width320(70), Height320(14))];
            
            leftLabel.text = @"新购卡积分";
            
            leftLabel.font = AllFont(12);
            
            leftLabel.textColor = UIColorFromRGB(0x999999);
            
            [self.basicView addSubview:leftLabel];
            
            if (self.setting.chargeSettings.count) {
                
                NSString *str;
                
                NSMutableArray *strArray = [NSMutableArray array];
                
                for (IntegralCardSetting *setting in self.setting.chargeSettings) {
                    
                    NSString *tempStr = [NSString stringWithFormat:@"实收金额%@至%@元，每1元得%@积分",[NSString formatStringWithFloat:setting.fromPrice],[NSString formatStringWithFloat:setting.toPrice],[NSString formatStringWithFloat:setting.integral]];
                    
                    [strArray addObject:tempStr];
                    
                }
                
                str = [strArray componentsJoinedByString:@"\n"];
                
                CGSize size = [str boundingRectWithSize:CGSizeMake(Width320(224), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
                
                UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftLabel.right, top, size.width, size.height)];
                
                rightLabel.text = str;
                
                rightLabel.font = AllFont(12);
                
                rightLabel.textColor = UIColorFromRGB(0x999999);
                
                rightLabel.numberOfLines = 0;
                
                [self.basicView addSubview:rightLabel];
                
                top = rightLabel.bottom+Height320(2);
                
            }else{
                
                top = leftLabel.bottom+Height320(2);
                
            }
            
        }
        
        if (self.setting.rechargeUsed) {
            
            UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), top, Width320(70), Height320(14))];
            
            leftLabel.text = @"会员卡续费";
            
            leftLabel.font = AllFont(12);
            
            leftLabel.textColor = UIColorFromRGB(0x999999);
            
            [self.basicView addSubview:leftLabel];
            
            if (self.setting.rechargeSettings.count) {
                
                NSString *str;
                
                NSMutableArray *strArray = [NSMutableArray array];
                
                for (IntegralCardSetting *setting in self.setting.rechargeSettings) {
                    
                    NSString *tempStr = [NSString stringWithFormat:@"实收金额%@至%@元，每1元得%@积分",[NSString formatStringWithFloat:setting.fromPrice],[NSString formatStringWithFloat:setting.toPrice],[NSString formatStringWithFloat:setting.integral]];
                    
                    [strArray addObject:tempStr];
                    
                }
                
                str = [strArray componentsJoinedByString:@"\n"];
                
                CGSize size = [str boundingRectWithSize:CGSizeMake(Width320(224), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
                
                UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftLabel.right, top, size.width, size.height)];
                
                rightLabel.text = str;
                
                rightLabel.font = AllFont(12);
                
                rightLabel.textColor = UIColorFromRGB(0x999999);
                
                rightLabel.numberOfLines = 0;
                
                [self.basicView addSubview:rightLabel];
                
                top = rightLabel.bottom+Height320(2);
                
            }else{
                
                top = leftLabel.bottom+Height320(2);
                
            }
            
        }
        
        [self.basicView changeHeight:top+Height320(13)];
        
        [self.firstHeader changeTop:self.basicView.bottom+Height320(12)];
        
        [self.tableHeader changeHeight:self.firstHeader.bottom];
        
    }else{
        
        self.basicView.hidden = YES;
        
        self.firstHeader.hidden = YES;
        
    }

}

-(void)reloadData
{
    
    IntegralSettingInfo *settingInfo = [[IntegralSettingInfo alloc]init];
    
    [settingInfo requestResult:^(BOOL success, NSString *error) {
        
        self.setting.used = settingInfo.setting.used;
        
        [self reloadHeader];
        
    }];
    
    IntegralSettingInfo *basicInfo = [[IntegralSettingInfo alloc]init];
    
    [basicInfo requestBasicResult:^(BOOL success, NSString *error) {
        
        self.setting.changer = basicInfo.setting.changer;
        
        self.setting.changeTime = basicInfo.setting.changeTime;
        
        self.setting.groupSetting = basicInfo.setting.groupSetting;
        
        self.setting.privateSetting = basicInfo.setting.privateSetting;
        
        self.setting.checkinSetting = basicInfo.setting.checkinSetting;
        
        self.setting.chargeSettings = basicInfo.setting.chargeSettings;
        
        self.setting.rechargeSettings = basicInfo.setting.rechargeSettings;
        
        self.setting.chargeUsed = basicInfo.setting.chargeUsed;
        
        self.setting.rechargeUsed = basicInfo.setting.rechargeUsed;
        
        [self reloadHeader];
        
        [self.tableView reloadData];
        
    }];
    
    IntegralSettingInfo *awardInfo = [[IntegralSettingInfo alloc]init];
    
    [awardInfo requestAwardResult:^(BOOL success, NSString *error) {
        
        self.setting.normalAwards = awardInfo.setting.normalAwards;
        
        self.setting.expireAwards = awardInfo.setting.expireAwards;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createData
{
    
    self.setting = [[IntegralSetting alloc]init];
    
    IntegralSettingInfo *info = [[IntegralSettingInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.setting.used = info.setting.used;
        
        [self reloadHeader];
        
        [self.tableView reloadData];
        
    }];
    
    IntegralSettingInfo *basicInfo = [[IntegralSettingInfo alloc]init];
    
    [basicInfo requestBasicResult:^(BOOL success, NSString *error) {
        
        self.setting.changer = basicInfo.setting.changer;
        
        self.setting.changeTime = basicInfo.setting.changeTime;
        
        self.setting.groupSetting = basicInfo.setting.groupSetting;
        
        self.setting.privateSetting = basicInfo.setting.privateSetting;
        
        self.setting.checkinSetting = basicInfo.setting.checkinSetting;
        
        self.setting.chargeSettings = basicInfo.setting.chargeSettings;
        
        self.setting.rechargeSettings = basicInfo.setting.rechargeSettings;
        
        self.setting.chargeUsed = basicInfo.setting.chargeUsed;
        
        self.setting.rechargeUsed = basicInfo.setting.rechargeUsed;
        
        [self reloadHeader];
        
        [self.tableView reloadData];
        
    }];
    
    IntegralSettingInfo *awardInfo = [[IntegralSettingInfo alloc]init];
    
    [awardInfo requestAwardResult:^(BOOL success, NSString *error) {
        
        self.setting.normalAwards = awardInfo.setting.normalAwards;
        
        self.setting.expireAwards = awardInfo.setting.expireAwards;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"积分设置";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[IntegralSettingCell class] forCellReuseIdentifier:identifier];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"none"];
    
    [self.view addSubview:self.tableView];
    
    self.tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(300))];
    
    self.tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = self.tableHeader;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.tableHeader addSubview:topView];
    
    self.useCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.useCell.titleLabel.text = @"积分功能";
    
    self.useCell.delegate = self;
    
    self.useCell.userInteractionEnabled = [PermissionInfo sharedInfo].permissions.integralPermisson.editState;
    
    [topView addSubview:self.useCell];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(9), MSW-Width320(32), Height320(17))];
    
    hintLabel.text = @"注意：开启积分功能后，会员端将展示积分。";
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.font = AllFont(12);
    
    [self.tableHeader addSubview:hintLabel];
    
    self.basicView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(82), MSW, Height320(300))];
    
    self.basicView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.basicView.layer.borderWidth = OnePX;
    
    self.basicView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.tableHeader addSubview:self.basicView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(60))];
    
    [button addTarget:self action:@selector(basicChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.basicView addSubview:button];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(60)-OnePX, MSW, OnePX)];
    
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [button addSubview:line];
    
    UIImageView *basicImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(11), Width320(15), Height320(17))];
    
    basicImg.image = [UIImage imageNamed:@"integral_setting_basic"];
    
    [button addSubview:basicImg];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(basicImg.right+Width320(6), Height320(10), Width320(120), Height320(18))];
    
    basicLabel.text = @"基础积分";
    
    basicLabel.textColor = UIColorFromRGB(0x666666);
    
    basicLabel.font = AllFont(13);
    
    [button addSubview:basicLabel];
    
    self.changerLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(20), basicLabel.bottom+Height320(4), MSW-Width320(40), Height320(17))];
    
    self.changerLabel.textColor = UIColorFromRGB(0x999999);
    
    self.changerLabel.font = AllFont(12);
    
    [button addSubview:self.changerLabel];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), Height320(24), Width320(7), Height320(12))];
    
    arrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [button addSubview:arrow];
    
    self.firstHeader = [[UIView alloc]initWithFrame:CGRectMake(0, self.basicView.bottom+Height320(12), MSW, Height320(40))];
    
    self.firstHeader.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.tableHeader addSubview:self.firstHeader];
    
    UIImageView *firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(10), Width320(16), Height320(16))];
    
    firstImg.image = [UIImage imageNamed:@"integral_setting_award"];
    
    [self.firstHeader addSubview:firstImg];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstImg.right+Width320(5), 0, Width320(200), Height320(40))];
    
    firstLabel.text = @"积分奖励规则";
    
    firstLabel.textColor = UIColorFromRGB(0x666666);
    
    firstLabel.font = AllFont(13);
    
    [self.firstHeader addSubview:firstLabel];
    
    self.tableView.tableFooterView = [UIView new];
    
}

-(void)basicChange
{
    
    if ([PermissionInfo sharedInfo].permissions.integralPermisson.editState) {
        
        IntegralBasicSettingController *svc = [[IntegralBasicSettingController alloc]init];
        
        svc.setting = [self.setting copy];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.setting.used) {
        
        return 2;
        
    }else{
        
        return 0;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.setting.used) {
        
        if (section == 0) {
            
            if (self.setting.normalAwards.count) {
                
                return self.setting.normalAwards.count;
                
            }else{
                
                return 1;
                
            }
            
        }else{
            
            return self.showExpire?self.setting.expireAwards.count:0;
            
        }
        
    }else{
        
        return 0;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return Height320(143);
        
    }else{
        
        return 0;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(143))];
        
        footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
        
        addButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [addButton setTitle:@"+  添加积分奖励规则" forState:UIControlStateNormal];
        
        [addButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        addButton.titleLabel.font = AllFont(14);
        
        [footer addSubview:addButton];
        
        [addButton addTarget:self action:@selector(addAward) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(18), addButton.bottom+ Height320(12), MSW-Width320(36), Height320(36))];
        
        label.text = @"注意：【积分奖励】能做设定时间内在基础积分规则是增加积分倍数。";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(12);
        
        label.numberOfLines = 0;
        
        [footer addSubview:label];
        
        if (self.setting.expireAwards.count) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(70), label.bottom+Height320(18), Width320(140), Height320(24))];
            
            button.layer.cornerRadius = Width320(2);
            
            button.backgroundColor = UIColorFromRGB(0xe4e4e4);
            
            [button setTitle:self.showExpire?@"隐藏已删除的奖励规则":@"显示已删除的奖励规则" forState:UIControlStateNormal];
            
            [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
            
            button.titleLabel.font = AllFont(12);
            
            [footer addSubview:button];
            
            [button addTarget:self action:@selector(changeExpire) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        return footer;
        
    }else{
        
        return nil;
        
    }
    
}

-(void)addAward
{
    
    if ([PermissionInfo sharedInfo].permissions.integralPermisson.editState) {
        
        IntegralAwardController *svc = [[IntegralAwardController alloc]init];
        
        svc.setting = [[IntegralAwardSetting alloc]init];
        
        svc.allSetting = self.setting;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)changeExpire
{
    
    self.showExpire = !self.showExpire;
    
    [self.tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (self.setting.normalAwards.count == 0) {
            
            return 0;
            
        }else{
            
            IntegralAwardSetting *setting = self.setting.normalAwards[indexPath.row];
            
            NSString *content;
            
            NSMutableArray *contentArray = [NSMutableArray array];
            
            if (setting.groupItem.used) {
                
                [contentArray addObject:[NSString stringWithFormat:@"团课预约    %@倍",[NSString formatStringWithFloat:setting.groupItem.times]]];
                
            }
            
            if (setting.privateItem.used) {
                
                [contentArray addObject:[NSString stringWithFormat:@"私教预约    %@倍",[NSString formatStringWithFloat:setting.privateItem.times]]];
                
            }
            
            if (setting.checkinItem.used) {
                
                [contentArray addObject:[NSString stringWithFormat:@"签到积分    %@倍",[NSString formatStringWithFloat:setting.checkinItem.times]]];
                
            }
            
            if (setting.chargeItem.used) {
                
                [contentArray addObject:[NSString stringWithFormat:@"新购会员卡    %@倍",[NSString formatStringWithFloat:setting.chargeItem.times]]];
                
            }
            
            if (setting.rechargeItem.used) {
                
                [contentArray addObject:[NSString stringWithFormat:@"会员卡续费    %@倍",[NSString formatStringWithFloat:setting.rechargeItem.times]]];
                
            }
            
            content = [contentArray componentsJoinedByString:@"\n"];
            
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            
            [paragraphStyle setLineSpacing:Height320(2)];
            
            CGSize size = [content boundingRectWithSize:CGSizeMake(Width320(270), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
            
            return size.height+Height320(70);
            
        }
        
    }else{
        
        IntegralAwardSetting *setting = self.setting.expireAwards[indexPath.row];
        
        NSString *content;
        
        NSMutableArray *contentArray = [NSMutableArray array];
        
        if (setting.groupItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"团课预约    %@倍",[NSString formatStringWithFloat:setting.groupItem.times]]];
            
        }
        
        if (setting.privateItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"私教预约    %@倍",[NSString formatStringWithFloat:setting.privateItem.times]]];
            
        }
        
        if (setting.checkinItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"签到积分    %@倍",[NSString formatStringWithFloat:setting.checkinItem.times]]];
            
        }
        
        if (setting.chargeItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"新购会员卡    %@倍",[NSString formatStringWithFloat:setting.chargeItem.times]]];
            
        }
        
        if (setting.rechargeItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"会员卡续费    %@倍",[NSString formatStringWithFloat:setting.rechargeItem.times]]];
            
        }
        
        content = [contentArray componentsJoinedByString:@"\n"];
        
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:Height320(2)];
        
        CGSize size = [content boundingRectWithSize:CGSizeMake(Width320(270), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
        
        return size.height+Height320(70);
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.setting.normalAwards.count == 0 && indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"none"];
        
        return cell;
        
    }else if (indexPath.section == 0){
        
        IntegralSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        IntegralAwardSetting *setting = self.setting.normalAwards[indexPath.row];
        
        cell.title = [NSString stringWithFormat:@"奖励规则%ld",(long)setting.settingId];
        
        NSString *content;
        
        NSMutableArray *contentArray = [NSMutableArray array];
        
        [contentArray addObject:[NSString stringWithFormat:@"有效期        %@至%@",setting.start,setting.end]];
        
        if (setting.groupItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"团课预约    %@倍",[NSString formatStringWithFloat:setting.groupItem.times]]];
            
        }
        
        if (setting.privateItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"私教预约    %@倍",[NSString formatStringWithFloat:setting.privateItem.times]]];
            
        }
        
        if (setting.checkinItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"签到积分    %@倍",[NSString formatStringWithFloat:setting.checkinItem.times]]];
            
        }
        
        if (setting.chargeItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"新购会员卡    %@倍",[NSString formatStringWithFloat:setting.chargeItem.times]]];
            
        }
        
        if (setting.rechargeItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"会员卡续费    %@倍",[NSString formatStringWithFloat:setting.rechargeItem.times]]];
            
        }
        
        content = [contentArray componentsJoinedByString:@"\n"];
        
        cell.content = content;
        
        cell.isActive = YES;
        
        return cell;
        
    }else{
        
        IntegralSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        IntegralAwardSetting *setting = self.setting.expireAwards[indexPath.row];
        
        cell.title = [NSString stringWithFormat:@"奖励规则%ld",(long)setting.settingId];
        
        NSString *content;
        
        NSMutableArray *contentArray = [NSMutableArray array];
        
        [contentArray addObject:[NSString stringWithFormat:@"有效期        %@至%@",setting.start,setting.end]];
        
        if (setting.groupItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"团课预约    %@倍",[NSString formatStringWithFloat:setting.groupItem.times]]];
            
        }
        
        if (setting.privateItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"私教预约    %@倍",[NSString formatStringWithFloat:setting.privateItem.times]]];
            
        }
        
        if (setting.checkinItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"签到积分    %@倍",[NSString formatStringWithFloat:setting.checkinItem.times]]];
            
        }
        
        if (setting.chargeItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"新购会员卡    %@倍",[NSString formatStringWithFloat:setting.chargeItem.times]]];
            
        }
        
        if (setting.rechargeItem.used) {
            
            [contentArray addObject:[NSString stringWithFormat:@"会员卡续费    %@倍",[NSString formatStringWithFloat:setting.rechargeItem.times]]];
            
        }
        
        content = [contentArray componentsJoinedByString:@"\n"];
        
        cell.content = content;
        
        cell.isActive = NO;
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([PermissionInfo sharedInfo].permissions.integralPermisson.editState) {
        
        IntegralAwardSetting *setting;
        
        if (indexPath.section == 0) {
            
            if (!self.setting.normalAwards.count) {
                
                return;
                
            }else{
                
                setting = self.setting.normalAwards[indexPath.row];
                
            }
            
        }else{
            
            setting = self.setting.expireAwards[indexPath.row];
            
        }
        
        IntegralAwardController *svc = [[IntegralAwardController alloc]init];
        
        svc.setting = [setting copy];
        
        svc.allSetting = self.setting;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [hud showAnimated:YES];
    
    self.switchCell.userInteractionEnabled = NO;
    
    IntegralSettingInfo *info = [[IntegralSettingInfo alloc]init];
    
    [info changeUsed:cell.on result:^(BOOL success, NSString *error) {
        
        hud.mode = MBProgressHUDModeText;
        
        self.switchCell.userInteractionEnabled = YES;
        
        if (success) {
            
            hud.label.text = @"修改成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            self.setting.used = cell.on;
            
            if (!self.setting.used) {
                
                [self popViewControllerAndReloadData];
                
            }else{
                
                [self createData];

                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[IntegralListController class]]) {
                        
                        [vc reloadData];
                        
                    }
                    
                }
                
            }
            
        }else{
            
            hud.label.text = error;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


@end
