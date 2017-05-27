//
//  AddressBookController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/29.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AddressBookController.h"

#import <AddressBook/AddressBook.h>

#import "AddressBookCell.h"

#import "POAPinyin.h"

#import "pinyin.h"

#import "Student.h"

static NSString *identifier = @"Cell";

@interface AllButton : UIButton

{
    
    UIImageView *_selectImg;
    
}

@end

@implementation AllButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(14.2), Width320(14.2), Height320(14.2))];
        
        _selectImg.layer.cornerRadius = _selectImg.width/2;
        
        _selectImg.layer.masksToBounds = YES;
        
        _selectImg.layer.borderWidth = 1;
        
        _selectImg.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        [self addSubview:_selectImg];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_selectImg.right+Width320(5.3), 0, self.width-Width320(5.3)-_selectImg.right, self.height)];
        
        label.text = @"全选";
        
        label.textColor = UIColorFromRGB(0x666666);
        
        label.font = STFont(14);
        
        [self addSubview:label];
        
    }
    
    return self;
    
}

-(void)setSelected:(BOOL)selected
{
    
    [super setSelected:selected];
    
    if (selected) {
        
        _selectImg.layer.borderWidth = 0;
        
        _selectImg.image = [UIImage imageNamed:@"selected"];
        
    }else
    {
        
        _selectImg.layer.borderWidth = 1;
        
        _selectImg.image = nil;
        
    }
    
}

@end

@interface AddressBookController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *addressArray;

@property(nonatomic,strong)NSMutableArray *uploadArray;

@property(nonatomic,strong)NSMutableArray *indexPathArray;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,assign)NSInteger allNum;

@property(nonatomic,strong)AllButton *allBtn;

@property(nonatomic,strong)UILabel *label;

@end

@implementation AddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.addressArray = [NSMutableArray array];
    
    self.indexPathArray = [NSMutableArray array];
    
    NSMutableArray *headArray = [NSMutableArray array];
    
    NSArray *array  = [self getAddressBook];
    
    [array enumerateObjectsUsingBlock:^(Student *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![headArray containsObject:obj.head]) {
            
            [headArray addObject:obj.head];
            
        }
        
    }];
    
    [headArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *temp = [NSMutableArray array];
        
        for (Student *stu in array) {
            
            if ([stu.head isEqualToString:obj]) {
                
                [temp addObject:stu];
                
            }
            
        }
        
        [self.addressArray addObject:@{@"section":obj,@"data":temp}];
        
    }];
    
    self.allNum = 0;
    
    for (NSInteger i = 0; i<self.addressArray.count; i++) {
        
        self.allNum += [self.addressArray[i][@"data"] count];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"导入通讯录";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(42.7)) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.allowsSelection = YES;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(110), 0, 0);
    
    [self.tableView registerClass:[AddressBookCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.bottom, MSW, MSH-self.tableView.bottom)];
    
    bottomView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:bottomView];
    
    self.allBtn = [[AllButton alloc]initWithFrame:CGRectMake(0, 0, Width320(71), bottomView.height)];
    
    [self.allBtn addTarget:self action:@selector(allSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:self.allBtn];
    
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    uploadBtn.frame = CGRectMake(MSW-Width320(49.3), 0, Width320(49.3), bottomView.height);
    
    [uploadBtn setTitle:@"导入" forState:UIControlStateNormal];
    
    [uploadBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    
    uploadBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [uploadBtn addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:uploadBtn];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(self.allBtn.right, 0, MSW-self.allBtn.right*2, bottomView.height)];
    
    self.label.textColor = UIColorFromRGB(0x666666);
    
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label.font = STFont(14);
    
    [bottomView addSubview:self.label];
    
    [self setLabelText];
    
}

-(void)setLabelText
{
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已选择%ld/%ld人",(unsigned long)self.indexPathArray.count,(long)self.allNum]];
    
    NSString *str = [NSString stringWithFormat:@"%ld",(unsigned long)(long)self.indexPathArray.count];
    
    [astr addAttribute:NSForegroundColorAttributeName value:kMainColor range:NSMakeRange(3, str.length)];
    
    self.label.attributedText = astr;
    
}

