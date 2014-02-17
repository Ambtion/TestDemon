//
//  BindCell.m
//  TransitionsDemo
//
//  Created by sohu on 14-1-9.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "BindCell.h"
#import <QuartzCore/QuartzCore.h>

@interface BindCell()
{
    UIImageView * iconImageView;
    UILabel * nameLabel;
}
@end

@implementation BindCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.height - 10, frame.size.height - 10)];
        [self.contentView addSubview:iconImageView];
        iconImageView.layer.cornerRadius = 15.f;
        iconImageView.layer.masksToBounds = YES;
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.height, 0, self.bounds.size.width - frame.size.height, frame.size.height)];
        nameLabel.textColor = [UIColor blackColor];
        
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:nameLabel];
        
    }
    return self;
}
- (void)setIcon:(NSString *)imageStr name:(NSString *)name
{
    iconImageView.image = [UIImage imageNamed:imageStr];
    nameLabel.text = name;
}
@end
