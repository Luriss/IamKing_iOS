//
//  IKNetworkHelper.h
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

/**
 判断当前手机设备的网络类型

 NSUInteger 0
 IKNetworkStatusType 网络类型
 
 */
typedef NS_ENUM(NSUInteger, IKNetworkStatusType) {
    IKNetworkStatuseUnknown,        // 未知网络
    IKNetworkStatusNotReachable,    // 无网络
    IKNetworkStatusWWAN,            // 手机网络
    IKNetworkStatusWiFi             // WIFI网络
};


/**
 请求数据类型

 - IKRequestSerializerJSON: JSON 类型
 - IKRequestSerializerHTTP: 二进制格式

 */
typedef NS_ENUM(NSUInteger, IKRequestSerializer) {
    IKRequestSerializerJSON,
    IKRequestSerializerHTTP,
};


/**
 响应数据类型
 */
typedef NS_ENUM(NSUInteger, IKResponseSerializer) {
    IKResponseSerializerJSON,       // JSON格式
    IKResponseSerializerHTTP,       // 二进制格式
};


// 请求成功的Block
typedef void(^IKHttpRequestSuccess)(id responseObject);

// 请求失败的Block
typedef void(^IKHttpRequestFailed)(NSError *error);

// 缓存的Block
typedef void(^IKHttpRequestCache)(id responseCache);

/**
 上传或者下载的进度

 @param progress 进度 completedUnitCount:当前大小 totalUnitCount:总大小
 
 */
typedef void(^IKHttIKrogress)(NSProgress *progress);

// 网络状态的Block
typedef void(^IKNetworkStatus)(IKNetworkStatusType status);





@class AFHTTPSessionManager;

@interface IKNetworkHelper : NSObject


// 有网YES,
+ (BOOL)isNetwork;

// 手机网络:YES
+ (BOOL)isWWANNetwork;

// WiFi网络:YES
+ (BOOL)isWiFiNetwork;

// 取消所有HTTP请求
+ (void)cancelAllRequest;

// 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
+ (void)networkStatusWithBlock:(IKNetworkStatus)networkStatus;

// 取消指定URL的HTTP请求
+ (void)cancelRequestWithURL:(NSString *)URL;

// 开启日志打印 (Debug级别)
+ (void)openLog;

// 关闭日志打印,默认关闭
+ (void)closeLog;


/**
 *  GET请求,不缓存数据
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                           success:(IKHttpRequestSuccess)success
                           failure:(IKHttpRequestFailed)failure;

/**
 *  GET请求,自动缓存数据
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据回调
 *  @param success       请求成功后数据回调
 *  @param failure       请求失败回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                     responseCache:(IKHttpRequestCache)responseCache
                           success:(IKHttpRequestSuccess)success
                           failure:(IKHttpRequestFailed)failure;

/**
 *  POST请求,不缓存数据
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param success      请求成功后数据回调
 *  @param failure      请求失败回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(id)parameters
                            success:(IKHttpRequestSuccess)success
                            failure:(IKHttpRequestFailed)failure;

/**
 *  POST请求,自动缓存数据
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据回调
 *  @param success       请求成功后数据回调
 *  @param failure       请求失败回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(id)parameters
                      responseCache:(IKHttpRequestCache)responseCache
                            success:(IKHttpRequestSuccess)success
                            failure:(IKHttpRequestFailed)failure;

/**
 *  文件上传
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param name         文件对应服务器上的字段
 *  @param filePath     文件本地的沙盒路径
 *  @param progress     上传进度信息
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                                      parameters:(id)parameters
                                            name:(NSString *)name
                                        filePath:(NSString *)filePath
                                        progress:(IKHttIKrogress)progress
                                         success:(IKHttpRequestSuccess)success
                                         failure:(IKHttpRequestFailed)failure;

/**
 *  图片上传  (单/多张)
 *
 *  @param URL          请求地址
 *  @param parameters   请求参数
 *  @param name         图片对应服务器上的字段
 *  @param images       图片数组
 *  @param fileNames    图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale   图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType    图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress     上传进度信息
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                        parameters:(id)parameters
                                              name:(NSString *)name
                                            images:(NSArray<UIImage *> *)images
                                         fileNames:(NSArray<NSString *> *)fileNames
                                        imageScale:(CGFloat)imageScale
                                         imageType:(NSString *)imageType
                                          progress:(IKHttIKrogress)progress
                                           success:(IKHttpRequestSuccess)success
                                           failure:(IKHttpRequestFailed)failure;

/**
 *  文件下载
 *
 *  @param URL          请求地址
 *  @param fileDir      文件存储目录(默认存储目录为Download)
 *  @param progress     文件下载的进度信息
 *  @param success      下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure      下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(IKHttIKrogress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(IKHttpRequestFailed)failure;



#pragma mark - 设置AFHTTPSessionManager相关属性
#pragma mark 注意: 因为全局只有一个AFHTTPSessionManager实例,所以以下设置方式全局生效
/**
 在开发中,如果以下的设置方式不满足项目的需求,就调用此方法获取AFHTTPSessionManager实例进行自定义设置
 (注意: 调用此方法时在要导入AFNetworking.h头文件,否则可能会报找不到AFHTTPSessionManager的❌)
 @param sessionManager AFHTTPSessionManager的实例
 */
+ (void)setAFHTTPSessionManagerProperty:(void(^)(AFHTTPSessionManager *sessionManager))sessionManager;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer IKRequestSerializerJSON(JSON格式),IKRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(IKRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer IKResponseSerializerJSON(JSON格式),IKResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(IKResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/// 设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;




@end
