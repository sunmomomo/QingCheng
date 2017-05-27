//
//  FollowRecordImageCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FollowRecordImageCellDelegate <NSObject>

-(void)ImageCellClick:(NSInteger)tag;

@end

@interface FollowRecordImageCell : UITableViewCell

@property(nonatomic,copy)NSURL *imageUrl;

@property(nonatomic,copy)NSString *follower;

@property(nonatomic,copy)NSURL *iconUrl;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,assign)id<FollowRecordImageCellDelegate> delegate;

@end
