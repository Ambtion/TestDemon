//
//  DynamicAnimatorController.m
//  TransitionsDemo
//
//  Created by sohu on 14-2-13.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "DynamicAnimatorController.h"
#import "GravityController.h"


@interface DynamicAnimatorController ()
{
    NSArray * dataSource;
}
@end

@implementation DynamicAnimatorController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataSource = @[@"自由落体",@"碰撞",@"推移",@"关联"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",dataSource.count);
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    // Configure the cell...
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[GravityController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}
@end
