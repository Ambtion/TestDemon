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
#import "CircleLayout.h"

@interface ViewController () <UIViewControllerTransitioningDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * conlectView;
}
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Collection View";
    CircleLayout * circleLayout = [[CircleLayout alloc] init];
    conlectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 320, CGRectGetHeight(self.view.bounds) - 64) collectionViewLayout:circleLayout];
    conlectView.delegate = self;
    conlectView.dataSource = self;
    conlectView.backgroundColor = [UIColor grayColor];
    [conlectView registerClass:[BindCell class] forCellWithReuseIdentifier:@"BindCell"];
    [self.view addSubview:conlectView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BindCell * bindcell = [conlectView dequeueReusableCellWithReuseIdentifier:@"BindCell" forIndexPath:indexPath];
    [bindcell setIcon:@"1.jpeg" name:@"kk"];
    return bindcell;
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
