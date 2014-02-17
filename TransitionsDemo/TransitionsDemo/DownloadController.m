//
//  DownloadController.m
//  TransitionsDemo
//
//  Created by sohu on 14-2-11.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "DownloadController.h"
#import "AppDelegate.h"

@interface DownloadController ()

@end

@implementation DownloadController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.progress setProgress:0.f];
}

- (IBAction)download:(UIButton *)sender {
    self.image.backgroundColor = [UIColor whiteColor];
    NSString * downloadURLString = [NSString stringWithFormat:@"http://ww3.sinaimg.cn/mw600/bce52ee1jw1e2xe4zdqarj.jpg"];
    NSURL* downloadURL = [NSURL URLWithString:downloadURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    NSURLSessionDownloadTask * task = [[self backgroundURLSession] downloadTaskWithRequest:request];
    [task resume];
}
- (NSURLSession *)backgroundURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *identifier = @"example.demon";
        NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration backgroundSessionConfiguration:identifier];
        session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                delegate:self
                                           delegateQueue:[NSOperationQueue mainQueue]];
    });
    
    return session;
}

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session

{
    [self endTask];
}
#pragma mark -Delegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"Temporary File :%@\n", location);
    NSError *err = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL *docsDirURL = [NSURL fileURLWithPath:[docsDir stringByAppendingPathComponent:@"1.jpeg"]];
    if ([fileManager fileExistsAtPath:[docsDir stringByAppendingPathComponent:@"1.jpeg"]]) {
        [fileManager removeItemAtURL:docsDirURL error:nil];
    }
    if ([fileManager moveItemAtURL:location
                             toURL:docsDirURL
                             error: &err])
    {
        NSLog(@"File is saved to =%@",docsDir);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refeshImageView];
        });
    }
    else
    {
        NSLog(@"failed to move: %@",[err userInfo]);
    }
}
- (void)refeshImageView
{
//    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSURL *docsDirURL = [NSURL fileURLWithPath:[docsDir stringByAppendingPathComponent:@"1.jpeg"]];
//    NSData * data = [NSData dataWithContentsOfURL:docsDirURL];
//    UIImage * image = [UIImage imageWithData:data];
//    self.image.backgroundColor = [UIColor redColor];
//    [self endTask];
    // self.image.image = image;
}

- (void)  URLSession:(NSURLSession *)session
        downloadTask:(NSURLSessionDownloadTask *)downloadTask
   didResumeAtOffset:(int64_t)fileOffset
  expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

- (void)URLSession:(NSURLSession *)session
               downloadTask:(NSURLSessionDownloadTask *)downloadTask
               didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten
  totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(),^ {
        [self.progress setProgress:progress animated:YES];
    });
    NSLog(@"Progress =%f",progress);
    NSLog(@"Received: %lld bytes (Downloaded: %lld bytes)  Expected: %lld bytes.\n",
          bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}

#pragma mark EndTask
- (void)endTask
{
    AppDelegate * delegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate.backgroundSessionCompletionHandler)
    {
        void (^handler)() = delegate.backgroundSessionCompletionHandler;
        handler();
    }}
@end
