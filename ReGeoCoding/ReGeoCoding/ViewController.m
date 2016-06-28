//
//  ViewController.m
//  ReGeoCoding
//
//  Created by zhangbin on 16/6/28.
//  Copyright © 2016年 zhangbin. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

/** 反地理编码*/
- (IBAction)ReGeoCoding;
/** 经度*/
@property (weak, nonatomic) IBOutlet UITextField *longitude;
/** 纬度*/
@property (weak, nonatomic) IBOutlet UITextField *latitude;// 注:UITextField点击有反应
/** 地址*/
@property (weak, nonatomic) IBOutlet UILabel *Address;// 注:UILabel点击没反应

/** 地理编码对象*/
@property(nonatomic,strong)CLGeocoder *geocoding;
@end

@implementation ViewController
-(CLGeocoder *)geocoding{
    if (_geocoding == nil) {
        _geocoding = [[CLGeocoder alloc] init];
    }
    return _geocoding;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)ReGeoCoding{
    // 1.获取用户输入的经度和纬度
    NSString *longitude = self.longitude.text;
    NSString *latitude = self.latitude.text;
    if (longitude.length == 0 || latitude.length == 0 || longitude == nil|| longitude == nil) {
        NSLog(@"请输入经纬度");
        return;
    }
    
    // 2.根据用户输入的经纬度创建CLLocation的对象
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue] ];
    // 3.3.根据CLLocation的对象获取对应的地标信息
    [self.geocoding  reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count != 0) {// 如果placemarks数组中有元素就执行{}
            
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"%@ %@ %lf %lf",placemark.name,placemark.addressDictionary,placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
            self.Address.text = placemark.locality;
        }
        }else{// 如果placemarks数组汇总没有元素就行
        NSLog(@"您输入的经纬度找不到对应的地区");
        }
    }];
        
   
    
}

@end
