//
//  DocumentController.h
//  TransitionsDemo
//
//  Created by sohu on 14-2-20.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
//官方文档
//https://developer.apple.com/library/ios/Documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Articles/RegisteringtheFileTypesYourAppSupports.html#//apple_ref/doc/uid/TP40010411-SW1
@interface DocumentController : UITableViewController<UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@end
