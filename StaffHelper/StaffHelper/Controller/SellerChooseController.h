//
//  SellerChooseController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Seller.h"

@interface SellerChooseController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)void(^chooseFinish)(Seller *seller);

@property(nonatomic,strong)Seller *seller;

@end
