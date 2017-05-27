
#import "YFAutomicRemindVC.h"

#import "YFAutomicRemindCModel.h"

#import "FunctionHintController.h"

#import "YFAutomicRemindShopDataModel.h"

#import "YFModifAutomicRemindVC.h"

@interface YFAutomicRemindVC ()

@property(nonatomic ,strong)YFAutomicRemindShopDataModel *automicRemindShopDataModel;

@end

@implementation YFAutomicRemindVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseTableView.tableHeaderView = [self tableTopHeadView];
    self.title = @"自动提醒";
    self.baseTableView.backgroundColor =  RGB_YF(244, 244, 244);
    self.view.backgroundColor = RGB_YF(244, 244, 244);
    self.baseTableView.scrollEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTableListDataNoPull];
}

-(void)requestData
{
    weakTypesYF
    [self.automicRemindShopDataModel getSuffientShopsSettingStudentshowLoadingOn:nil gym:self.gym successBlock:^{
        [weakS requestSuccessArray:weakS.automicRemindShopDataModel.dataArray];
        weakS.baseTableView.tableFooterView = [weakS tableTopBottomView];
        
    } failBlock:^{
        [weakS failRequest:nil];
    }];
}


- (UIView *)tableTopHeadView
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW,XFrom5To6YF(78.0) + XFrom5To6YF(46.0))];
    
    header.backgroundColor = RGB_YF(244, 244, 244);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12.0, XFrom5To6YF(12.0), header.width - 24, header.height - XFrom5To6YF(12.0) * 2 - XFrom5To6YF(46.0))];
    
    label.textColor = RGB_YF(153, 153, 153);
    
    label.font = FontSizeFY(XFrom5To6YF(12));
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.numberOfLines = 0;
    
    label.backgroundColor = [UIColor clearColor];
    
    [header addSubview:label];
    
    label.text = @"设置好提醒条件后，系统将：\n1. 自动发送提醒短信给会员卡余额不足的会员\n2. APP发送系统通知提醒该会员的销售";
    
    UILabel *labelBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom + XFrom5To6YF(12.0), header.width, XFrom5To6YF(46.0))];
    
    labelBottom.textColor = RGB_YF(51, 51, 51);
    
    labelBottom.font = FontSizeFY(XFrom5To6YF(14));
    
    labelBottom.layer.borderColor = YFLineViewColor.CGColor;
    labelBottom.layer.borderWidth = OnePX;
    
    labelBottom.textAlignment = NSTextAlignmentCenter;
    
    labelBottom.backgroundColor = [UIColor whiteColor];
    
    [header addSubview:labelBottom];
    
    labelBottom.text = @"－当前自动提醒设置－";
    
    return header;
}

- (UIView *)tableTopBottomView
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, XFrom5To6YF(40) + 32)];
    
    header.backgroundColor = RGB_YF(244, 244, 244);
    
    [header addSubview:[self setButton]];
    
    return header;
}

- (UIButton *)setButton
{
    CGFloat buttonWidth = MSW - 32;
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    setButton.frame = CGRectMake(16, 16 , buttonWidth, XFrom5To6YF(40));
    [setButton setTitle:@"修改设置" forState:UIControlStateNormal];
    [setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setButton.titleLabel setFont:FontSizeFY(XFrom5To6YF(14))];
    setButton.backgroundColor = RGB_YF(13, 177, 75.0);
    [setButton addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return setButton;
}

- (void)setButtonAction:(UIButton *)button
{
    if ([PermissionInfo sharedInfo].permissions.cardbalancePermission.editState) {
        
        YFModifAutomicRemindVC *modifyVC = [[YFModifAutomicRemindVC alloc] init];
        
        modifyVC.gym = self.gym;
        
        modifyVC.automicRemindShopDataModel = self.automicRemindShopDataModel;
        
        [self.navigationController pushViewController:modifyVC animated:YES];
    }else{
        [self showNoPermissionAlert];
    }
}

- (YFAutomicRemindShopDataModel *)automicRemindShopDataModel
{
    if (_automicRemindShopDataModel == nil)
    {
        _automicRemindShopDataModel = [[YFAutomicRemindShopDataModel alloc] init];
    }
    return _automicRemindShopDataModel;
}

- (void)reloadNetDataYF
{
    [self refreshTableListDataNoPull];
}


@end
