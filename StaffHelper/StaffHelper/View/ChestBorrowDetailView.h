//
//  ChestBorrowDetailView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Chest.h"

@protocol ChestBorrowDetailViewDelegate;

@interface ChestBorrowDetailView : UIView

@property(nonatomic,weak)id<ChestBorrowDetailViewDelegate> delegate;

@property(nonatomic,strong)Chest *chest;

+(instancetype)defaultView;

-(void)show;

-(void)close;

@end

@protocol ChestBorrowDetailViewDelegate <NSObject>

-(void)returnChest;

@optional

-(void)continueBorrowChest;

@end
