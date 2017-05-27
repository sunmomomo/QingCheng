//
//  YFCardStudentVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardStudentVC.h"

#import "YFCardDataModel.h"

#import "CardChooseStudentController.h"

#import "CardChooseGymController.h"

#import "YFEmptyView.h"

@interface YFCardStudentVC ()

@property(nonatomic, strong)UIView *tableFootView;

@property(nonatomic, strong)UILabel *tableFootLabel;

@property(nonatomic, strong)YFCardDataModel *dataModel;

@end


@implementation YFCardStudentVC
{
    YFEmptyView *_emptyViewYF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定会员";
    self.rightTitle = @"修改";
    self.rightColor = YFSelectedButtonColor;
    [self.baseTableView setTableFooterView:self.tableFootView];
    [self refreshTableListDataNoPull];
    
    self.baseTableView.backgroundColor = YFGrayViewColor;
    self.canGetMore = NO;
}

- (void)requestData
{
    weakTypesYF
    [self.dataModel getBindCardStudentshowLoadingOn:nil gym:self.gym card_id:[NSString stringWithFormat:@"%ld",(long)self.card.cardId] successBlock:^{
        [weakS requestSuccessArray:weakS.dataModel.bindCardStuArray];
    } failBlock:^{
        
    }];
}

-(UIView *)tableFootView
{
    if (!_tableFootView)
    {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 44)];
        _tableFootView.backgroundColor = YFGrayViewColor;
        CGFloat labelWidth = 90;
        _tableFootLabel = [[UILabel alloc] initWithFrame:CGRectMake((_tableFootView.width - labelWidth) / 2.0, 0, labelWidth, 44)];
        
        _tableFootLabel.backgroundColor = YFGrayViewColor;
        _tableFootLabel.textColor = RGB_YF(153, 153, 153);
        _tableFootLabel.font = FontSizeFY(12.0);
        _tableFootLabel.textAlignment = NSTextAlignmentCenter;
        _tableFootLabel.text = @"仅显示名下会员";
        [_tableFootView addSubview:_tableFootLabel];
        
        CGFloat lineViewWidth = 0.25 * _tableFootView.width;;
        CGFloat lineViewxx1 = _tableFootLabel.left - lineViewWidth - 10;
        CGFloat lineViewxx2 = _tableFootLabel.right + 10;
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx1, _tableFootView.height / 2.0, lineViewWidth, 0.5)];
        lineView1.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx2, _tableFootView.center.y, lineViewWidth, 0.5)];
        lineView2.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView2];
        
    }
    
    
//    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone)
//    {
//        NSLog(@"fafasfas");
//    }
//    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateAll)
//    {
//        NSLog(@"3333333");
//
//    }
//    
//    if ([PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState)
//    {
//        NSLog(@"00000000");
//    }
    
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone && [PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState) {
        _tableFootView.hidden = NO;
    }else
    {
     _tableFootView.hidden = YES;
    }

    return _tableFootView;
}

- (YFCardDataModel *)dataModel
{
    if (_dataModel == nil) {
        _dataModel = [[YFCardDataModel alloc] init];
    }
    return _dataModel;
}


- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 64.0, self.baseTableView.width, self.baseTableView.height)];
        
        CGFloat emptyImageWidht = Width320(80);
        
        CGFloat emptyImageYY = Width320(83);
        
        CGFloat emptyImageXX = (_emptyViewYF.width - emptyImageWidht )/ 2.0;
        
        _emptyViewYF.emptyImg.frame = CGRectMake(emptyImageXX, emptyImageYY, emptyImageWidht, emptyImageWidht);
        
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
        
        _emptyViewYF.emptyImg.image = [UIImage imageNamed:@"filterStudentEmpty"];
        
        _emptyViewYF.emptyLabel.textColor = YFCellTitleColor;
        
        _emptyViewYF.emptyLabel.font = AllFont(14);
        
        
        _emptyViewYF.emptyLabel.frame = CGRectMake(_emptyViewYF.emptyLabel.mj_x, _emptyViewYF.emptyImg.bottom + Height320(3.5), _emptyViewYF.emptyLabel.width, _emptyViewYF.emptyLabel.height);
        
        _emptyViewYF.addbutton.hidden = YES;
        
        
        UILabel *emptyMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _emptyViewYF.emptyLabel.bottom - Height320(4), MSW-40, Height320(13))];
        
        emptyMessageLabel.numberOfLines = 0;
        
        emptyMessageLabel.textColor = RGB_YF(153, 153, 153);
        
        emptyMessageLabel.font = AllFont(12);
        
        emptyMessageLabel.textAlignment = NSTextAlignmentCenter;
        
        _emptyViewYF.emptyMessageLabel = emptyMessageLabel;
        
        [_emptyViewYF addSubview:emptyMessageLabel];
        
    }
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone && [PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState) {
        _emptyViewYF.emptyLabel.text = @"未绑定名下会员";
        _emptyViewYF.emptyMessageLabel.text = @"此处仅显示名下会员\n点击右上角的\"修改\"添加绑定会员";
        [_emptyViewYF.emptyMessageLabel changeHeight:Height320(30)];
    }else
    {
        _emptyViewYF.emptyLabel.text = @"未绑定会员";
        _emptyViewYF.emptyMessageLabel.text = @"点击右上角的\"修改\"添加绑定会员";
    }

    return _emptyViewYF;
}


- (void)naviRightClick
{
            if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
    
                if (AppGym) {
    
                    CardChooseStudentController *svc = [[CardChooseStudentController alloc]init];
    
                    svc.isEdit = YES;
    
                    svc.card = self.card;
    
                    svc.gym = AppGym;
    
                    [self.navigationController pushViewController:svc animated:YES];
    
                }else{
    
                    if (self.card.cardKind.gyms.count == 1) {
    
                        CardChooseStudentController *svc = [[CardChooseStudentController alloc]init];
    
                        svc.isEdit = YES;
    
                        svc.card = self.card;
    
                        svc.gym = [self.card.cardKind.gyms firstObject];
    
                        [self.navigationController pushViewController:svc animated:YES];
    
                    }else{
    
                        CardChooseGymController *svc = [[CardChooseGymController alloc]init];
    
                        svc.card = self.card;
    
                        [self.navigationController pushViewController:svc animated:YES];
    
                    }
                    
                }
                
            }else{
                
                [self showNoPermissionAlert];
            }

}

@end
