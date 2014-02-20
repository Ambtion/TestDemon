//
//  ViewController.m
//  ViewControllerTransitions
//
//  Created by Colin Eberhardt on 08/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CEBaseInteractionController.h"
#import "BindCell.h"
#import "BouncesFlowLayout.h"
#import "FontViewDonwload.h"
#import "DownloadController.h"
#import "DynamicAnimatorController.h"
#import "DocumentController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * conlectView;
    NSArray * nameArray;
}
@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Collection View";
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"messages_bg_2.png"]];
	backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:backgroundImageView];
    [self addEmotionEffestToView:backgroundImageView];
    
    
    conlectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 320, CGRectGetHeight(self.view.bounds) - 64) collectionViewLayout: [[BouncesFlowLayout alloc] init]];
    conlectView.backgroundColor = [UIColor clearColor];
    conlectView.delegate = self;
    conlectView.dataSource = self;
    
    [conlectView registerClass:[BindCell class] forCellWithReuseIdentifier:@"BindCell"];
    [self.view addSubview:conlectView];
    nameArray = @[@"字体",@"相册",@"后台下载",@"DynamicAnimator",@"UIDocumentInteractionController",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义",@"自定义"];
}

- (void)addEmotionEffestToView:(UIView *)view
{
	UIInterpolatingMotionEffect *interpolationHorizontal = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    interpolationHorizontal.minimumRelativeValue = @-20.0;
    interpolationHorizontal.maximumRelativeValue = @20.0;
	
    UIInterpolatingMotionEffect *interpolationVertical = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    interpolationVertical.minimumRelativeValue = @-20.0;
    interpolationVertical.maximumRelativeValue = @20.0;
    [view addMotionEffect:interpolationHorizontal];
    [view addMotionEffect:interpolationVertical];
}


#pragma maak - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [nameArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BindCell * bindcell = [conlectView dequeueReusableCellWithReuseIdentifier:@"BindCell" forIndexPath:indexPath];
    bindcell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [bindcell setIcon:@"1.jpg" name:nameArray[indexPath.row]];
    return bindcell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"])
        return YES;
    return NO;
}
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    
}
- (void)copy:(id)sender
{
    NSLog(@"瞎写的东西,copy什么啊");
    [[UIPasteboard generalPasteboard] setString:@"瞎写的东西,copy什么啊"];
    [self showMessage:@"瞎写的东西,copy到了啊"];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.alpha = 0.5;
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.alpha = 1.0;
}

#pragma mark Action
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[FontViewDonwload alloc] init] animated:YES];
            break;
        case 1:
            if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"com.sohu.app:"]]) {
                [self showMessage:@"请确认搜狐相册已经安装"];
            }
            break;
        case 2:
            [self.navigationController pushViewController:[[DownloadController alloc] init] animated:YES];
            break;
            case 3:
            [self.navigationController pushViewController:[[DynamicAnimatorController alloc] init] animated:YES];
        case 4:
            [self.navigationController pushViewController:[[DocumentController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}
- (void)showMessage:(NSString *)msg
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"出问题了" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];

}
#pragma mark -
#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowSettings"]) {
        UIViewController *toVC = segue.destinationViewController;
        toVC.transitioningDelegate = self;
    }
    
    [super prepareForSegue:segue sender:sender];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (AppDelegateAccessor.settingsInteractionController) {
        [AppDelegateAccessor.settingsInteractionController wireToViewController:presented forOperation:CEInteractionOperationDismiss];
    }
    AppDelegateAccessor.settingsAnimationController.reverse = NO;
    return AppDelegateAccessor.settingsAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AppDelegateAccessor.settingsAnimationController.reverse = YES;
    return AppDelegateAccessor.settingsAnimationController;
 }

 - (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
     return AppDelegateAccessor.settingsInteractionController && AppDelegateAccessor.settingsInteractionController.interactionInProgress ? AppDelegateAccessor.settingsInteractionController : nil;
}

@end
