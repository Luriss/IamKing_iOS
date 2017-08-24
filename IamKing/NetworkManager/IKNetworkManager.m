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
#import "IKCompanyRecommendListModel.h"
#import "IKBlackListModel.h"
#import "IKAttentionCompanyModel.h"
#import "IKJobProcessModel.h"
#import "IKSchoolListModel.h"



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

// type=0&userId=294
#define IKGetRecommendCompanyListUrl (@"https://www.iamking.com.cn/index.php/Company/getRecommendList?")

//cityId=0&page=2&pageSize=8
//#define IKCompanyInfoLoadMoreUrl (@"https://www.iamking.com.cn/index.php/User/getUserCompanyList?")

//shopId=127&userCompanyId=292
#define IKCompanyShopListUrl  (@"https://www.iamking.com.cn/index.php/ShopList/getInviteListByShopId?")

// 搜索工作
//cityId=0&companyType=0&page=1&pageSize=8&salaryType=0&str=%E7%A7%81%E6%95%99%E7%BB%8F%E7%90%86&workExperienceType=0
#define IKWorkSearchUrl (@"https://www.iamking.com.cn/index.php/InviteWork/searchByWorkName?")

// 搜索公司
// appraiseLevel=0&businessType=0&cityId=0&companyType=0&page=1&pageSize=8&shopType=0&str=%E7%A7%81%E6%95%99%E7%BB%8F%E7%90%86

#define IKCompanySearchUrl (@"https://www.iamking.com.cn/index.php/User/searchByName?")

// 反馈数据
#define IKFeedbackUrl (@"https://www.iamking.com.cn/index.php/Feedback/add")

// 登陆
//accessToken=&account=18658393976&openId=&passwd=eabd8ce9404507aa8c22714d3f5eada9&userType=0,1

#define IKLoginUrl (@"https://www.iamking.com.cn/index.php/User/login?")

// 获取验证码
// codeMethod=2&tel=18667166652&useType=7+button
#define IKGetVerifyCodeUrl (@"https://www.iamking.com.cn/index.php/Code/getCode?")

// 获取黑名单
 // pageSize=16&userId=294
#define IKGetBlackListUrl (@"https://www.iamking.com.cn/index.php/UserPerisher/getList?")

// 删除黑名单

#define IKPostDeleteBlackListUrl (@"https://www.iamking.com.cn/index.php/UserPerisher/delete")

// 获取关注公司
// page=1&pageSize=8&userId=294
#define IKGetAttentionCompanyListUrl (@"https://www.iamking.com.cn/index.php/UserOperate/getCompanyList?")

// 关注
#define IKPostCancelAttentionUrl (@"https://www.iamking.com.cn/index.php/UserOperate/addUserOperate")

// 获取收藏列表 page=1&pageSize=8&userId=294
#define IKGetCollectionJobList (@"https://www.iamking.com.cn/index.php/Collect/getInviteList?")

// 收藏
#define IKPostCancelCollectionUrl (@"https://www.iamking.com.cn/index.php/InviteWork/collect")

// 求职进度 page=1&pageSize=8&userId=294
#define IKGetJobProcessUrl (@"https://www.iamking.com.cn/index.php/SendResume/getList?")

// 获取评价
#define IKGetMyAppraiseUrl (@"https://www.iamking.com.cn/index.php/InviteWorkFeedback/getInfo?")


#define IKGetMyResumeUrl (@"https://www.iamking.com.cn/index.php/Resume/getInfoSelf?")

#define IKGetResumeWorkListUrl (@"https://www.iamking.com.cn/index.php/Work/getWorkList")

