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
#import "IKHotCityModel.h"
#import "IKProvinceModel.h"
#import "IKJobTypeModel.h"
#import "IKCompanyInfoModel.h"


// 轮播图请求 url
#define IKGetLoopPlayUrl (@"http://api.job.king2015.com/Banner/getListByType?type=100")

// 职位列表请求 url
#define IKRecommendListUrl (@"http://api.job.king2015.com/InviteWork/getRecommendList?")

// 热门城市
#define IKHotCityListUrl (@"https://www.iamking.com.cn/index.php/Region/getCityList?provinceId=-1")


// 省市信息
#define IKProvinceCityListUrl (@"https://www.iamking.com.cn/index.php/region/getProvinceCityList")

// 职位类型信息
#define IKWorkListUrl (@"https://www.iamking.com.cn/index.php/Work/getWorkList")


// 获取城市 ID
#define IKGetCityIdUrl (@"https://www.iamking.com.cn/index.php/Region/getCityIdByCityName?")

// 加载更多
#define IKGetMoreJobListUrl (@"https://www.iamking.com.cn/index.php/InviteWork/getList?")

// 搜索工作    cityId=0&companyType=0&page=1&pageSize=8&salaryType=0&str=TABATA&workExperienceType=0
#define IKSearchJobByJobNameUrl (@"https://www.iamking.com.cn/index.php/InviteWork/searchByWorkName?")

// 职位详情
#define IKJobDeatailUrl (@"https://www.iamking.com.cn/index.php/InviteWork/getInfo?")

// 公司信息
#define IKCompanyInfoUrl (@"https://www.iamking.com.cn/index.php/User/getUserCompanyList?")

// 公司详情

#define IKCompanyDetailInfoUrl (@"https://www.iamking.com.cn/index.php/Company/getInfo?")

// 关于我们  userCompanyId=330
#define IKCompanyAboutUsUrl (@"https://www.iamking.com.cn/index.php/Company/getAbout?")

// 管理团队
#define IKCompanyManagerTeamUrl (@"https://www.iamking.com.cn/index.php/CompanyManager/getList?")

#define IKCompanyNeedJobUrl (@"https://www.iamking.com.cn/index.php/InviteWork/getListByUserCompanyId?")

// companyType=1&userCompanyId=337
#define IKGetShopListUrl (@"https://www.iamking.com.cn/index.php/ShopList/getList?")

@interface IKNetworkManager ()

@property(nonatomic,strong)NSDateFormatter *dataFormatter;
@end

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


- (NSDateFormatter *)dataFormatter
{
    if (_dataFormatter == nil) {
        _dataFormatter = [[NSDateFormatter alloc] init];
    }
    return _dataFormatter;
}







