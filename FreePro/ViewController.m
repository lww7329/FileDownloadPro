//
//  ViewController.m
//  FreePro
//
//  Created by wei.z on 2019/4/17.
//  Copyright © 2019 wei.z. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self freerequest2];
}

-(void)freerequest{
    //https://vod.zjstv.com/video/2019/04/12/ee000b64590e9a4e91f572ee780259f0.mp4
    NSString *str = @"http://www.baidu.com";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    for (int i=0; i<10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d---",i);
            if(error){
                NSLog(@"%@",error);
            }
        }];
        
        [task resume];
    }
    NSLog(@"end");
}



-(void)freerequest2{
    
    __block long long second;
    __block int64_t download;
    __block long long totalsecond=[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000] longLongValue];
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@"https://vod.zjstv.com/video/2019/04/12/ee000b64590e9a4e91f572ee780259f0.mp4"];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if(download){
            long long tempsecond=[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000] longLongValue];
            int64_t tempdata=downloadProgress.completedUnitCount;
            long long t=tempsecond-second;
            if(t>0){
                int64_t d=tempdata-download;
                NSLog(@"已下载:%.2fM 文件大小:%.2fM 下载进度:%.2f%% 实时网速:%.0fk/s 总计用时:%.0fs",1.0 * downloadProgress.completedUnitCount/1024/1024,1.0 * downloadProgress.totalUnitCount/1024/1024,1.0 * downloadProgress.completedUnitCount*100 / downloadProgress.totalUnitCount,d*1000/1024/t*1.0,1.0*(tempsecond-totalsecond)/1000);
                second=tempsecond;
                download=tempdata;
            }
        }else{
            second=[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]*1000] longLongValue];
            download=downloadProgress.completedUnitCount;
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //设置下载路径，并将文件写入沙盒，最后返回NSURL对象
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"targetPath:\n%@",targetPath);
        NSLog(@"fullPath:\n%@",fullPath);
        return [NSURL fileURLWithPath:fullPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //NSLog(@"完成：%@--%@",response,filePath);
        NSHTTPURLResponse *response1 = (NSHTTPURLResponse *)response;
        NSInteger statusCode = [response1 statusCode];
        if (statusCode == 200) {

        }else{
            //
        }
        
    }];
    
    //5.开始启动下载任务
    [task resume];
}
@end
