//
//  TestPictureView.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/4.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestPictureViewDelegate;

@interface TestPictureView : UIButton

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)CGFloat progress;

@property(nonatomic,assign)BOOL canDelete;

@property(nonatomic,assign)id<TestPictureViewDelegate> delegate;

@end

@protocol TestPictureViewDelegate <NSObject>

@optional

-(void)deleteClick:(UIButton*)btn;

-(void)pictureViewClick:(TestPictureView*)pictureView;

@end
