//
//  CardKindHeader.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardKindHeaderDelegate <NSObject>

-(void)filterCardKindType;

-(void)filterCardKindState;

@end

@interface CardKindHeader : UIView

@property(nonatomic,assign)NSInteger count;

@property(nonatomic,assign)CardKindState state;

@property(nonatomic,assign)CardKindType type;

@property(nonatomic,weak)id<CardKindHeaderDelegate>delegate;

@end
