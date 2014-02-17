//
//  CircleLayout.m
//  TransitionsDemo
//
//  Created by sohu on 14-1-9.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "CircleLayout.h"

@implementation CircleLayout

//为创建Circle做准备
- (void)prepareLayout
{
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    CGFloat centerIndicator = MIN(size.width/2.f, size.height/2.f);
    _center = CGPointMake(centerIndicator,centerIndicator);
    _radius = MIN(size.width, size.height) / 2.5;
}

//设置collectionViewContentsize
- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.frame.size;
    size.height *= (_cellCount / 15 + 1);
    return size;
}

//设置UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(30 + 20, 40);
//    attributes.transform3D = CATransform3DMakeRotation(M_PI /(random() % 4 + 3), 1, 1, 0);
    attributes.center = CGPointMake(_center.x - _radius * cosf(2 * indexPath.item * M_PI / 15),
                                    _center.y  - _radius * sinf(2 * indexPath.row * M_PI / 15) + (indexPath.row / 15) * 320);
    
    return attributes;
}

//设置layoutAttributesForElementsInRect
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = [NSMutableArray array];
    for(NSInteger i = 0; i < self.cellCount; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    return proposedContentOffset;
}
#pragma mark --
#pragma mark  Layout init  & final

//复写initialLayoutAttributesForInsertedItemAtIndexPath
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x, _center.y);
    return attributes;
}

//复写finalLayoutAttributesForDeletedItemAtIndexPath

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}

@end
