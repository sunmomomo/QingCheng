//
//  YFStudentFilterSellerCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterSellerCell.h"

#import "YFCollectionViewSellerCell.h"


@interface YFStudentFilterSellerCell ()



@end

@implementation YFStudentFilterSellerCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, self.width, self.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.collectionView];
        
        //        self.baseDataArray = @[@"1",@"2",@"3",@"4",@"5"].mutableCopy;
        
        [self.collectionView reloadData];
        self.collectionView.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame =CGRectMake(20, 0, self.contentView.width - 20, self.contentView.height);
}

@end
