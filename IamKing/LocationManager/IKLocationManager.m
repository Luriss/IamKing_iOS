//
//  IKLocationManager.m
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKLocationManager.h"
#import <CoreLocation/CoreLocation.h>

static IKLocationManager *_shareInstance;

@interface IKLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *laManager;
@property (nonatomic,strong)CLGeocoder *geocoder;
@property (nonatomic,strong)NSString *locationCity;
@property (nonatomic,strong)NSString *locationCityId;

@end
@implementation IKLocationManager


+ (instancetype)shareInstance
{
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_shareInstance == nil) {
            _shareInstance = [super allocWithZone:zone];
        }
    });
    return _shareInstance;
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
- (id)copyWithZone:(NSZone *)zone
{
    return _shareInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _shareInstance;
}


- (CLLocationManager *)laManager
{
    if (_laManager == nil) {
        _laManager = [[CLLocationManager alloc] init];
        _laManager.delegate = self;
        _laManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        if (IOS_SYSTEM_VERSION >= 8.0) {
            [_laManager requestWhenInUseAuthorization];
        }
        
        
        if (IOS_SYSTEM_VERSION >= 9.0) {
            [_laManager setAllowsBackgroundLocationUpdates:YES];
        }
    }
    
    return _laManager;
}


- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    
    return _geocoder;
}

- (void)startLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.laManager startUpdatingLocation];
    }
    else{
        IKLog(@"locationServicesEnabled = NO");
    }
}




- (NSString *)getLocationCity
{
    return _locationCity;
}

- (NSString *)getLocationCityId
{
    return _locationCityId;
}

- (NSString *)getCountry
{
    return nil;
}

- (NSString *)getDistrct
{
    return nil;
}



#pragma mark - CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    IKLog(@"locations = %@",locations);
    
    CLLocation *location = locations.lastObject;
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        IKLog(@"error = %@",error);
        if (placemarks.count > 0) {
            [_laManager stopUpdatingLocation];
            for (CLPlacemark *placemark in placemarks) {
                IKLog(@"addressDictionary = %@",placemark.addressDictionary);
                IKLog(@"addressDictionary = %@",placemark.locality);
                
                NSString *city = placemark.locality;
                
                if ([city hasSuffix:@"市"]) {
                    city = [city substringToIndex:city.length - 1];
                    IKLog(@"addressDictionary = %@",city);
                }
                _locationCity = city;

                NSString *saveCity = [IKUSERDEFAULT objectForKey:@"locationCity"];
                if (![saveCity isEqualToString:city]) {
                    [IKUSERDEFAULT setObject:city forKey:@"locationCity"];
                    [IKUSERDEFAULT synchronize];
                }
                
                [[IKNetworkManager shareInstance] getHomePageCityIDWithCityName:city backData:^(NSString *cityId) {
                    _locationCityId = cityId;
                }];

            }

            [self.laManager stopUpdatingLocation];
        }
        
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    IKLog(@"定位失败 %@",error);
//    [_laManager stopUpdatingLocation];

}
@end
