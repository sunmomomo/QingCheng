//
//  GuideAddressController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideAddressController.h"

#import "QCTextField.h"

#import "DistrictInfo.h"

#import "DistrictPickerView.h"

#import "QCKeyboardView.h"

#import <MAMapKit/MAMapKit.h>

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapLocationKit/AMapLocationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface GuideAddressController ()<MAMapViewDelegate,AMapSearchDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)QCTextField *cityTF;

@property(nonatomic,strong)QCTextField *addressTF;

@property(nonatomic,strong)MAMapView *mapView;

@property(nonatomic,strong)AMapLocationManager *locationManager;

@property(nonatomic,strong)AMapSearchAPI *search;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,strong)DistrictPickerView *districtPV;

@end

@implementation GuideAddressController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
    [self getLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getLocation
{
    
    self.locationManager = [[AMapLocationManager alloc]init];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

    self.locationManager.locationTimeout =2;

    self.locationManager.reGeocodeTimeout = 2;
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (!error && regeocode)
        {
            
            self.cityTF.text = [DistrictInfo formatCityName:regeocode.city];
            
            self.districtCode = regeocode.adcode;
            
            [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) animated:YES];
            
        }
        
    }];
    
    self.search = [[AMapSearchAPI alloc]init];
    
    self.search.delegate = self;
    
}

-(void)createData
{
    
    if (!self.gym) {
        
        self.gym = AppGym;
        
    }
    
}

-(void)createUI
{
    
    self.title = @"地址";
    
    self.rightTitle = @"确定";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height(40)*2)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = OnePX;
    
    [self.view addSubview:topView];
    
    self.cityTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width(16), 0, MSW-Width(32), Height(40))];
    
    self.cityTF.placeholder = @"城市";
    
    self.cityTF.type = QCTextFieldTypeCell;
    
    self.cityTF.mustInput = YES;
    
    [topView addSubview:self.cityTF];
    
    self.districtPV = [DistrictPickerView defaultPickerView];
    
    QCKeyboardView *cityKV = [QCKeyboardView defaultKeboardView];
    
    cityKV.keyboard = self.districtPV;
    
    cityKV.tag = 102;
    
    cityKV.delegate = self;
    
    self.cityTF.inputView = cityKV;
    
    self.addressTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.cityTF.left, self.cityTF.bottom, self.cityTF.width, self.cityTF.height)];
    
    self.addressTF.placeholder = @"具体地址";
    
    self.addressTF.noLine = YES;
    
    self.addressTF.textPlaceholder = @"填写具体地址";
    
    [topView addSubview:self.addressTF];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(16), topView.bottom, MSW-Width(32), Height(30))];
    
    hintLabel.text = @"请拖动地图到健身房的正确位置";
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.font = AllFont(11);
    
    [self.view addSubview:hintLabel];
    
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, hintLabel.bottom, MSW, MSH-hintLabel.bottom)];
    
    self.mapView.delegate = self;
    
    self.mapView.mapType = MAMapTypeStandard;
    
    self.mapView.showsScale = NO;
    
    self.mapView.showsCompass = NO;
    
    self.mapView.showsUserLocation = NO;
    
    [self.mapView setZoomLevel:17.5 animated:YES];
    
    [self.view addSubview:self.mapView];
    
    UIView *point1 = [[UIView alloc]initWithFrame:CGRectMake(self.mapView.width/2-Width(9), self.mapView.height/2-Height(9), Width(18), Height(18))];
    
    point1.layer.masksToBounds = YES;
    
    point1.layer.cornerRadius = point1.width/2;
    
    point1.backgroundColor = [UIColorFromRGB(0xEA6161) colorWithAlphaComponent:0.4];
    
    [self.mapView addSubview:point1];
    
    UIView *point2 = [[UIView alloc]initWithFrame:CGRectMake(self.mapView.width/2-Width(4), self.mapView.height/2-Height(4), Width(8), Height(8))];
    
    point2.layer.masksToBounds = YES;
    
    point2.layer.cornerRadius = point2.width/2;
    
    point2.backgroundColor = UIColorFromRGB(0xffffff) ;
    
    [self.mapView addSubview:point2];
    
    UIView *point3 = [[UIView alloc]initWithFrame:CGRectMake(self.mapView.width/2-Width(3), self.mapView.height/2-Height(3), Width(6), Height(6))];
    
    point3.layer.masksToBounds = YES;
    
    point3.layer.cornerRadius = point3.width/2;
    
    point3.backgroundColor = UIColorFromRGB(0xED4E4E);
    
    [self.mapView addSubview:point3];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.mapView.width/2-Width(12), self.mapView.height/2-Height(32), Width(24), Height(32))];
    
    imageView.image = [UIImage imageNamed:@"mamap_pin"];
    
    [self.mapView addSubview:imageView];
    
}

-(void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
    
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        AMapAddressComponent *component = response.regeocode.addressComponent;
        
        self.cityTF.text = [DistrictInfo formatCityName:component.city.length?component.city:component.province];
        
        self.districtCode = component.adcode;
        
        self.addressTF.text = [NSString stringWithFormat:@"%@%@%@%@",component.district,component.township,component.streetNumber.street,component.streetNumber.number];
        
        self.address = component.city.length?[NSString stringWithFormat:@"%@%@%@",component.province,component.city,self.addressTF.text]:[NSString stringWithFormat:@"%@%@",component.province,self.addressTF.text];
        
        self.lat = [NSString stringWithFormat:@"%f",request.location.latitude];
        
        self.lng = [NSString stringWithFormat:@"%f",request.location.longitude];
    }
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    self.districtCode = _districtPV.districtCode;
    
    self.cityTF.text = [DistrictInfo cityForDistrictCode:_districtPV.districtCode];
    
    [self.cityTF resignFirstResponder];
    
}

-(void)naviRightClick
{
    self.address = [NSString stringWithFormat:@"%@%@",self.cityTF.text,self.addressTF.text];
    
    self.gym.city = self.cityTF.text;
    
    self.gym.districtCode = self.districtCode;
    
    self.gym.address = self.address;
    
    if (self.fillFinish)
    {
        self.fillFinish(self.gym);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [MOAppDelegate saveGuide];
    
}

-(void)dealloc
{
    
    [self.locationManager stopUpdatingLocation];
    
}

@end
