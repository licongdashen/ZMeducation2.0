//
//  RequestOperationManager.h
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/20.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface RequestOperationManager : AFHTTPSessionManager

/**
 请求数据结果block
 **/
typedef void (^successBlock) (id result);
typedef void (^failtureBlock) (id result);

+ (RequestOperationManager *)shareInstance;

/**
 用户登录请求
 
 @param parameterDic 请求字典
 @param successBlock 成功返回
 @param failtureBlock 失败返回
 */
+(void)getParametersDic:(NSDictionary *)parameterDic
                      success:(void (^)(NSMutableDictionary *result))successBlock
                     failture:(void (^)(id result))failtureBlock;

@end
