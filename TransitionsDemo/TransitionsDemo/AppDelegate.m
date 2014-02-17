//
//  AppDelegate.m
//  TransitionsDemo
//
//  Created by Colin Eberhardt on 10/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "AppDelegate.h"
#import "CECardsAnimationController.h"
#import "CEVerticalSwipeInteractionController.h"
#import <JSONKit/JSONKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //AppDelegateAccessor.navigationControllerAnimationController = [CECardsAnimationController new];
    //AppDelegateAccessor.navigationControllerInteractionController = [CEVerticalSwipeInteactionController new];
//    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    NSLog(@"Launched in background %d", UIApplicationStateBackground == application.applicationState);
    return YES;
}
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
{
    
    NSLog(@"Save completionHandler");
    self.backgroundSessionCompletionHandler = completionHandler;
    //Save completionHandler;
}
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
//    
//    NSURL *url = [[NSURL alloc] initWithString:@"https://api.weheartit.com/api/entries/recent?access_token=96f4c5c2a4206a8e2c480d10c6dbbb6de4fcd3f54dd9b962a42f1ec77e864646&entry_id=0&ignore_unsafe_content_setting=false&type=older"];
//    NSURLSessionDataTask * task = [session dataTaskWithURL:url
//                                        completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
//                                            
//                                        if (error) {
//                                                completionHandler(UIBackgroundFetchResultFailed);
//                                                return;
//                                            }
//                                            NSDictionary * hasNewData = [data objectFromJSONData];
//                                            if (hasNewData) {
//                                                NSLog(@"%@",hasNewData);
//                                                completionHandler(UIBackgroundFetchResultNewData);
//                                            } else {
//                                                completionHandler(UIBackgroundFetchResultNoData);
//                                            }
//                                        }];
//    
//    // Start the task
//    [task resume];
}



#pragma mark - URLSecssion

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSLog(@"%@",[location resourceSpecifier]);
    NSLog(@"LLL %@ ---%d",location,[fm fileExistsAtPath:[location absoluteString]]);
    
    NSData * data = [NSData dataWithContentsOfURL:location];
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* homeDir = [paths objectAtIndex:0];
    homeDir = [homeDir stringByAppendingPathComponent:@"1.png"];
    homeDir = [homeDir stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        if (![fm fileExistsAtPath:homeDir]) {
            NSLog(@"%@",homeDir);
            [fm createFileAtPath:homeDir contents:nil attributes:nil];
        }

    }
}
- (void)  URLSession:(NSURLSession *)session
        downloadTask:(NSURLSessionDownloadTask *)downloadTask
   didResumeAtOffset:(int64_t)fileOffset
  expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}
- (void)         URLSession:(NSURLSession *)session
               downloadTask:(NSURLSessionDownloadTask *)downloadTask
               didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten
  totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}
@end
