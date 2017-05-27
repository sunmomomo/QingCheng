//
//  IntroCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    contentStyleText,
    contentStyleImg,
}IntroStyle;

typedef enum : NSUInteger {
    moveNoUp,
    moveNoDown,
    moveAll,
    moveNO,
} Movemode;

@protocol IntroDelegate <NSObject>

-(void)up:(UIButton*)btn;

-(void)down:(UIButton*)btn;

-(void)remove:(UIButton*)btn;

@end

@interface IntroCell : UITableViewCell

@property(nonatomic,assign)Movemode movemode;

@property(nonatomic,assign)id<IntroDelegate> delegate;

-(CGFloat)heightForCell;

-(void)setContent:(NSString *)content andStyle:(IntroStyle)style;

@end
