//
//  GravityController.m
//  TransitionsDemo
//
//  Created by sohu on 14-2-13.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "GravityController.h"

@interface GravityController ()

@end

@implementation GravityController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView  *gravityView = [ [ UIView alloc ] initWithFrame : CGRectMake (0.0f, 0.0f, 100.0f, 100.0f )] ;
    gravityView.backgroundColor = [UIColor redColor];
    gravityView.center  = self.view.center ;
    [ self.view addSubview : gravityView ] ;
    UIDynamicAnimator  *myAnimator = [ [ UIDynamicAnimator alloc ]  initWithReferenceView : self.view ] ;
    
    UIGravityBehavior *myGravity = [ [ UIGravityBehavior alloc ]  initWithItems : @[ gravityView ] ] ;
    
    [ myAnimator addBehavior : myGravity ] ;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
