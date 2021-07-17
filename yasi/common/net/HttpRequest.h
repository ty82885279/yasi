//
//  HttpRequest.h
//  网络请求1116Demo
//
//  Created by 铅笔 on 15/11/16.
//  Copyright © 2015年 铅笔. All rights reserved.
//
//网络请求
#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <UIKit/UIKit.h>

/**多图上传Block*/
typedef void(^HttpUploadSuccessBlock)(id Json);
typedef void(^HttpUploadFailureBlock)();


typedef void (^transferValue) (id obj,NSError* error);

/** 请求成功的Block */
typedef void(^requestSuccessBlock)(id dic);

/** 请求失败的Block */
typedef void(^requestFailureBlock)(NSError *error);

/** 请求任务 */
typedef NSURLSessionTask PPURLSessionTask;

@interface HttpRequest : NSObject

+(HttpRequest *) shardWebUtil;

+ (AFHTTPSessionManager *)sharedHttpSession;

/**检测网路状态**/
+ (void)netWorkStatus;

/**
 *JSON方式获取数据 GET
 *urlStr:获取数据的url地址
 *
 */
-(void)getNetworkRequestURLString:(NSString *) urlString  andParas:(id) params andTransferGottenData:(transferValue) transfer;

/**
 *JSON方式获取数据 POST
 *urlStr:获取数据的url地址
 *
 */
-(void)postNetworkRequestURLString:(NSString *) urlString  andParas:(id) params andTransferGottenData:(transferValue) transfer;

/**
 *JSON方式获取数据 GET
 *url_path:获取数据的url地址
 *有返回值 类型
 */
- (PPURLSessionTask *)getNetworkRequestURLString:(NSString *)url_path parameters:(id)parameters success:(void (^)(id obj))success fail:(void (^)(NSError *error))fail;

/**
 *JSON方式获取数据 POST
 *url_path:获取数据的url地址
 *有返回值 类型
 */
- (PPURLSessionTask *)postNetworkRequestURLString:(NSString *)url_path parameters:(id)parameters success:(void (^)(id obj))success fail:(void (^)(NSError *error))fail;

/**
 *
 *	取消所有请求
 */
- (void)cancelAllRequest;

/**
 *
 *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的HYBURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *	@param url				URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
- (void)cancelRequestWithURL:(NSString *)url;


/**
 *  上传图片
 *
 *  @param url        请求url
 *  @param image      要上传的文件流
 *  @param completion 文件上传成功的回调
 *  @param errorBlock 文件上传失败的回调
 *
 *  @return 请求体
 */
- (PPURLSessionTask *)uploadImageWithUrl:(NSString *)url
                                    WithParams:(NSDictionary*)params
                                         image:(NSData *)imageData
                                      filename:(NSString *)name
                                      mimeType:(NSString *)mimetype
                                    completion:(requestSuccessBlock)completion
                                    errorBlock:(requestFailureBlock)errorBlock;


/**
 *  上传图片(多张)
 *
 *  @param path    路径
 *  @param photos  图片数组
 *  @param params  参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)uploadImageWithPath:(NSString *)path photos:(NSArray *)photos params:(NSDictionary *)params success:(HttpUploadSuccessBlock)success failure:(HttpUploadFailureBlock)failure;


/**
 *  上传音视频文件
 *
 *  @param url        请求url
 *  @param image      要上传的文件流
 *  @param completion 文件上传成功的回调
 *  @param errorBlock 文件上传失败的回调
 *
 *  @return 请求体
 */
- (PPURLSessionTask *)uploadVedioWithUrl:(NSString *)url
                                    WithParams:(NSDictionary*)params
                                         image:(NSData *)vedioData
                                      filename:(NSString *)name
                                      mimeType:(NSString *)mimetype
                                    completion:(requestSuccessBlock)completion
                                    errorBlock:(requestFailureBlock)errorBlock;


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString; //json转字典

+(NSString *)base64DecodeString:(NSString *)string; //base64解码

+(NSString *)base64EncodeString:(NSString *)string; //base64编码


@end
