//
//  TWSpringyFlowLayout.m
//  TransitionsDemo
//
//  Created by sohu on 14-2-12.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "BouncesFlowLayout.h"

@interface BouncesFlowLayout()
{
    UIDynamicAnimator * _animator;
}
@end

@implementation BouncesFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    if (!_animator)
	{
        self.itemSize = CGSizeMake(300, 50);
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *itemsArray = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        for (UICollectionViewLayoutAttributes * item in itemsArray) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
            spring.length = 0;
            spring.damping = 0.5;
            spring.frequency = 0.8;
            [_animator addBehavior:spring];
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
	return [_animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [_animator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView * scrollView = self.collectionView;
	CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    //ScrollView偏移的距离
	CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
	
	for (UIAttachmentBehavior *spring in _animator.behaviors)
	{
		CGPoint anchorPoint = spring.anchorPoint;
		CGFloat distanceFromTouch = fabsf(touchLocation.y - anchorPoint.y);
        //触摸点到spring的距离
        
		CGFloat scrollResistance = distanceFromTouch / 500.f; //放小倍数
        
		UICollectionViewLayoutAttributes *item = [spring.items firstObject];
		CGPoint center = item.center;
		center.y += scrollDelta * scrollResistance;
		item.center = center;
		
		[_animator updateItemUsingCurrentState:item];
	}
	
	return YES;
}
@end
