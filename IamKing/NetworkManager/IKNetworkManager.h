//
//  IKNetworkManager.h
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IKJobDetailModel.h"

// 请求数据接口
typedef void(^IKRequestDictData)(NSDictionary *dict,BOOL success);

typedef void(^IKRequestArrayData)(NSArray *dataArray,BOOL success);


//
typedef void(^IKGetCacheData)(NSDictionary *data,BOOL success);

typedef void(^IKGetDataFailed)(NSInteger errorCode,NSString *errorMessage);


@interface IKNetworkManager : NSObject

+(instancetype)shareInstance;



/**
    获取轮播图图片 url 不调用缓存 不缓存数据

 @param callback  回调数据
 */
- (void)getHomePageLoopPlayImageDataWithoutCache:(IKRequestDictData)callback;


/**
 获取轮播图图片 url 调用缓存 缓存数据
 
 @param callback  回调数据
 */
- (void)getHomePageLoopPlayImageData:(IKRequestDictData)callback;



/**
 获取首页职位信息  不调用缓存数据,不缓存数据

 @param param 入参数组
 @param callback 回调数据
 */
- (void)getHomePageJobInfoDataWithoutCacheParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;


/**
 获取首页职位信息  调用缓存 缓存数据
 
 @param param 入参数组
 @param callback 回调数据
 */
- (void)getHomePageJobInfoDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;



/**
 获取热门城市信息

 @param callback 回调数据
 */
- (void)getHomePageHotCityDataWithBackData:(IKRequestArrayData)callback;



/**
 获取省市信息

 @param callback 回调数据
 */
- (void)getHomePageProvinceCityDataWithBackData:(IKRequestArrayData)callback;



/**
 获取职位类型数据

 @param callback 回调数据
 */
- (void)getHomePageWorkListDataWithBackData:(IKRequestArrayData)callback;


/**
 获取城市 ID, (正常情况是获取定位城市信息)

 @param cityName 城市名
 @param callback 回调数据
 */
- (void)getHomePageCityIDWithCityName:(NSString *)cityName backData:(void(^)(NSString *cityId))callback;


/**
 获取更多首页职位信息  加载跟多

 @param param 参数
 @param callback 回调数据
 */
- (void)getHomePageMoreJobInfoDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;


/**
 获取职位详情

 @param param 入参
 @param callback 回调数据
 */
- (void)getHomePageJobInfoDetailWithParam:(NSDictionary *)param backData:(void(^)(IKJobDetailModel *detailModel,BOOL success))callback;

@end
