//
//  DownloadController.h
//  TransitionsDemo
//
//  Created by sohu on 14-2-11.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadController : UIViewController<NSURLSessionDownloadDelegate>
@property (strong, nonatomic) IBOutlet UIProgressView *progress;
@property (strong, nonatomic) UIImageView *image;
- (IBAction)download:(UIButton *)sender;
@end
