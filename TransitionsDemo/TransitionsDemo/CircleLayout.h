//
//  CircleLayout.h
//  TransitionsDemo
//
//  Created by sohu on 14-1-9.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic,assign) CGPoint center;
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) NSInteger cellCount;

@end
