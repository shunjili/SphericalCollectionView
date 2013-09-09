//
//  SPCollectionViewSphericalLayout.m
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/8/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import "SPCollectionViewSphericalLayout.h"

@implementation SPCollectionViewSphericalLayout

- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}


- (CGPoint) centerForIndex: (NSUInteger) index withMaxIndex: (NSUInteger) max
{
    CGFloat radius = MIN(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)/2 - 20;
    CGFloat angle = (index + 0.01f)/ max * M_PI *2;
    CGFloat xOffSet = cosf(angle) *radius;
    CGFloat yOffSet = sinf(angle) *radius;
    CGPoint point = self.collectionView.center;
    point.x +=  xOffSet;
    point.y += yOffSet;
    return point;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes =  [super layoutAttributesForElementsInRect:rect];
    NSUInteger count = [attributes count];
    
    [attributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attr = (UICollectionViewLayoutAttributes*) obj;
        NSLog(@"x: %f, y: %f", attr.center.x, attr.center.y);

        attr.alpha = (idx+0.01) / [attributes count];
        attr.center = [self centerForIndex:idx withMaxIndex:count];
    }];
    
    return attributes;
}

@end
