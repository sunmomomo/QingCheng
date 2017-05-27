//
//  CardPayChooseView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Card.h"

@protocol CardPayChooseViewDelegate <NSObject>

-(void)cardPayChooseCard:(Card*)card orPayWay:(PayWay)payWay;

@optional
-(void)buyCard;

@end

@interface CardPayChooseView : UIView

@property(nonatomic,strong)NSArray *cards;

@property(nonatomic,weak)id<CardPayChooseViewDelegate>delegate;
/**
 * 是否 展示 会员卡支付选项，默认 YES
 */
@property(nonatomic, assign)BOOL isShowCardPay;

+(instancetype)defaultView;

-(void)show;

@end
