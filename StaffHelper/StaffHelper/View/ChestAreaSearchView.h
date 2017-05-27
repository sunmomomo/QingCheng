//
//  ChestAreaSearchView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChestArea.h"

#import "Chest.h"

@protocol ChestAreaSearchViewDelegate <NSObject>

-(void)areaViewChooseChest:(Chest*)chest;

@end

@interface ChestAreaSearchView : UIView

@property(nonatomic,strong)NSArray *allArray;

@property(nonatomic,strong)Chest *chest;

@property(nonatomic,weak)id<ChestAreaSearchViewDelegate> delegate;

+(instancetype)defaultAreaView;

@end
