//
//  YFAddOriginCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFAddOriginCModel.h"
#import "YFAddOriginCell.h"
#import "YFAddOriginVC.h"
#import "YFHttpService.h"
#import "YFStudnetOriginVC.h"
#import "YFRespoDataOriginArrayModel.h"
#import "YFStudentFilterOriginModel.h"
#import "YFAppService.h"
#import "YFBaseVC.h"

#define AddOrigin @"/api/v2/staffs/%@/users/origins/"

static NSString *yFAddOriginCell = @"YFAddOriginCell";

@implementation YFAddOriginCModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFAddOriginCell;
        self.cellClass = [YFAddOriginCell class];
        self.cellHeight = 39.0;
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YFAddOriginVC *addTextVC = [[YFAddOriginVC alloc] init];
    addTextVC.title = @"添加新来源";
    
    addTextVC.placeHolderText = @"请输入来源";
    weakTypesYF
    __weak typeof(addTextVC)weakTextVC = addTextVC;
    [addTextVC setSelelctBlock:^(NSString *remarkStr) {
        [weakS addNewRemarkStr:remarkStr loadViewC:weakTextVC];
    }];
    [self.weakCell.currentVC.navigationController pushViewController:addTextVC animated:YES];
}

-(void)addNewRemarkStr:(NSString *)str loadViewC:(YFAddOriginVC *)loadViewC
{
 
    YFStudnetOriginVC *originVC = (YFStudnetOriginVC *)self.weakCell.currentVC;
    
    Parameters *para = [self froGym:originVC.gym];
    
    [para setParameter:str forKey:@"name"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:AddOrigin,@(StaffId)]];

    
    __weak typeof(loadViewC)weakLoadVC = loadViewC;
    __weak typeof(originVC)weakOriginVC = originVC;
    [[YFHttpService instance] POST:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataOriginArrayModel class] modelClass:nil showLoadingOnView:loadViewC.view success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        YFRespoDataOriginArrayModel *dataArrayModel =(YFRespoDataOriginArrayModel *)reModel.dataModel;
        
        if (reModel.isSuccess)
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddOriginIdtifierYF object:nil];
            NSDictionary *originDic = dataArrayModel.dic[@"origin"];
            
            YFStudentFilterOriginModel *model = [YFStudentFilterOriginModel defaultWithDic:originDic];
          
            [((YFBaseVC *)weakLoadVC) showHint:@"添加成功"];
            
            //            [weakLoadVC.baseDataArray insertObject:model atIndex:1];
            
            //            [weakLoadVC.baseTableView reloadData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakOriginVC.selectModel = model;

            });
            

        }else
        {
            
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
       
        [YFAppService showAlertMessageWithError:error];
    }];
    

    
    
}

-(Parameters *)froGym:(Gym *)gym
{
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setInteger:1 forKey:@"show_all"];
    
    return para;
}



@end