-(void)allSelected:(UIButton*)btn
{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        [self.indexPathArray removeAllObjects];
        
        for (NSInteger i = 0; i<[self.tableView numberOfSections]; i++) {
            
            for (NSInteger j = 0; j<[self.tableView numberOfRowsInSection:i]; j++) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                
                [self.indexPathArray addObject:indexPath];
                
            }
            
        }
        
    }else
    {
        
        [self.indexPathArray removeAllObjects];
        
    }
    
    [self setLabelText];
    
    [self.tableView reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.addressArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.addressArray[section][@"data"] count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Student *stu = self.addressArray[indexPath.section][@"data"][indexPath.row];
    
    cell.phone = stu.phone;
    
    cell.name = stu.name;
    
    if ([self.indexPathArray containsObject:indexPath]) {
        
        cell.select = YES;
        
    }else
    {
        
        cell.select = NO;
        
    }
    
    return cell;
    
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    [self.addressArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:obj[@"section"]];
        
    }];
    
    return array;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(71);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(24.8);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(24.8))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(29.3), 0, Width320(200), header.height)];
    
    label.text = [self.addressArray[section] valueForKey:@"section"];
    
    label.textColor = UIColorFromRGB(0xFF5252);
    
    label.font = STFont(17);
    
    [header addSubview:label];
    
    return header;
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSArray *)getAddressBook
{
    
    __block BOOL accessGranted = NO;
  
    NSMutableArray *array = [NSMutableArray array];
    
    ABAddressBookRef addressBook = nil;
    
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
        
        accessGranted = granted;
        
        dispatch_semaphore_signal(sema);
        
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (!accessGranted) {
        
        [[[UIAlertView alloc]initWithTitle:@"请在iPhone的“设置-隐私-通讯录”选项中，允许健身教练助手访问你的通讯录。" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return nil;
        
    }
    
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    long peopleCount = CFArrayGetCount(results);
    
    for (int i=0; i<peopleCount; i++)
    {
        ABRecordRef record = CFArrayGetValueAtIndex(results, i);
        
        CFTypeRef tmp = NULL;
        //firstName
        tmp = ABRecordCopyValue(record, kABPersonFirstNameProperty);
       
        CFStringRef  fullName=ABRecordCopyCompositeName(record);
        NSString *personname = (__bridge NSString *)fullName;
        char first=pinyinFirstLetter([personname characterAtIndex:0]);
        NSString *sectionName;
        if ((first>='a'&&first<='z')||(first>='A'&&first<='Z')) {
            if([self searchResult:personname searchText:@"曾"])
                sectionName = @"Z";
            else if([self searchResult:personname searchText:@"解"])
                sectionName = @"X";
            else if([self searchResult:personname searchText:@"仇"])
                sectionName = @"Q";
            else if([self searchResult:personname searchText:@"朴"])
                sectionName = @"P";
            else if([self searchResult:personname searchText:@"查"])
                sectionName = @"Z";
            else if([self searchResult:personname searchText:@"能"])
                sectionName = @"N";
            else if([self searchResult:personname searchText:@"乐"])
                sectionName = @"Y";
            else if([self searchResult:personname searchText:@"单"])
                sectionName = @"S";
            else
                sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([personname characterAtIndex:0])] uppercaseString];
        }
        else {
            sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
        }
        
        ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
        long phoneCount = ABMultiValueGetCount(phones);
        if (phoneCount) {
            
            for (NSInteger i = 0; i<phoneCount; i++) {
                
                // phone number
                CFStringRef number = ABMultiValueCopyValueAtIndex(phones, 0);
                
                if (number)CFRelease(number);
                
                if (number&&fullName) {
                    
                    NSString *phoneNumber = (__bridge NSString*)number;
                    
                    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
                    
                    Student *stu = [[Student alloc]init];
                    
                    stu.name = (__bridge NSString *)fullName;
                    
                    stu.phone = phoneNumber;
                    
                    stu.head = sectionName;
                    
                    [array addObject:stu];
                    
                }

            }
            
        }
        if (phones) CFRelease(phones);
        record = NULL;
    }
    if (results)CFRelease(results);
    results = nil;if (addressBook)CFRelease(addressBook);
    addressBook = NULL;
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"head" ascending:YES];
    
    array = [[array sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]]mutableCopy];
    
    return [array copy];
    
}

-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT{
    NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch
                                               range:NSMakeRange(0, searchT.length)];
    if (result == NSOrderedSame)
        return YES;
    else
        return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.indexPathArray containsObject:indexPath]) {
        
        [self.indexPathArray removeObject:indexPath];
        
    }else
    {
        
        [self.indexPathArray addObject:indexPath];
        
    }
    
    if (self.indexPathArray.count == self.allNum) {
        
        self.allBtn.selected = YES;
        
    }else
    {
        
        self.allBtn.selected = NO;
        
    }
    
    [self setLabelText];
    
    [self.tableView reloadData];
    
}

-(void)upload:(UIButton*)btn
{
    
    if (!self.indexPathArray.count) {
        
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"尚未选择任何联系人，无法导入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }else
    {
        
        self.uploadArray = [NSMutableArray array];
        
        for (NSIndexPath *indexPath in self.indexPathArray) {
            
            Student *stu = self.addressArray[indexPath.section][@"data"][indexPath.row];
            
            [self.uploadArray addObject:@{@"username":stu.name,@"phone":stu.phone,@"gender":@"0"}];
            
        }
        
        self.hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        [self.view addSubview:self.hud];
        
        self.hud.label.text = @"上传中";
        
        [self.hud showAnimated:YES];
        
        NSString *api = [NSString stringWithFormat:@"/api/v1/coaches/%ld/students/add/",CoachId];
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:self.uploadArray forKey:@"users"];
        
        if (AppGym.type.length &&AppGym.gymId) {
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
            
            [para setParameter:AppGym.type forKey:@"model"];
            
        }else if(AppGym.shopId && AppGym.brand.brandId){
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
            
            [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
            
        }
        
        [MOAFHelp AFPostHost:ROOT bindPath:api postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]== 200) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"上传成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else
            {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"上传失败";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"上传失败";
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
        }];

        
    }
    
}

@end