- (void)getHomePageLoopPlayImageDataWithoutCache:(IKRequestDictData)callback
{
    [IKNetworkHelper GET:IKGetLoopPlayUrl parameters:nil responseCache:nil success:^(id responseObject) {
        NSDictionary *dict = [self dealHomePageLoopPlayImageData:responseObject];
        BOOL success = [self requestDataSuccess:responseObject];
        if (callback) {
            callback(dict,success);
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)getHomePageLoopPlayImageData:(IKRequestDictData)callback
{
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:IKGetLoopPlayUrl parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;

        if (callback) {
            NSDictionary *dict = [self dealHomePageLoopPlayImageData:responseCache];
            BOOL success = [self requestDataSuccess:responseCache];
            callback(dict,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {
            NSDictionary *dict = [self dealHomePageLoopPlayImageData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            if (callback) {
                callback(dict,success);
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


- (void)getHomePageJobInfoDataWithoutCacheParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&pageSize=%@&type=%@",IKRecommendListUrl,[param objectForKey:@"cityId"],[param objectForKey:@"pageSize"],[param objectForKey:@"type"]];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        NSArray *arr = [self dealHomePageJobInfoData:responseObject];
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback(arr,success);
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)getHomePageJobInfoDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&pageSize=%@&type=%@",IKRecommendListUrl,[param objectForKey:@"cityId"],[param objectForKey:@"pageSize"],[param objectForKey:@"type"]];
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        
        dataResult = responseCache;
        NSArray *arr = [self dealHomePageJobInfoData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {
            NSArray *arr = [self dealHomePageJobInfoData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback) {
                callback(arr,success);
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
            model.skill1 = [tagsArr.firstObject objectForKey:@"name"];
            model.skill2 = [tagsArr[1] objectForKey:@"name"];
        }
        else if(tagsArr.count == 3){
            model.skill1 = [tagsArr.firstObject objectForKey:@"name"];
            model.skill2 = [tagsArr[1] objectForKey:@"name"];
            model.skill3 = [tagsArr[2] objectForKey:@"name"];
        }
        
        [backArray addObject:model];
    }
    
    
    return backArray;
}


- (void)getHomePageHotCityDataWithBackData:(IKRequestArrayData)callback
{
    __block id dataResult = nil;

    [IKNetworkHelper GET:IKHotCityListUrl parameters:nil responseCache:^(id responseCache) {
//        NSLog(@"responseCache = %@",responseCache);
        
        dataResult = responseCache;
        NSArray *arr = [self dealHotCityData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        if (callback && arr.count > 0) {
            callback(arr,success);
        }
        
    } success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {
            NSArray *arr = [self dealHotCityData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && arr.count > 0) {
                callback(arr,success);
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealHotCityData:(id)data
{
    NSArray *dataArr = (NSArray *)[data objectForKey:@"data"];
    if (!dataArr || dataArr.count == 0) {
        return nil;
    }
    
    NSMutableArray *reArray = [NSMutableArray arrayWithCapacity:dataArr.count];
    for (int i = 0; i <dataArr.count; i ++ ) {
        NSDictionary *dict = (NSDictionary *)[dataArr objectAtIndex:i];
        
        IKHotCityModel *model = [[IKHotCityModel alloc] init];
        model.regionID = NSStringFormat(@"%@", [dict objectForKey:@"region_id"]);
        model.cityName = [dict objectForKey:@"region_name"];
        
        [reArray addObject:model];
    }
    
    return reArray;
}


- (void)getHomePageProvinceCityDataWithBackData:(IKRequestArrayData)callback
{
    __block id dataResult = nil;

    [IKNetworkHelper GET:IKProvinceCityListUrl parameters:nil responseCache:^(id responseCache) {
//        NSLog(@"responseCache = %@",responseCache);
        dataResult = responseCache;
        NSArray *arr = [self dealProviceCityData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        if (callback && arr.count > 0) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {
            NSArray *arr = [self dealProviceCityData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && arr.count > 0) {
                callback(arr,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (NSArray *)dealProviceCityData:(id)data
{
    NSArray *array = (NSArray *)[data objectForKey:@"data"];
    
    if (array.count == 0) {
        return  nil;
    }
    
    NSMutableArray *reArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *subDict = (NSDictionary *)[array objectAtIndex:i];
        
        IKProvinceModel *model = [[IKProvinceModel alloc] init];
        
        model.provinceName = [subDict objectForKey:@"text"];
        model.provinceID = NSStringFormat(@"%@",[subDict objectForKey:@"value"]);
        model.childCity = (NSArray *)[subDict objectForKey:@"children"];
        [reArray addObject:model];
    }
    return reArray;
}



- (void)getHomePageWorkListDataWithBackData:(IKRequestArrayData)callback
{
    __block id dataResult = nil;

    [IKNetworkHelper GET:IKWorkListUrl parameters:nil responseCache:^(id responseCache) {
//                NSLog(@"responseCache = %@",responseCache);
        dataResult = responseCache;
        NSArray *arr = [self dealWorkListData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        if (callback && arr.count > 0) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
//                NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {
            NSArray *arr = [self dealWorkListData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && arr.count > 0) {
                callback(arr,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealWorkListData:(id)data
{
    NSArray *array = (NSArray *)[data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    
    NSMutableArray *reArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i ++) {
        IKJobTypeModel *model = [[IKJobTypeModel alloc] init];
        
        NSDictionary *subDict = (NSDictionary *)[array objectAtIndex:i];
        model.describe = [subDict objectForKey:@"describe"];
        model.JobName = [subDict objectForKey:@"name"];
        model.childType = (NSArray *)[subDict objectForKey:@"list"];
        [reArray addObject:model];
    }
    
    return reArray;
}

- (void)getHomePageCityIDWithCityName:(NSString *)cityName backData:(void(^)(NSString *cityId))callback
{
    NSString *url = [NSString stringWithFormat:@"%@cityName=%@",IKGetCityIdUrl,cityName];
    NSLog(@"url = %@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);

        NSString *str = [[responseObject objectForKey:@"data"] objectForKey:@"region_id"];
        [IKUSERDEFAULT setObject:str forKey:@"locationCityId"];
        
        if (callback) {
            callback(str);
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)getHomePageMoreJobInfoDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    // cityId=0&&pageSize=8
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&pageSize=%@&type=%@page=%@",IKGetMoreJobListUrl,[param objectForKey:@"cityId"],[param objectForKey:@"pageSize"],[param objectForKey:@"type"],[param objectForKey:@"page"]];
    NSLog(@"url = %@",url);
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);

        NSArray *arr = [self dealHomePageJobInfoData:responseObject];
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback(arr,success);
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getHomePageJobInfoDetailWithParam:(NSDictionary *)param backData:(void (^)(IKJobDetailModel *detailModel, BOOL success))callback
{
    NSString *url = [NSString stringWithFormat:@"%@inviteWorkId=%@&userId=0",IKJobDeatailUrl,[param objectForKey:@"inviteWorkId"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;

    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;
//        NSLog(@"responseCache = %@",responseCache);

        IKJobDetailModel *model = [self dealJobDetailData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        
        if (callback && model) {
            callback(model,success);
        }
    } success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {
            IKJobDetailModel *model = [self dealJobDetailData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && model) {
                callback(model,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (IKJobDetailModel *)dealJobDetailData:(id)data
{
    NSDictionary *dict = (NSDictionary *)[data objectForKey:@"data"];
    
    if (dict.allKeys.count == 0) {
        return nil;
    }
    
    IKJobDetailModel *model = [[IKJobDetailModel alloc] init];

    model.workAddress = [NSString stringWithFormat:@"%@",[dict objectForKey:@"address"]];
    model.workCity = [NSString stringWithFormat:@"%@",[dict objectForKey:@"city_name"]] ;
    model.responsibility = [NSString stringWithFormat:@"%@",[dict objectForKey:@"duties"]];
    model.education = [NSString stringWithFormat:@"%@",[dict objectForKey:@"education_name"]];
    model.jobID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    model.feedback = (NSArray *)[dict objectForKey:@"inviteWorkFeedback"];
    model.require = [NSString stringWithFormat:@"%@",[dict objectForKey:@"require"]];
    model.salary = [NSString stringWithFormat:@"%@",[dict objectForKey:@"salary_name"]];
    model.shopName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"shop_name"]];
    model.tagsList = (NSArray *)[dict objectForKey:@"tagList"];
    model.temptation = [NSString stringWithFormat:@"职位诱惑: %@",[dict objectForKey:@"temptation"]];
    model.companyInfo = (NSDictionary *)[dict objectForKey:@"userCompany"];
    model.releaseTime = [self timeWithTimeIntervalString:[dict objectForKey:@"vaild_time_start"]];
    model.experience = [NSString stringWithFormat:@"%@",[dict objectForKey:@"work_experience_name"]];
    model.jobName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"work_name"]];
    
    NSInteger index = 4; // tabelView 最少有 4 个 section
    
    if (model.tagsList.count > 0) {
        index += 1;   // 有技能标签,添加 1 个 section.
    }
    model.numberOfSection = index;
    
    return model;
}

- (void)getCompanyPageCompanyInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    //cityId=0&page=1&pageSize=8
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&page=%@&pageSize=%@",IKCompanyInfoUrl,[param objectForKey:@"cityId"],[param objectForKey:@"page"],[param objectForKey:@"pageSize"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;
//                NSLog(@"responseCache = %@",responseCache);
        NSArray *array = [self dealCompanyInfoData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        
        if (callback && array.count > 0) {
            callback(array,success);
        }
    } success:^(id responseObject) {
//                NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {
            NSArray *array = [self dealCompanyInfoData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && array.count > 0) {
                callback(array,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealCompanyInfoData:(id)data
{
    NSArray *array = [data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    
    NSMutableArray *backArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i ++) {
        IKCompanyInfoModel *model = [[IKCompanyInfoModel alloc] init];
        
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        
        model.address = [self getString:[dict objectForKey:@"cityName"]];
        model.title = [self getString:[dict objectForKey:@"nickname"]];
        model.evaluate = [self getInteger:[dict objectForKey:@"isRecommend"]];
        model.logoImageUrl = [self getString:[dict objectForKey:@"headerImage"]];;
        model.introduce = [self getString:[dict objectForKey:@"brandDescribe"]];
        model.isAuthen = [self getBool:[dict objectForKey:@"isApproveOffcial"] ];
        model.setupTime = [NSString stringWithFormat:@"%@年成立",[dict objectForKey:@"createCompanyYear"]];
        model.companyID = [self getString:[dict objectForKey:@"id"]];
        model.numberOfJob = [NSString stringWithFormat:@"%@个在招职位",[dict objectForKey:@"inviteWorkNum"]];
        model.numberOfStore = [self getString:[dict objectForKey:@"shopName"]];

        [backArray addObject:model];
    }
    
    return backArray;
}


- (void)getCompanyPageCompanyInfoDetailWithParam:(NSDictionary *)param backData:(void (^)(IKCompanyDetailHeadModel *detailModel, BOOL success))callback
{
    // userCompanyId=323&userId=0
    NSString *url = [NSString stringWithFormat:@"%@userCompanyId=%@&userId=0",IKCompanyDetailInfoUrl,[param objectForKey:@"userCompanyId"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;
                NSLog(@"responseCache = %@",responseCache);
        IKCompanyDetailHeadModel *model = [self dealCompanyInfoDetailData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];

        if (callback && model) {
            callback(model,success);
        }
    } success:^(id responseObject) {
                NSLog(@"responseObject = %@",responseObject);
        
        if (![dataResult isEqual:responseObject]) {
            IKCompanyDetailHeadModel *model = [self dealCompanyInfoDetailData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && model) {
                callback(model,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (IKCompanyDetailHeadModel *)dealCompanyInfoDetailData:(id)data
{
    NSDictionary *dict = (NSDictionary *)[data objectForKey:@"data"];
    
    if (dict.allKeys.count == 0) {
        return nil;
    }
    
    IKCompanyDetailHeadModel *model = [[IKCompanyDetailHeadModel alloc] init];
    
    model.workAddress = [self getString:[dict objectForKey:@"address"]];
    model.workCity = [self getString:[dict objectForKey:@"cityName"]];
    model.numberOfAttention = [self getString:[dict objectForKey:@"attentionNum"]];
    model.companyName = [self getString:[dict objectForKey:@"companyName"]];
    model.companyTypeName = [self getString:[dict objectForKey:@"companyTypeName"]];
    model.companyType = [self getString:[dict objectForKey:@"companyType"]];
    model.setupYear = [NSString stringWithFormat:@"%@年成立",[dict objectForKey:@"createCompanyYear"]];
    model.logoImageUrl = [self getString:[dict objectForKey:@"headerImage"]];
    model.isAuthen = [self getBool:[dict objectForKey:@"isApproveOffcial"]];
    model.nickName = [self getString:[dict objectForKey:@"nickname"]];
    model.shopName = [self getString:[dict objectForKey:@"shopTypeName"]];
    model.numberOfSchool = [self getString:[dict objectForKey:@"schoolNum"]];
    model.isAppraise = YES;//[self getBool:[dict objectForKey:@"hasAppraise"]];
    model.isOperate = [self getBool:[dict objectForKey:@"hasOperate"]];
    model.isPerisher = [self getBool:[dict objectForKey:@"hasPerisher"]];

    model.numberOfProduct = [self getString:[dict objectForKey:@"productNum"]];
    model.companyDescription = [self getString:[dict objectForKey:@"brandDescribe"]];
    model.companyID = [self getString:[dict objectForKey:@"userId"]];
    return model;
}


- (void)getCompanyPageAboutUsInfoWithParam:(NSDictionary *)param backData:(void (^)(IKCompanyAboutUsModel *model, BOOL success))callback
{
    // userCompanyId=323&userId=0
    NSString *url = [NSString stringWithFormat:@"%@userCompanyId=%@",IKCompanyAboutUsUrl,[param objectForKey:@"userCompanyId"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;
//        NSLog(@"responseCache = %@",responseCache);
        IKCompanyAboutUsModel *model = [self dealCompanyAboutUsData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        
        if (callback && model) {
            callback(model,success);
        }
    } success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {
            IKCompanyAboutUsModel *model = [self dealCompanyAboutUsData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && model) {
                callback(model,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (IKCompanyAboutUsModel *)dealCompanyAboutUsData:(id)data
{
    NSDictionary *dict = (NSDictionary *)[data objectForKey:@"data"];
    
    if (dict.allKeys.count == 0) {
        return nil;
    }
    
    NSLog(@"daaaaaaaaa = %@",data);
    IKCompanyAboutUsModel *model = [[IKCompanyAboutUsModel alloc] init];
    
    model.companyID = [self getString:[dict objectForKey:@"user_id"]];
    model.cityName = [self getString:[dict objectForKey:@"cityName"]];
    model.cityID = [self getString:[dict objectForKey:@"cityId"]];
    model.imageArray = (NSArray *)[dict objectForKey:@"imgListFull"];
    model.workAddress = [self getString:[dict objectForKey:@"address"]];
    model.informationDetail = [self getString:[dict objectForKey:@"informationDetail"]];
    model.location = [self getString:[dict objectForKey:@"location"]];
    model.progressList = (NSArray *)[dict objectForKey:@"progressList"];
    model.provinceID = [self getString:[dict objectForKey:@"provinceId"]];
    return model;
}


- (void)getCompanyPageManagerTeamInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    // userCompanyId=292
    
    NSString *url = [NSString stringWithFormat:@"%@userCompanyId=%@",IKCompanyManagerTeamUrl,[param objectForKey:@"userCompanyId"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;
//                NSLog(@"responseCache = %@",responseCache);
        NSArray *array = [self dealManagerTeamData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        
        if (callback && array.count > 0) {
            callback(array,success);
        }
    } success:^(id responseObject) {
//                NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {
            NSArray *array = [self dealManagerTeamData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback && array.count > 0) {
                callback(array,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSArray *)dealManagerTeamData:(id)data
{
    NSArray *array = (NSArray *)[data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    
    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
    
    for (id object in array) {
        if ([object isKindOfClass:[NSDictionary class]]) {
           
            NSDictionary *dict = (NSDictionary *)object;
            IKCompanyManagerTeamModel *model = [[IKCompanyManagerTeamModel alloc] init];
            model.companyID = [self getString:[dict objectForKey:@"user_id"]];
            model.headerImageUrl = [self getString:[dict objectForKey:@"header_image"]];
            model.headerImageName = [self getString:[dict objectForKey:@"header_image_name"]];
            model.name = [self getString:[dict objectForKey:@"name"]];
            NSString *key = [self getString:[dict objectForKey:@"work_position"]];
            model.workPosition = [self getPositionFromPlist:key];
            model.describe = [self getString:[dict objectForKey:@"describe"]];
            [muArray addObject:model];

        }
    }
    return muArray;
}


- (void)getCompanyPageNeedJobInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@userCompanyId=%@",IKCompanyNeedJobUrl,[param objectForKey:@"userCompanyId"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        
        dataResult = responseCache;
        NSArray *arr = [self dealHomePageJobInfoData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {
            NSArray *arr = [self dealHomePageJobInfoData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback) {
                callback(arr,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)getCompanyPageShopNumberInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@companyType=1&userCompanyId=%@",IKGetShopListUrl,[param objectForKey:@"userCompanyId"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        NSLog(@"responseCache = %@",responseCache);
        dataResult = responseCache;
        NSArray *arr = [self dealShopNumberInfoData:responseCache];
        BOOL success = [self requestDataSuccess:responseCache];
        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);

        if (![dataResult isEqual:responseObject]) {
            NSArray *arr = [self dealShopNumberInfoData:responseObject];
            BOOL success = [self requestDataSuccess:responseObject];
            
            if (callback) {
                callback(arr,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealShopNumberInfoData:(id)data
{
    NSArray *array = (NSArray *)[data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    
    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:array.count];
    
    for (id object in array) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = (NSDictionary *)object;
            IKCompanyShopNumModel *model = [[IKCompanyShopNumModel alloc] init];
            model.companyID = [self getString:[dict objectForKey:@"user_company_id"]];
            model.logoImageUrl = [self getString:[dict objectForKey:@"shop_image_url"]];
            model.workCity = [self getString:[dict objectForKey:@"address"]];
            model.name = [self getString:[dict objectForKey:@"name"]];
            model.area = [NSString stringWithFormat:@"%@㎡",[dict objectForKey:@"area"]];
            model.workCity = [self getString:[dict objectForKey:@"city_name"]];
            model.companyType = [self getString:[dict objectForKey:@"company_type"]];
            model.setupYear = [self getString:[dict objectForKey:@"create_time"]];
            model.describeDetail = [self getString:[dict objectForKey:@"describe_detail"]];
            model.describeIntro = [self getString:[dict objectForKey:@"describe_intro"]];
            model.ID = [self getString:[dict objectForKey:@"id"]];
            model.inviteIds = [self getString:[dict objectForKey:@"inviteIds"]];
            model.inviteNum = [NSString stringWithFormat:@"%@个 在招职位",[dict objectForKey:@"inviteNum"]];
            model.name = [self getString:[dict objectForKey:@"name"]];
            model.name = [self getString:[dict objectForKey:@"name"]];
            model.isBusiness = [self getBool:[dict objectForKey:@"is_business"]];
            model.numberOfMember = [NSString stringWithFormat:@"%@名会员",[dict objectForKey:@"member_num"]];
            model.provinceid = [self getString:[dict objectForKey:@"province_id"]];
            model.provinceName = [self getString:[dict objectForKey:@"province_name"]];
            model.shopType = [self getString:[dict objectForKey:@"shop_type"]];
            model.status = [self getString:[dict objectForKey:@"status"]];
            model.numberOfTeach = [self getString:[dict objectForKey:@"teach_num"]];
            model.updateTime = [self getString:[dict objectForKey:@"update_time"]];
            model.shopTypeName = [self getString:[dict objectForKey:@"shop_type_name"]];
            model.shopType = [self getString:[dict objectForKey:@"shop_type"]];

            [muArray addObject:model];
            
        }
    }
    return muArray;
}



- (NSString *)getPositionFromPlist:(NSString *)key
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"IKWorkPosition" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSLog(@"datadatadatadata = %@",data);
    return [data objectForKey:key];
}


- (NSString *)timeWithTimeIntervalString:(NSString *)timeInterval
{
    // 格式化时间
    self.dataFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [self.dataFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dataFormatter setTimeStyle:NSDateFormatterShortStyle];
    [self.dataFormatter setDateFormat:@"yyyy.MM.dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    NSString* dateString = [self.dataFormatter stringFromDate:date];
    NSLog(@"dateString ======= %@",dateString);
    return [NSString stringWithFormat:@"职位发布时间: %@",dateString];
}


- (NSString *)getString:(id)object
{
    return [NSString stringWithFormat:@"%@",object];
}

- (BOOL)getBool:(id)object
{
    if ([[self getString:object] isEqualToString:@"0"]) {
        return NO;
    }
    return YES;
}


- (NSArray *)getArray:(id)object separateString:(NSString *)separate
{
    NSString *str = [self getString:object];
    
    NSArray *array = [str componentsSeparatedByString:separate];
    
    return array;
}


- (NSInteger)getInteger:(id)object
{
    return [[self getString:object] integerValue];
}

// 判断服务器数据是否正常,0 代表正确
- (BOOL)requestDataSuccess:(id)data
{
    NSString *errCode = [NSString stringWithFormat:@"%@",[data objectForKey:@"err"]];
    BOOL success = ([errCode integerValue] == 0)?YES:NO;
    return success;
}







@end
