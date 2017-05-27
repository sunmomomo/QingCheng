//
//  FollowRecordToolView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FollowRecordToolViewDelegate <NSObject>

-(void)uploadPictureWithIndex:(NSInteger)index;

-(void)sendText:(NSString *)string;

@end

@interface FollowRecordToolView : UIView

@property(nonatomic,copy)NSString *text;

@property(nonatomic,assign)id<FollowRecordToolViewDelegate> delegate;

@end
