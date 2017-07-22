//
//  IKNetworkManager.m
//  IamKing
//
//  Created by Luris on 2017/7/11.
//  Copyright © 2017年 Luris. All rights reserved.
//

#import "IKNetworkManager.h"
#import "IKNetworkHelper.h"
#import "IKJobInfoModel.h"


// 轮播图请求 url
#define IKGetLoopPlayUrl (@"http://api.job.king2015.com/Banner/getListByType?type=100")

// 职位列表请求 url
#define IKRecommendListUrl (@"http://api.job.king2015.com/InviteWork/getRecommendList?")





@implementation IKNetworkManager

// 创建静态对象 防止外部访问
static IKNetworkManager *_shareInstance;

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

+(instancetype)shareInstance
{
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _shareInstance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _shareInstance;
}


- (void)getHomePageLoopPlayImageData:(IKRequestDictData)requestData
{
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:IKGetLoopPlayUrl parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;

        if (requestData) {
            NSDictionary *dict = [self dealHomePageLoopPlayImageData:responseCache];
            BOOL success = [self requestDataSuccess:responseCache];
            requestData(dict,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {
            NSDictionary *dict = [self dealHomePageLoopPlayImageData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            if (requestData) {
                requestData(dict,success);
            }
        }
    } failure:^(NSError *error) {
    
    }];
}

- (NSDictionary *)dealHomePageLoopPlayImageData:(id)data
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSArray *dataArray = [[data objectForKey:@"data"] objectForKey:@"100"];
        
        NSMutableArray *imageUrlArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < dataArray.count; i++ ) {
            NSDictionary *dic = [dataArray objectAtIndex:i];
            [imageUrlArr addObject:[dic objectForKey:@"image_url"]];
        }
        
        [dict setObject:imageUrlArr forKey:@"imageUrlArray"];
        [dict setObject:[data objectForKey:@"err"] forKey:@"errorCode"];
        [dict setObject:[data objectForKey:@"errmsg"] forKey:@"errorMessage"];

    }

    return dict;
}


- (void)getHomePageJobInfoDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)requestData
{
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&pageSize=%@&type=%@",IKRecommendListUrl,[param objectForKey:@"cityId"],[param objectForKey:@"pageSize"],[param objectForKey:@"type"]];
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        
        dataResult = responseCache;
        NSArray *arr = [self dealHomePageJobInfoData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        if (requestData) {
            requestData(arr,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {
            NSArray *arr = [self dealHomePageJobInfoData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (requestData) {
                requestData(arr,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealHomePageJobInfoData:(id)data
{
    NSArray *array = [data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    
    NSMutableArray *backArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i ++) {
        IKJobInfoModel *model = [[IKJobInfoModel alloc] init];
        
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        
        model.address = [dict objectForKey:@"city_name"];
        model.education = [dict objectForKey:@"education_name"];
        model.salary = [dict objectForKey:@"salary_name"];
        model.experience = [dict objectForKey:@"work_experience_name"];
        model.title = [dict objectForKey:@"work_name"];
        model.jobID = [dict objectForKey:@"id"];
        NSDictionary *userDict = (NSDictionary *)[dict objectForKey:@"userCompany"];
        model.logoImageUrl = [userDict objectForKey:@"headerImage"];
        model.introduce = [userDict objectForKey:@"brand_describe"];
        model.isAuthen = [[userDict objectForKey:@"is_approve_offcial"] boolValue];
        
        NSArray *tagsArr = (NSArray *)[dict objectForKey:@"tagList"];
        
        if (tagsArr.count == 1) {
            model.skill1 = [tagsArr.firstObject objectForKey:@"name"];
        }
        else if(tagsArr.count == 2){
            model.skill2 = [tagsArr[1] objectForKey:@"name"];
        }
        else if(tagsArr.count == 3){
            model.skill3 = [tagsArr[2] objectForKey:@"name"];
        }
        
        [backArray addObject:model];
    }
    
    
    return backArray;
}


// 判断请求的数据是否正确,0 代表正确
- (BOOL)requestDataSuccess:(id)data
{
    NSString *errCode = [NSString stringWithFormat:@"%@",[data objectForKey:@"err"]];
    BOOL success = ([errCode integerValue] == 0)?YES:NO;
    return success;
}







@end
