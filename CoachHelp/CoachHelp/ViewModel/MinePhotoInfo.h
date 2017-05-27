//
//  MinePhotoInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MinePhoto : NSObject

@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,assign)NSInteger photoId;

@end

@interface MinePhotoInfo : NSObject

@property(nonatomic,strong)NSArray *photos;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)addPhoto:(NSString*)photoURLString result:(void(^)(BOOL success,NSString *error))result;

-(void)deletePhotos:(NSArray *)photos result:(void(^)(BOOL success,NSString *error))result;

@end
