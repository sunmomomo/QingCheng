//
//  CommentToolView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MOToolTextView.h"

@protocol CommentToolViewDelegate <NSObject>

-(void)sendText:(NSString *)text;

-(void)textViewChangeHeight:(float)height;

@end

@interface CommentToolView : UIView

@property(nonatomic,strong)MOToolTextView *textView;

@property(nonatomic,weak)id<CommentToolViewDelegate>delegate;

@end
