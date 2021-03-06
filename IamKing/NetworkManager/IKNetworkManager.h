//
//  IKNetworkManager.h
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IKJobDetailModel.h"
#import "IKCompanyDetailHeadModel.h"
#import "IKCompanyAboutUsModel.h"
#import "IKCompanyManagerTeamModel.h"
#import "IKCompanyShopNumModel.h"
#import "IKResumeModel.h"

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



/**
 获取公司列表信息

 @param param 入参
 @param callback 回调
 */
- (void)getCompanyPageCompanyInfoWithParam:(NSDictionary *)param useCache:(BOOL)useCache backData:(IKRequestArrayData)callback;

- (void)getCompanyPageMoreCompanyInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getCompanyPageRecommendCompanyListWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;


- (void)getCompanyPageCompanyInfoDetailWithParam:(NSDictionary *)param backData:(void (^)(IKCompanyDetailHeadModel *detailModel, BOOL success))callback;

- (void)getCompanyPageAboutUsInfoWithParam:(NSDictionary *)param backData:(void (^)(IKCompanyAboutUsModel *model, BOOL success))callback;

- (void)getCompanyPageManagerTeamInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getCompanyPageNeedJobInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getCompanyPageShopNumberInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getCompanyPageShopListInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getSearchPageJobInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getSearchPageCompanyInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;




- (void)getHotCityDataAndProvinceDataFromChahe:(void (^)(NSArray *hotCity,NSArray *province))callback;


- (void)getLoginInfoWithParam:(NSDictionary *)param backData:(void (^)(NSDictionary *dict, BOOL success))callback;

- (void)getLoginInfoWithVerifyCodeParam:(NSDictionary *)param backData:(void (^)(NSDictionary *dict, BOOL success))callback;

- (void)getChangePhoneNumberVerifyCode:(NSDictionary *)param backData:(void (^)(NSString *verifyCode, BOOL success))callback;

- (void)getBlackListDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getAttentionCompanyListDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getCollectionJobListDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getJobProcessDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback;

- (void)getJobMyAppraiseDataWithSendResumeId:(NSString *)resumeId backData:(void (^)(NSDictionary *dict, BOOL success))callback;


- (void)getMyResumeDataWithId:(NSString *)userId backData:(void (^)(IKResumeModel *model, BOOL success))callback;

- (void)getMyResumeSchoolListDataWithType:(NSString *)type backData:(IKRequestArrayData)callback;

/*************** POST *************/

- (void)postUserOprateToServer:(NSDictionary *)param;
- (void)postFeedbackDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback;

- (void)postDeleteBlackListDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback;

- (void)postCancelAttentionListDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback;

- (void)postCancelCollectionListDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback;

- (void)postJobAppraiseDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback;

@end
