//
//  CountryChooseTextField.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/11/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CountryChooseTextField.h"

@interface CountryChooseTextField ()<QCTextFieldDelegate,CountryPhoneViewDelegate>

@property(nonatomic,strong)CountryPhoneView *countryView;

@end

@implementation CountryChooseTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.leftChoose = YES;
        
        self.qcdelegate = self;
        
        self.country = [[CountryPhoneInfo sharedInfo].countries firstObject];
        
    }
    
    return self;
    
}

-(void)setCountry:(CountryPhone *)country
{
    
    _country = country;
    
    self.countryView.country = _country;
    
    self.placeholder = [_country description];
    
}

-(void)QCTextFieldLeftClick:(QCTextField *)textfield
{
    
    UIView *view = self;
    
    do {
        
        view = view.superview;
        
    } while (view.superview);
    
    if (!self.countryView) {
        
        self.countryView = [[CountryPhoneView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        self.countryView.delegate = self;
        
        if (self.country) {
            
            self.countryView.country = self.country;
            
        }
        
        [view addSubview:self.countryView];
        
    }
    
    [view endEditing:YES];
    
    [self.countryView show];
    
}

-(void)chooseCountry:(CountryPhone *)country
{
    
    self.country = country;
    
}

@end


@interface CountryPhoneCell ()

{
    
    UILabel *_titleLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation CountryPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(50), Height320(48))];
        
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        
        _titleLabel.font = AllFont(16);
        
        [self.contentView addSubview:_titleLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(29), Height320(14), Width320(13), Height320(10))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        _chooseImg.contentMode = UIViewContentModeScaleAspectFit;
        
        _chooseImg.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_chooseImg];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !_choosed;
    
    _titleLabel.textColor = _choosed?kMainColor:UIColorFromRGB(0x666666);
    
}

@end

@implementation CountryPhone

-(NSString *)description
{
    
    return [NSString stringWithFormat:@"%@ %@",self.name,self.countryNo];
    
}

@end

@implementation CountryPhoneInfo

+(instancetype)sharedInfo
{
    
    static CountryPhoneInfo *info;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        info = [[self alloc]init];
        
    });
    
    return info;
    
}

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        CountryPhone *china = [[CountryPhone alloc]init];
        
        china.name = @"中国";
        
        china.countryNo = @"+86";
        
        [array addObject:china];
        
        CountryPhone *taiwan = [[CountryPhone alloc]init];
        
        taiwan.name = @"中国台湾";
        
        taiwan.countryNo = @"+886";
        
        [array addObject:taiwan];
        
        self.countries = [array copy];
        
    }
    
    return self;
    
}

-(CountryPhone *)getCountryWithCode:(NSString *)code
{
    
    CountryPhone *country = nil;
    
    for (CountryPhone *tempCountry in self.countries) {
        
        if ([tempCountry.countryNo isEqualToString:code]) {
            
            country.name = tempCountry.name;
            
            country.countryNo = tempCountry.countryNo;
            
            break;
            
        }
        
    }
    
    return country;
    
}

@end

static NSString *identifier = @"Cell";

@interface CountryPhoneView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation CountryPhoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.hidden = YES;
        
        UIView *backView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
        
        [self addSubview:backView];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MSH, MSW,[CountryPhoneInfo sharedInfo].countries.count*Height320(48))];
        
        self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView registerClass:[CountryPhoneCell class] forCellReuseIdentifier:identifier];
        
        self.tableView.tableFooterView = [UIView new];
        
        [self addSubview:self.tableView];
        
        self.country = [[CountryPhoneInfo sharedInfo].countries firstObject];
        
    }
    
    return self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [CountryPhoneInfo sharedInfo].countries.count;
    
}

-(void)setCountry:(CountryPhone *)country
{
    
    _country = country;
    
    [self.tableView reloadData];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CountryPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CountryPhone *country = [CountryPhoneInfo sharedInfo].countries[indexPath.row];
    
    cell.title = [NSString stringWithFormat:@"%@ %@",country.name,country.countryNo];
    
    cell.choosed = [self.country.countryNo isEqualToString:country.countryNo];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(48);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CountryPhone *country = [CountryPhoneInfo sharedInfo].countries[indexPath.row];
    
    self.country = country;
    
    [self.delegate chooseCountry:country];
    
    [self close];
    
}

-(void)show
{
    
    [self.superview bringSubviewToFront:self];
    
    self.hidden = NO;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.tableView changeTop:MSH-self.tableView.height];
        
    }];
    
}

-(void)close
{
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.tableView changeTop:MSH];
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        
    }];
    
}

@end
