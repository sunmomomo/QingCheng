//
//  ManageTopCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTopCell : UICollectionViewCell

@property(nonatomic,assign)BOOL haveTopLine;

@property(nonatomic,assign)BOOL haveRightLine;

@property(nonatomic,copy)NSString *identifier;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)UIImage *image;

@end
