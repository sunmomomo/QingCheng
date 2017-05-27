//
//  YFStuDetaiRecoHeaderView.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/24.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFThreeLabel.h"

#import "YFButton.h"

@interface YFStuDetaiRecoHeaderView : UIView

@property(nonatomic, strong)YFThreeLabel *outView;
@property(nonatomic, strong)YFThreeLabel *attandanceView;
@property(nonatomic, strong)YFThreeLabel *groupView;
@property(nonatomic, strong)YFThreeLabel *privateView;

@property(nonatomic, strong)YFButton *button;


@end
