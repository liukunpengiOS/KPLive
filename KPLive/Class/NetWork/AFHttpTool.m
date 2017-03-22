//
//  KPHttpTool.m
//  KPLive
//
//  Created by kunpeng on 2017/3/16.
//  Copyright © 2017年 liukunpeng. All rights reserved.
//

#import "AFHttpTool.h"
#import "AFHttpClient.h"
#import <AFNetworking/AFNetworking.h>

static NSString * kBaseUrl = SERVER_HOST;
@interface AFHttpTool ()

@end

@implementation AFHttpTool

+ (void)getWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
            success:(successBlock)success
            failure:(failureBlock)failure {

    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient shareClient] GET:url parameters:parameters progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                
                                success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

+ (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(successBlock)success
             failure:(failureBlock)failure {
    
    NSString *url = [kBaseUrl stringByAppendingPathComponent:path];
    [[AFHttpClient shareClient] POST:url
                          parameters:parameters
                            progress:nil
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                                 success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

+ (void)downloadWithPath:(NSString *)path
                 success:(successBlock)success
                 failure:(failureBlock)failure
                progress:(downloadProgressBlock)progress{
    
    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient shareClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //获取沙盒路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory
                                                                              inDomain:NSUserDomainMask
                                                                     appropriateForURL:nil
                                                                                create:NO
                                                                                 error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            
            failure(error);
        }else {
            
            success(filePath.path);
        }
    }];
    
    [downloadTask resume];
}

+ (void)uploadImageWithPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                   imageKey:(NSString *)imageKey
                      image:(UIImage *)image
                    success:(successBlock)success
                    failure:(failureBlock)failure
                   progress:(uploadProgressBlock)progress {
    
    NSString *urlString = [kBaseUrl stringByAppendingPathComponent:path];
    NSData *data = UIImagePNGRepresentation(image);
    [[AFHttpClient shareClient] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imageKey fileName:@"01.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

@end
