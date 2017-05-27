//
//  IntroView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/11/3.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroViewDelegate <NSObject>

-(void)introViewFinishLoad;

@end

@interface IntroView : UIView

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,assign)id<IntroViewDelegate> delegate;

@end
