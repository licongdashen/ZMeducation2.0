//
//  RequestOperationManager.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "RequestOperationManager.h"
@interface RequestOperationManager()

@property (nonatomic, strong) NSString *urlPath;

@end
@implementation RequestOperationManager

static RequestOperationManager *sessionManager;

+(RequestOperationManager *)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sessionManager = [[RequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:DEF_IPAddress]];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html",@"application/octet-stream",@"image/jpeg",@"image/png", nil];
        sessionManager.requestSerializer.timeoutInterval = 10;
    });
    
    return sessionManager;
}

//请求错误处理
+ (void)requestError:(NSError *)error task:(NSURLSessionDataTask *_Nonnull)task failHandle:(failtureBlock)failHandle
{
    //    if(error.code == kCFURLErrorNotConnectedToInternet)
    //    {
    //        [CACUtility showTips:@"网络不可用，请检查网络连接"];
    //    }else if (error.code == kCFURLErrorTimedOut)
    //    {
    //        [CACUtility showTips:@"网络请求超时"];
    //    }else if (error.code == kCFURLErrorCannotConnectToHost)
    //    {
    //        [CACUtility showTips:@"网络不可用，请检查网络连接"];
    //    }else
    //    {
    //        NSLog(@"responseError===%@",error);
    //    }
    NSLog(@"responseError===%@",error);
    
    failHandle(error);
}

//请求成功处理
+ (void)requestSuccess:(id)responseObject task:(NSURLSessionDataTask *_Nonnull)task finishHandle:(successBlock)finishHandle
{
    if (!responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            finishHandle(nil);
        });
        return;
    }
    NSLog(@"responseDic===%@",responseObject);
    dispatch_async(dispatch_get_main_queue(), ^{
        finishHandle(responseObject);
    });
}

//log请求的url
+ (void)logUrlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters
{
    
    sessionManager.urlPath = urlPath;
    
    NSMutableString *tempUrl = [NSMutableString stringWithFormat:@"%@", urlPath];
    for (int i=0; i<parameters.allKeys.count; i++) {
        if (i > 0) {
            [tempUrl appendString:@"&"];
        } else {
            [tempUrl appendString:@"?"];
        }
        [tempUrl appendFormat:@"%@=%@", parameters.allKeys[i], parameters.allValues[i]];
    }
    NSLog(@"requestUrl:%@",tempUrl);
}

//post请求
+ (AFHTTPSessionManager *)requestPostWithParameters:(NSDictionary *)parameters
                                          urlString:(NSString *)urlString
                                       finishHandle:(void (^)(id result))finishHandle
                                         failHandle:(void (^)(id result))failHandle
{
    AFHTTPSessionManager *manager = [RequestOperationManager shareInstance];
    
    NSLog(@"requestUrl:%@",parameters);
    [CACUtility showMBProgress:DEF_MyAppDelegate.window message:@""];

    [manager POST:DEF_IPAddress parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];

        [RequestOperationManager requestSuccess:responseObject task:task finishHandle:finishHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CACUtility hideMBProgress:DEF_MyAppDelegate.window];
        [RequestOperationManager requestError:error task:task failHandle:failHandle];
    }];
    
    // 添加到任务字典中保存
    
    return manager;
}

/**
 用户登录请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getParametersDic:(NSDictionary *)parameterDic
                      success:(void (^)(NSMutableDictionary *result))successBlock
                     failture:(void (^)(id result))failtureBlock
{
    [RequestOperationManager requestPostWithParameters:parameterDic
                                             urlString:@"M001"
                                          finishHandle:^(id result) {
                                              successBlock(result);
                                          } failHandle:^(id result) {
                                              failtureBlock(result);
                                          }];
}
@end
