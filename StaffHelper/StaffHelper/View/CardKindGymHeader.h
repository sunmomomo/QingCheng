//
//  CardKindGymHeader.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardKindGymHeaderDelegate <NSObject>

-(void)filterCardKindState;

@end

@interface CardKindGymHeader : UIView

@property(nonatomic,assign)NSInteger count;

@property(nonatomic,assign)CardKindState state;

@property(nonatomic,weak)id<CardKindGymHeaderDelegate>delegate;

@end
