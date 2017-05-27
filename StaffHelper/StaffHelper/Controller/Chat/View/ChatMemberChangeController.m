//
//  ChatMemberChangeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatMemberChangeController.h"

#import "ChatMemberCell.h"

#import "ChatInfo.h"

static NSString *identifier = @"Cell";

@interface ChatMemberChangeController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,ChatMemberCellDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)NSMutableArray *members;

@property(nonatomic,strong)NSMutableArray *deleteArray;

@end

@implementation ChatMemberChangeController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    self.deleteArray = [NSMutableArray array];
    
    ChatInfo *info = [[ChatInfo alloc]init];
    
    [info requestGroupDetailInfoWithModel:self.model result:^(BOOL success, NSString *error) {
        
        self.members = [self.model.group.users mutableCopy];
        
        for (User *user in self.members) {
            
            if (user.userId == UserId) {
                
                [self.members removeObject:user];
                
                break;
                
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self reloadUI];
            
        });
        
    }];
    
}

-(void)reloadUI
{
    
    [self.collectionView reloadData];
    
    NSInteger rows = (ceil((float)self.members.count/5));
    
    [self.collectionView changeHeight:rows*Height(80)+Height(15)+Height(10)];
    
    self.mainView.contentSize = CGSizeMake(0, self.collectionView.height);
    
}

-(void)createUI
{
    
    self.title = @"移出群聊";
    
    self.rightTitle = @"完成";
    
    self.leftTitle = @"取消";
    
    self.leftColor = UIColorFromRGB(0xffffff);
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.mainView];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, MSW, MSH-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.collectionView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.collectionView.layer.borderWidth = OnePX;
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.scrollEnabled = NO;
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[ChatMemberCell class] forCellWithReuseIdentifier:identifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.mainView addSubview:self.collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.members.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(Width(58), Height(80));
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, Width(10), 0, Width(10));
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Width(5);
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Width(15);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height(10));
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height(15));
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        header.backgroundColor = UIColorFromRGB(0xffffff);
        
        return header;
        
    }else{
        
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footer.backgroundColor = UIColorFromRGB(0xffffff);
        
        return footer;
        
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.row <self.members.count) {
        
        User *member = self.members[indexPath.row];
        
        cell.name = member.username;
        
        cell.iconURL = member.iconURL;
        
        cell.tag = indexPath.row;
        
        cell.type = ChatMemberCellTypeNormal;
        
        cell.editing = YES;
        
        cell.delegate = self;
        
    }else{
        
        cell.name = nil;
        
        cell.iconURL = nil;
        
        cell.editing = NO;
        
        cell.delegate = nil;
        
    }
    
    return cell;
    
}

-(void)deleteUserWithCell:(ChatMemberCell *)cell
{
    
    User *member = self.members[cell.tag];
    
    [self.members removeObjectAtIndex:cell.tag];
    
    [self.collectionView reloadData];
    
    [self.deleteArray addObject:member];
    
}

-(void)naviRightClick
{
    
    ChatInfo *info = [[ChatInfo alloc]init];
    
    [info removeUsers:self.deleteArray withModel:self.model result:^(BOOL success, NSString *error) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        hud.mode = MBProgressHUDModeText;
        
        [self.view addSubview:hud];
        
        [hud showAnimated:YES];
        
        if (success) {
            
            hud.label.text = @"移除成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewControllerAndReloadData];
                
            });
            
        }else{
            
            hud.label.text = error;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}


-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
