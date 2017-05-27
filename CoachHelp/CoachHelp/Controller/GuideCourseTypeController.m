//
//  GuideCourseTypeController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/12/12.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideCourseTypeController.h"

#import "GuideCourseSetController.h"

static NSString *identifier = @"Cell";

@interface GuideCourseTypeCell : UITableViewCell

{
    
    UIImageView *_imageView;
    
    UILabel *_textLabel;
    
}

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSString *title;

@end

@implementation GuideCourseTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(20), Height320(20))];
        
        _imageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imageView];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.right+Width320(10), 0, Width320(100), Height320(44))];
        
        _textLabel.textColor = UIColorFromRGB(0x333333);
        
        _textLabel.font = AllFont(15);
        
        [self.contentView addSubview:_textLabel];
        
    }
    
    return self;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imageView.image = _image;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
}

@end

@interface GuideCourseTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation GuideCourseTypeController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)createData
{
    
    if (!MOAppDelegate.guide.course) {
        
        MOAppDelegate.guide.course = [[Course alloc]init];
        
    }
    
    self.course = MOAppDelegate.guide.course;
    
}

-(void)createUI
{
    
    self.title = @"新建健身房";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *guideImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(16)+64, MSW-Width320(42), Height320(42))];
    
    guideImg.image = [UIImage imageNamed:@"guide_step_2"];
    
    guideImg.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:guideImg];
    
    UILabel *guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, guideImg.bottom+Height320(20), MSW, Height320(17))];
    
    guideLabel.text = @"— 选择课程类型 —";
    
    guideLabel.textColor = UIColorFromRGB(0x999999);
    
    guideLabel.textAlignment = NSTextAlignmentCenter;
    
    guideLabel.font = AllFont(14);
    
    [self.view addSubview:guideLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, guideLabel.bottom+Height320(12), MSW, Height320(44)*2) style:UITableViewStylePlain];
    
    self.tableView.scrollEnabled = NO;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[GuideCourseTypeCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(44);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuideCourseTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.image = [UIImage qingchengImageWithName:indexPath.row == 0?@"agent_group":@"agent_private"];
    
    cell.title = indexPath.row == 0?@"团课":@"私教";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.course.type = indexPath.row;
    
    [self.course.coursePlans removeAllObjects];
    
    GuideCourseSetController *svc = [[GuideCourseSetController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


@end
