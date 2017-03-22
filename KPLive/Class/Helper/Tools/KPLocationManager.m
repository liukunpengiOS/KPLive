//
//  KPLocationManager.m
//  KPLive
//
//  Created by kunpeng on 2017/3/20.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "KPLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface KPLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) LocationBlock locationBlock;
@end

@implementation KPLocationManager

+ (instancetype)shareManager {
    
    static KPLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self configLocationManager];
    }
    return self;
}

- (void)configLocationManager {

    if (!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.distanceFilter = 100;
        _locationManager.delegate = self;
        if (![CLLocationManager locationServicesEnabled]) {
            
            NSLog(@"开启定位服务");
        }else {
            
            [_locationManager requestWhenInUseAuthorization];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations lastObject];
    NSString *longitude = [NSString stringWithFormat:@"%@",@(location.coordinate.longitude)];
    NSString *latitude = [NSString stringWithFormat:@"%@",@(location.coordinate.latitude)];
    self.longitude = longitude;
    self.latitude = latitude;
    self.locationBlock(longitude,latitude);
    [_locationManager stopUpdatingHeading];
}

- (void)getLocation:(LocationBlock)locationBlock {
   
    self.locationBlock = locationBlock;
    [_locationManager startUpdatingLocation];
}

@end
