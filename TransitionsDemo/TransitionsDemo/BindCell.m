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
        iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:iconImageView];
        iconImageView.layer.cornerRadius = 20.f;
        iconImageView.layer.masksToBounds = YES;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        nameLabel.textColor = [UIColor redColor];
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
