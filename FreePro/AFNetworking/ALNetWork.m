//
//  ALNetWork.m
//  ALPHA
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 king. All rights reserved.
//

#import "ALNetWork.h"
//#import "WTRequestCenter.h"StartViewController
#import "AppDelegate.h"

@interface ALNetWork ()<UIAlertViewDelegate>
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation ALNetWork

+ (instancetype)share
{
    static ALNetWork *netWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWork = [[ALNetWork alloc] init];
        [netWork manager];
    });
    return netWork;
}

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        _manager = [AFHTTPSessionManager manager];
        securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy = securityPolicy;
        _manager.securityPolicy.validatesDomainName = NO;
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _manager;
}

- (void)getWithURL:(NSString *)url parameters:(NSDictionary *)parameters finished:(WTRequestFinishedBlock)finished failed:(WTRequestFailedBlock)failed
{
    NSLog(@"*****%@",url);
    [self.manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(nil,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed (nil,error);
    }];
}

- (void)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters finished:(WTRequestFinishedBlock)finished failed:(WTRequestFailedBlock)failed
{
    [self.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(nil,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed (nil,error);
    }];
}
@end
