//
//  DocumentController.m
//  TransitionsDemo
//
//  Created by sohu on 14-2-20.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "DocumentController.h"

@interface DocumentController()
{
    UIDocumentInteractionController * doc;
}
@end
@implementation DocumentController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark TableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"阅览文档(图片)方式";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = indexPath.row ? @"QLPreviewController" : @"UIDocumentInteractionController";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
        doc = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
        doc.delegate = self;
//        [doc presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        [doc presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];

    }else{
        QLPreviewController *previewController = [[QLPreviewController alloc] init];
        previewController.dataSource = self;
        previewController.delegate = self;
        //
        // start previewing the document at the current section index
        previewController.currentPreviewItemIndex = indexPath.row;
        [[self navigationController] pushViewController:previewController animated:YES];
    }
}
#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return 2;
}
- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
    // if the preview dismissed (done button touched), use this method to post-process previews
}
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    return  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]];
}

#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.view.frame;
}
@end
