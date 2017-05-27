//
//  ChooseMemberGroupHeader.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ChooseMemberGroupHeaderChooseTypeAll,
    ChooseMemberGroupHeaderChooseTypePart,
    ChooseMemberGroupHeaderChooseTypeNone,
} ChooseMemberGroupHeaderChooseType;

@protocol ChooseMemberGroupHeaderDelegate;

@interface ChooseMemberGroupHeader : UIView

@property(nonatomic,assign)ChooseMemberGroupHeaderChooseType type;

@property(nonatomic,assign)BOOL showing;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL noTopLine;

@property(nonatomic,weak)id<ChooseMemberGroupHeaderDelegate> delegate;

@end

@protocol ChooseMemberGroupHeaderDelegate <NSObject>

@optional

-(void)groupHeaderChoosed:(ChooseMemberGroupHeader*)header;

-(void)groupHeaderShow:(ChooseMemberGroupHeader*)header;

@end