// type=4,5
#define IKGetResumeSchoolListUrl  (@"https://www.iamking.com.cn/index.php/SchoolList/getList?")




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
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSDictionary *dict = nil;
        if (success) {
            dict = [self dealHomePageLoopPlayImageData:responseObject];
        }
        else{
            dict = @{@"errmsg":[responseObject objectForKey:@"errmsg"]};
        }
        
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

        BOOL success = [self requestDataSuccess:responseCache];

        NSDictionary *dict = nil;
        if (success) {
            dict = [self dealHomePageLoopPlayImageData:responseCache];
        }
        else{
            dict = @{@"errmsg":[responseCache objectForKey:@"errmsg"]};
        }
        if (callback) {
            callback(dict,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSDictionary *dict = nil;
            if (success) {
                dict = [self dealHomePageLoopPlayImageData:responseObject];
            }
            else{
                dict = @{@"errmsg":[responseObject objectForKey:@"errmsg"]};
            }
            
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

        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealHomePageJobInfoData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
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

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealHomePageJobInfoData:responseCache];
        }
        else{
            arr = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *arr = nil;
            if (success) {
                arr = [self dealHomePageJobInfoData:responseObject];
            }
            else{
                arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
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
        
        if ([[dict objectForKey:@"userCompany"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *userDict = (NSDictionary *)[dict objectForKey:@"userCompany"];
            model.logoImageUrl = [userDict objectForKey:@"headerImage"];
            model.introduce = [userDict objectForKey:@"brand_describe"];
            model.isAuthen = [[userDict objectForKey:@"is_approve_offcial"] boolValue];
        }
        
        
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

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealHotCityData:responseCache];
        }
        else{
            arr = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
        
    } success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {

            [IKUSERDEFAULT setObject:responseObject forKey:@"IKHotCityData"];
            [IKUSERDEFAULT synchronize];
            
            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *arr = nil;
            if (success) {
                arr = [self dealHotCityData:responseObject];
            }
            else{
                arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
            if (callback) {
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
        dataResult = responseCache;

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealProviceCityData:responseCache];
        }
        else{
            arr = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }

        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {

        [IKUSERDEFAULT setObject:responseObject forKey:@"IKProvinceCityData"];
        [IKUSERDEFAULT synchronize];
        
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *arr = nil;
            if (success) {
                arr = [self dealProviceCityData:responseObject];
            }
            else{
                arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
            if (callback) {
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


- (void)getHotCityDataAndProvinceDataFromChahe:(void (^)(NSArray *hotCity,NSArray *province))callback
{
    id hotCityData = [IKUSERDEFAULT objectForKey:@"IKHotCityData"];
    
    NSArray *hotArr = [self dealHotCityData:hotCityData];
    
    id provinceData = [IKUSERDEFAULT objectForKey:@"IKProvinceCityData"];
    
    NSArray *provinceArr = [self dealProviceCityData:provinceData];
    
    if (callback) {
        callback(hotArr,provinceArr);
    }
}


- (void)getHomePageWorkListDataWithBackData:(IKRequestArrayData)callback
{
    __block id dataResult = nil;

    [IKNetworkHelper GET:IKWorkListUrl parameters:nil responseCache:^(id responseCache) {
//                NSLog(@"responseCache = %@",responseCache);
        dataResult = responseCache;

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealWorkListData:responseCache];
        }
        else{
            arr = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
//                NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *arr = nil;
            if (success) {
                arr = [self dealWorkListData:responseObject];
            }
            else{
                arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
            if (callback) {
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
        model.jobId = [subDict objectForKey:@"id"];
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
    NSLog(@"uuuuuuuuuurl = %@",url);
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);


        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealHomePageJobInfoData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
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
        NSLog(@"responseCache = %@",responseCache);


        BOOL success = [self requestDataSuccess:responseCache];
        
        IKJobDetailModel *model = nil;
        
        if (success) {
            model = [self dealJobDetailData:responseCache];
        }
        else{
            model = [[IKJobDetailModel alloc] init];
            model.errorMsg = [self getString:[responseCache objectForKey:@"errmsg"]];
        }
        if (callback) {
            callback(model,success);
        }
    } success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            IKJobDetailModel *model = nil;
            
            if (success) {
                model = [self dealJobDetailData:responseObject];
            }
            else{
                model = [[IKJobDetailModel alloc] init];
                model.errorMsg = [self getString:[responseObject objectForKey:@"errmsg"]];
            }
            
            if (callback) {
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

- (void)getCompanyPageCompanyInfoWithParam:(NSDictionary *)param useCache:(BOOL)useCache backData:(IKRequestArrayData)callback
{
    //cityId=0&page=1&pageSize=8
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&page=%@&pageSize=%@",IKCompanyInfoUrl,[param objectForKey:@"cityId"],[param objectForKey:@"page"],[param objectForKey:@"pageSize"]];
    NSLog(@"uuuuuuuuurl = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        if (useCache) {
            NSLog(@"useCache");
            dataResult = responseCache;

            BOOL success = [self requestDataSuccess:responseCache];
            
            NSArray *array = nil;
            
            if (success) {
                array = [self dealCompanyInfoData:responseCache];
            }
            else{
                array = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
            }
            
            if (callback) {
                callback(array,success);
            }
        }
    } success:^(id responseObject) {
        NSLog(@"not useCache");
//                NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *array = nil;
            
            if (success) {
                array = [self dealCompanyInfoData:responseObject];
            }
            else{
                array = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
            if (callback) {
                callback(array,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)getCompanyPageMoreCompanyInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    [self getCompanyPageCompanyInfoWithParam:param useCache:NO backData:^(NSArray *dataArray, BOOL success) {
        if (callback) {
            callback(dataArray,success);
        }
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
        model.logoImageUrl = [self getString:[dict objectForKey:@"headerImage"]];
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

- (void)getCompanyPageRecommendCompanyListWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    // userCompanyId=323&userId=0
    NSString *url = [NSString stringWithFormat:@"%@type=0&userId=294",IKGetRecommendCompanyListUrl];//,[param objectForKey:@"userCompanyId"]];
    NSLog(@"url = %@",url);
    
    __block id dataResult = nil;
    
    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *array = nil;
        
        if (success) {
            array = [self dealRecommendCompanyListData:responseCache];
        }
        else{
            array = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(array,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *array = nil;
            
            if (success) {
                array = [self dealRecommendCompanyListData:responseObject];
            }
            else{
                array = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
            if (callback) {
                callback(array,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealRecommendCompanyListData:(id)data
{
    NSArray *array = [data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    
    NSMutableArray *backArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i ++) {
        
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        IKCompanyRecommendListModel *model = [[IKCompanyRecommendListModel alloc] init];
        model.describe = [self getString:[dict objectForKey:@"brand_describe"]];
        model.nickName = [self getString:[dict objectForKey:@"nickname"]];
        model.logoImageUrl = [self getString:[dict objectForKey:@"header_image"]];;
        model.isOperate = [self getBool:[dict objectForKey:@"operate_id"] ];
        model.companyID = [self getString:[dict objectForKey:@"user_id"]];
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
//                NSLog(@"responseCache = %@",responseCache);

        BOOL success = [self requestDataSuccess:responseCache];

        IKCompanyDetailHeadModel *model = nil;
        
        if (success) {
            model = [self dealCompanyInfoDetailData:responseCache];
        }
        else{
            model = [[IKCompanyDetailHeadModel alloc] init];
            model.errorMsg = [self getString:[responseCache objectForKey:@"errmsg"]];
        }
        
        if (callback && model) {
            callback(model,success);
        }
    } success:^(id responseObject) {
//                NSLog(@"responseObject = %@",responseObject);
        
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            IKCompanyDetailHeadModel *model = nil;
            
            if (success) {
                model = [self dealCompanyInfoDetailData:responseObject];
            }
            else{
                model = [[IKCompanyDetailHeadModel alloc] init];
                model.errorMsg = [self getString:[responseObject objectForKey:@"errmsg"]];
            }
            
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
    model.isAppraise = [self getBool:[dict objectForKey:@"hasAppraise"]];
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

        BOOL success = [self requestDataSuccess:responseCache];
        
        IKCompanyAboutUsModel *model = nil;
        
        if (success) {
            model = [self dealCompanyAboutUsData:responseCache];
        }
        else{
            model = [[IKCompanyAboutUsModel alloc] init];
            model.errorMsg = [self getString:[responseCache objectForKey:@"errmsg"]];
        }
        
        if (callback) {
            callback(model,success);
        }
    } success:^(id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            IKCompanyAboutUsModel *model = nil;
            
            if (success) {
                model = [self dealCompanyAboutUsData:responseObject];
            }
            else{
                model = [[IKCompanyAboutUsModel alloc] init];
                model.errorMsg = [self getString:[responseObject objectForKey:@"errmsg"]];
            }
            
            if (callback) {
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

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *array = nil;
        
        if (success) {
            array = [self dealManagerTeamData:responseCache];
        }
        else{
            array = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(array,success);
        }
    } success:^(id responseObject) {
//                NSLog(@"responseObject = %@",responseObject);
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *array = nil;
            
            if (success) {
                array = [self dealManagerTeamData:responseObject];
            }
            else{
                array = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
            if (callback) {
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

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *arr = nil;
        
        if (success) {
            arr = [self dealHomePageJobInfoData:responseCache];
        }
        else{
            arr = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *arr = nil;
            
            if (success) {
                arr = [self dealHomePageJobInfoData:responseObject];
            }
            else{
                arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
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

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *arr = nil;
        
        if (success) {
            arr = [self dealShopNumberInfoData:responseCache];
        }
        else{
            arr = @[[self getString:[responseCache objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
    } success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);

        if (![dataResult isEqual:responseObject]) {

            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *arr = nil;
            
            if (success) {
                arr = [self dealShopNumberInfoData:responseObject];
            }
            else{
                arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
            }
            
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
            model.allShopImages = [dict objectForKey:@"shopImageListFull"];
            [muArray addObject:model];
            
        }
    }
    return muArray;
}


- (void)getCompanyPageShopListInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@shopId=%@&userCompanyId=%@",IKCompanyShopListUrl,[param objectForKey:@"shopId"],[param objectForKey:@"companyId"]];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        
        if (success) {
            arr = [self dealHomePageJobInfoData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
    } failure:^(NSError *error) {
        
    }];
}



- (void)getSearchPageJobInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&pageSize=%@&companyType=%@&page=%@&salaryType=%@&str=%@&workExperienceType=%@",IKWorkSearchUrl,[param objectForKey:@"cityId"],[param objectForKey:@"pageSize"],[param objectForKey:@"companyType"],[param objectForKey:@"page"],[param objectForKey:@"salaryType"],[param objectForKey:@"searchString"],[param objectForKey:@"workExperienceType"]];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        NSLog(@"responseObject 22 = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealHomePageJobInfoData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
        NSLog(@"arr = %@",arr);
        if (callback) {
            callback(arr,success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)getSearchPageCompanyInfoWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@cityId=%@&pageSize=%@&companyType=%@&page=%@&appraiseLevel=%@&str=%@&businessType=%@&shopType=%@",IKCompanySearchUrl,[param objectForKey:@"cityId"],[param objectForKey:@"pageSize"],[param objectForKey:@"companyType"],[param objectForKey:@"page"],[param objectForKey:@"appraiseLevel"],[param objectForKey:@"searchString"],[param objectForKey:@"businessType"],[param objectForKey:@"businessTyshopTypepe"]];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        NSLog(@"responseObject 22 = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealCompanyInfoData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
        NSLog(@"arr = %@",arr);
        if (callback) {
            callback(arr,success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)getLoginInfoWithParam:(NSDictionary *)param backData:(void (^)(NSDictionary *dict, BOOL success))callback
{
    NSString *url = [NSString stringWithFormat:@"%@accessToken=%@&account=%@&openId=%@&passwd=%@&userType=0,1",IKLoginUrl,[param objectForKey:@"accessToken"],[param objectForKey:@"account"],[param objectForKey:@"openId"],[param objectForKey:@"passwd"]];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
//        NSLog(@"responseObject 22 = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];

        if (callback) {
            callback([responseObject objectForKey:@"data"],success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}

// accessToken=&account=18667166652&code=072835&openId=&userType=0,1
- (void)getLoginInfoWithVerifyCodeParam:(NSDictionary *)param backData:(void (^)(NSDictionary *dict, BOOL success))callback
{
    NSString *url = [NSString stringWithFormat:@"%@accessToken=%@&account=%@&openId=%@&code=%@&userType=0,1",IKLoginUrl,[param objectForKey:@"accessToken"],[param objectForKey:@"account"],[param objectForKey:@"openId"],[param objectForKey:@"code"]];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        //        NSLog(@"responseObject 22 = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback([responseObject objectForKey:@"data"],success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getChangePhoneNumberVerifyCode:(NSDictionary *)param backData:(void (^)(NSString *verifyCode, BOOL success))callback
{
    NSString *url = [NSString stringWithFormat:@"%@codeMethod=%@&tel=%@&useType=%@",IKGetVerifyCodeUrl,[param objectForKey:@"codeMethod"],[param objectForKey:@"phoneNumber"],[param objectForKey:@"useType"]];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        NSLog(@"responseObject 22 = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        NSString *code = nil;
        if (success) {
            code = [self getString:[[responseObject objectForKey:@"data"] objectForKey:@"code"]];
        }
        else{
            code = @"";
        }
        
        if (callback) {
            callback(code,success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)getBlackListDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@pageSize=%@&userId=%@",IKGetBlackListUrl,[param objectForKey:@"pageSize"],[param objectForKey:@"userId"]];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealBlackListData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
    } failure:^(NSError *error) {
        
    }];
}

- (NSArray *)dealBlackListData:(id)data
{
    NSArray *array = [data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    NSLog(@"arrayarray = %@",array);
    NSMutableArray *backArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i ++) {
        IKBlackListModel *model = [[IKBlackListModel alloc] init];
        
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        
        model.Id = [self getString:[dict objectForKey:@"id"]];
        model.headerImageUrl = [self getString:[dict objectForKey:@"headerImage"]];
        
        NSDictionary *subDict = (NSDictionary *)[dict objectForKey:@"nickname"];
        model.headerImageName = [self getString:[subDict objectForKey:@"header_image"]];
        model.nickName = [self getString:[subDict objectForKey:@"nickname"]];;
        [backArray addObject:model];
    }
    
    return backArray;
}


- (void)getAttentionCompanyListDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@page=%@&pageSize=%@&userId=%@",IKGetAttentionCompanyListUrl,[param objectForKey:@"page"],[param objectForKey:@"pageSize"],[param objectForKey:@"userId"]];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealAttentionCompanyListData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealAttentionCompanyListData:(id)data
{
    NSArray *array = [data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    NSMutableArray *backArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i ++) {
        IKAttentionCompanyModel *model = [[IKAttentionCompanyModel alloc] init];
        
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        
        model.Id = [self getString:[dict objectForKey:@"id"]];
        model.headerImageUrl = [self getString:[dict objectForKey:@"headerImage"]];
        model.appraiseNum = [self getString:[dict objectForKey:@"appraiseNum"]];
        model.cityName = [self getString:[dict objectForKey:@"cityName"]];
        model.setupYear = [NSString stringWithFormat:@"%@年成立",[dict objectForKey:@"createCompanyYear"]];
        model.nickName = [self getString:[dict objectForKey:@"nickname"]];
        model.product = [self getString:[dict objectForKey:@"product"]];
        model.productNum = [self getString:[dict objectForKey:@"productNum"]];
        model.schoolNum = [self getString:[dict objectForKey:@"schoolNum"]];
        model.shopType = [self getString:[dict objectForKey:@"shopType"]];
        model.workNum = [self getString:[dict objectForKey:@"workNum"]];
        model.isApproveOffcial = [self getBool:[dict objectForKey:@"isApproveOffcial"]];
        [backArray addObject:model];
    }
    
    return backArray;
}

- (void)getCollectionJobListDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@page=%@&pageSize=%@&userId=%@",IKGetCollectionJobList,[param objectForKey:@"page"],[param objectForKey:@"pageSize"],[param objectForKey:@"userId"]];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealHomePageJobInfoData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)getJobProcessDataWithParam:(NSDictionary *)param backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@page=%@&pageSize=%@&userId=%@",IKGetJobProcessUrl,[param objectForKey:@"page"],[param objectForKey:@"pageSize"],[param objectForKey:@"userId"]];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        
        BOOL success = [self requestDataSuccess:responseObject];
        
        NSArray *arr = nil;
        if (success) {
            arr = [self dealJObProcessData:responseObject];
        }
        else{
            arr = @[[self getString:[responseObject objectForKey:@"errmsg"]]];
        }
        
        if (callback) {
            callback(arr,success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealJObProcessData:(id)data
{
    NSArray *array = [data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
    NSMutableArray *backArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i ++) {
        IKJobProcessModel *model = [[IKJobProcessModel alloc] init];
        
        NSDictionary *dict = (NSDictionary *)[array objectAtIndex:i];
        
        model.companyStatus = [self getString:[dict objectForKey:@"companyStatus"]];
        model.companyType = [self getString:[dict objectForKey:@"companyType"]];
        model.endTime = [self getString:[dict objectForKey:@"endTime"]];
        model.hasFeedback = [self getString:[dict objectForKey:@"hasFeedback"]];
        model.inviteStatus = [self getString:[dict objectForKey:@"inviteStatus"]];
        model.product = [self getString:[dict objectForKey:@"product"]];
        model.productNum = [self getString:[dict objectForKey:@"productNum"]];
        model.schoolNum = [self getString:[dict objectForKey:@"schoolNum"]];
        model.inviteWorkId = [self getString:[dict objectForKey:@"inviteWorkId"]];
        model.sendResumeId = [self getString:[dict objectForKey:@"sendResumeId"]];
        model.sendTime = [self getString:[dict objectForKey:@"sendTime"]];
        model.userStatus = [self getString:[dict objectForKey:@"userStatus"]];
        model.workName = [self getString:[dict objectForKey:@"workName"]];
        model.companyId = [self getString:[dict objectForKey:@"userCompanyId"]];
        model.nickName = [self getString:[dict objectForKey:@"nickname"]];
        
        NSMutableDictionary *companyInfo = [[NSMutableDictionary alloc] init];
        
        [companyInfo setObject:[dict objectForKey:@"avgNum"] forKey:@"appraiseNum"];
        [companyInfo setObject:[dict objectForKey:@"cityName"] forKey:@"cityName"];
        [companyInfo setObject:[dict objectForKey:@"companyType"] forKey:@"companyType"];
        [companyInfo setObject:[dict objectForKey:@"createCompanyYear"] forKey:@"createCompanyYear"];
        [companyInfo setObject:[dict objectForKey:@"header_image"] forKey:@"headerImage"];
        [companyInfo setObject:[dict objectForKey:@"isApproveOffcial"] forKey:@"isApproveOffcial"];
        [companyInfo setObject:model.nickName forKey:@"nickname"];
        [companyInfo setObject:[dict objectForKey:@"shopType"] forKey:@"shopType"];
        [companyInfo setObject:[dict objectForKey:@"workNum"] forKey:@"workNum"];
        [companyInfo setObject:[dict objectForKey:@"userCompanyId"] forKey:@"id"];
        
        model.companyInfoDict = companyInfo;
        
        [backArray addObject:model];
    }
    
    return backArray;
}


- (void)getJobMyAppraiseDataWithSendResumeId:(NSString *)resumeId backData:(void (^)(NSDictionary *dict, BOOL success))callback
{
    NSString *url = [NSString stringWithFormat:@"%@id=%@",IKGetMyAppraiseUrl,resumeId];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback((NSDictionary *)[responseObject objectForKey:@"data"],success);
        }
        
    } failure:^(NSError *error) {
        
    }];
}


// 删掉缓存
- (void)getMyResumeDataWithId:(NSString *)userId backData:(void (^)(IKResumeModel *model, BOOL success))callback
{
    NSString *url = [NSString stringWithFormat:@"%@userId=%@",IKGetMyResumeUrl,userId];
    
    [IKNetworkHelper GET:url parameters:nil responseCache:nil success:^(id responseObject) {
        BOOL success = [self requestDataSuccess:responseObject];
        
        IKResumeModel *model = nil;
        if (success) {
            model = [self dealResumeData:responseObject];
        }
        
        if (callback) {
            callback(model,success);
        }

    } failure:^(NSError *error) {
        
    }];
}


- (IKResumeModel *)dealResumeData:(id)data
{
    NSDictionary *dict = (NSDictionary *)[data objectForKey:@"data"];
    
    if (dict.allKeys.count == 0) {
        return nil;
    }
    
    NSLog(@"data  = %@",data);
    IKResumeModel *model = [[IKResumeModel alloc] init];
    
    model.birthYear = [self getString:[dict objectForKey:@"birthYear"]];
    model.cityId = [self getString:[dict objectForKey:@"cityId"]];
    model.cityName = [self getString:[dict objectForKey:@"cityName"]];
    model.companyType = [self getString:[dict objectForKey:@"companyType"]];
    model.companyTypeName = [self getString:[dict objectForKey:@"companyTypeName"]];
    model.educationType = [self getString:[dict objectForKey:@"educationType"]];
    model.educationTypeName = [self getString:[dict objectForKey:@"educationTypeName"]];
    model.experienceType = [self getString:[dict objectForKey:@"experienceType"]];
    model.experienceTypeName = [self getString:[dict objectForKey:@"experienceTypeName"]];
    model.headerImageName = [self getString:[dict objectForKey:@"headerImage"]];
    model.headerImageUrl = [self getString:[dict objectForKey:@"headerImageFull"]];
    model.introduce = [self getString:[dict objectForKey:@"intro"]];

    model.name = [self getString:[dict objectForKey:@"name"]];
    model.parentWorkClassId = [self getString:[dict objectForKey:@"parentWorkClassId"]];
    
    model.resumeId = [self getString:[dict objectForKey:@"resumeId"]];
    model.salaryType = [self getString:[dict objectForKey:@"salaryType"]];
    model.salaryTypeName = [self getString:[dict objectForKey:@"salaryTypeName"]];
    if ([[dict objectForKey:@"sex"] isEqualToString:@"0"]) {
        model.sex = @"男";
    }
    else{
        model.sex = @"女";
    }

    model.tel = [self getString:[dict objectForKey:@"tel"]];
    model.userId = [self getString:[dict objectForKey:@"userId"]];
    model.workClassId = [self getString:[dict objectForKey:@"workClassId"]];
    
    model.workId = [self getString:[dict objectForKey:@"workId"]];
    model.workName = [self getString:[dict objectForKey:@"workName"]];
    if ([[dict objectForKey:@"workStatus"] isEqualToString:@"0"]) {
        model.workStatus = @"离职";
    }
    else{
        model.workStatus = @"在职";
    }

    model.oldShowUrl = (NSArray *)[dict objectForKey:@"oldShowUrl"];
    model.schoolList = (NSArray *)[dict objectForKey:@"schoolList"];
    model.showUrl = (NSArray *)[dict objectForKey:@"showUrl"];
    model.tagList = (NSArray *)[dict objectForKey:@"tagList"];
    model.workList = (NSArray *)[dict objectForKey:@"workList"];

    return model;
}


- (void)getMyResumeSchoolListDataWithType:(NSString *)type backData:(IKRequestArrayData)callback
{
    NSString *url = [NSString stringWithFormat:@"%@type=%@",IKGetResumeSchoolListUrl,type];
    __block id dataResult = nil;

    [IKNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        dataResult = responseCache;

        BOOL success = [self requestDataSuccess:responseCache];
        
        NSArray *array = nil;
        if (success) {
            array = [self dealSchoolListData:responseCache];
        }
        else{
            array = @[[NSString stringWithFormat:@"%@",[responseCache objectForKey:@"errmsg"]]];
        }
        if (callback) {
            callback(array,success);
        }
    } success:^(id responseObject) {
        
        if (![dataResult isEqual:responseObject]) {
            BOOL success = [self requestDataSuccess:responseObject];
            
            NSArray *array = nil;
            if (success) {
                array = [self dealSchoolListData:responseObject];
            }
            else{
                array = @[[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"errmsg"]]];
            }
            if (callback) {
                callback(array,success);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (NSArray *)dealSchoolListData:(id)data
{
    NSArray *array = (NSArray *)[data objectForKey:@"data"];
    
    if (array.count == 0) {
        return nil;
    }
//    NSLog(@"arrayarray = %@",array);
    
    NSMutableArray *typeArray1 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray2 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray3 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray4 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray5 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray6 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray7 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray8 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray9 = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArray10 = [NSMutableArray arrayWithCapacity:5];

    for (int i = 0; i < array.count ; i ++) {
        
        id object = [array objectAtIndex:i];
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)object;
            
            IKSchoolListModel *model = [[IKSchoolListModel alloc] init];
            
            model.Id = [self getString:[dict objectForKey:@"id"]];
            model.logoImageUrl = [self getString:[dict objectForKey:@"logo_url"]];
            model.name = [self getString:[dict objectForKey:@"name"]];
            model.type = [self getString:[dict objectForKey:@"type"]];

            switch ([model.type integerValue]) {
                case 0:
                {
                    [typeArray1 addObject:model];
                    break;
                }
                case 1:
                {
                    [typeArray2 addObject:model];
                    break;
                }
                case 2:
                {
                    [typeArray3 addObject:model];
                    break;
                }
                case 3:
                {
                    [typeArray4 addObject:model];
                    break;
                }
                case 4:
                {
                    [typeArray5 addObject:model];
                    break;
                }
                case 5:
                {
                    [typeArray6 addObject:model];
                    break;
                }
                case 6:
                {
                    [typeArray7 addObject:model];
                    break;
                }
                case 7:
                {
                    [typeArray8 addObject:model];
                    break;
                }
                case 8:
                {
                    [typeArray9 addObject:model];
                    break;
                }
                case 9:
                {
                    [typeArray10 addObject:model];
                    break;
                }
                    
                default:
                    break;
            }
        }
    }
    
    
    
    return [NSArray arrayWithObjects:typeArray2,typeArray3,typeArray4,typeArray5,typeArray6,typeArray7,typeArray8,typeArray9,typeArray10,typeArray1, nil];
}





/*************** POST ***************************************************************/
#pragma mark - POST

- (void)postUserOprateToServer:(NSDictionary *)param
{
    [IKNetworkHelper POST:@"https://www.iamking.com.cn/index.php/UserOperate/addUserOperate" parameters:param success:^(id responseObject) {
        NSLog(@"postUserOprateToServer responseObject = %@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        
    }];
}


- (void)postFeedbackDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback
{
    [IKNetworkHelper POST:IKFeedbackUrl parameters:param success:^(id responseObject) {
        NSLog(@"postFeedbackDataToServer responseObject = %@",responseObject);
        
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback(success,[responseObject objectForKey:@"errmsg"]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        
    }];
}


- (void)postDeleteBlackListDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback
{
    NSLog(@"postDeleteBlackListDataToServer param = %@",param);

    [IKNetworkHelper POST:IKPostDeleteBlackListUrl parameters:param success:^(id responseObject) {
        NSLog(@"postDeleteBlackListDataToServer responseObject = %@",responseObject);
        
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback(success,[responseObject objectForKey:@"errmsg"]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        
    }];
}

- (void)postCancelAttentionListDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback
{
    [IKNetworkHelper POST:IKPostCancelAttentionUrl parameters:param success:^(id responseObject) {
        NSLog(@"postDeleteBlackListDataToServer responseObject = %@",responseObject);
        
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback(success,[responseObject objectForKey:@"errmsg"]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        
    }];
}


- (void)postCancelCollectionListDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback
{
    NSLog(@"postCancelCollectionListDataToServer = %@",param);
    [IKNetworkHelper POST:IKPostCancelCollectionUrl parameters:param success:^(id responseObject) {
        NSLog(@"postCancelCollectionListDataToServer responseObject = %@",responseObject);
        
        BOOL success = [self requestDataSuccess:responseObject];
        
        if (callback) {
            callback(success,[responseObject objectForKey:@"errmsg"]);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
        
    }];
}

- (void)postJobAppraiseDataToServer:(NSDictionary *)param callback:(void (^)(BOOL success,NSString *errorMessage))callback
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (callback) {
            callback(YES,@"");
        }
    });
    
//    [IKNetworkHelper POST:nil parameters:param success:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        
//    }];
}

/*************** POST ***************************************************************/


#pragma mark - Mothed

- (NSString *)getPositionFromPlist:(NSString *)key
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"IKWorkPosition" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
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
