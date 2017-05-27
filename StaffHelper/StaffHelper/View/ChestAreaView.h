//
//  ChestAreaView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChestArea.h"

#import "Chest.h"

@protocol ChestAreaViewDelegate <NSObject>

-(void)areaViewChooseChest:(Chest*)chest;

-(void)manageArea;

@end

@interface ChestAreaView : UIView

@property(nonatomic,strong)NSArray *allArray;

@property(nonatomic,strong)Chest *chest;

@property(nonatomic,weak)id<ChestAreaViewDelegate> delegate;

+(instancetype)defaultAreaView;

-(void)close;

@end
