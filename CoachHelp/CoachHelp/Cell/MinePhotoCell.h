//
//  MinePhotoCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinePhotoCell : UICollectionViewCell

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,assign)BOOL editing;

@property(nonatomic,assign)BOOL choosed;

@end
