//
//  IKNetworkManager.h
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求数据接口
typedef void(^IKRequestDictData)(NSDictionary *dict,BOOL success);

typedef void(^IKRequestArrayData)(NSArray *dataArray,BOOL success);


//
typedef void(^IKGetCacheData)(NSDictionary *data,BOOL success);

typedef void(^IKGetDataFailed)(NSInteger errorCode,NSString *errorMessage);


@interface IKNetworkManager : NSObject

+(instancetype)shareInstance;


- (void)getHomePageLoopPlayImageData:(IKRequestDictData)requestData;

- (void)getHomePageJobInfoDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)requestData;

- (void)getHomePageHotCityDataWithBackData:(IKRequestArrayData)requestData;


- (void)getHomePageProvinceCityDataWithBackData:(IKRequestArrayData)requestData;


- (void)getHomePageWorkListDataWithBackData:(IKRequestArrayData)requestData;

@end
