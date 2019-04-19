//
//  ALNetWork.h
//  ALPHA
//
//  Created by mac on 16/6/2.
//  Copyright © 2016年 king. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void (^WTRequestFinishedBlock)(NSURLResponse *response,NSDictionary *data);
typedef void (^WTRequestFailedBlock)(NSURLResponse *response,NSError *error);

@interface ALNetWork : NSObject
+ (instancetype)share;
//-(NSURLRequest*)getWithURL:(NSString*)url
//                        parameters:(NSDictionary*)parameters
//                          finished:(WTRequestFinishedBlock)finished
//                            failed:(WTRequestFailedBlock)failed;

//-(NSURLRequest*)postWithURL:(NSString*)url
//                 parameters:(NSDictionary*)parameters
//                   finished:(WTRequestFinishedBlock)finished
//                     failed:(WTRequestFailedBlock)failed;

-(void)getWithURL:(NSString*)url
                parameters:(NSDictionary*)parameters
                  finished:(WTRequestFinishedBlock)finished
                    failed:(WTRequestFailedBlock)failed;

-(void)postWithURL:(NSString*)url
                 parameters:(NSDictionary*)parameters
                   finished:(WTRequestFinishedBlock)finished
                     failed:(WTRequestFailedBlock)failed;

@property (nonatomic,assign) BOOL isLogin;
@end
