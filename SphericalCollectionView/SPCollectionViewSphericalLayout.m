//
//  SPCollectionViewSphericalLayout.m
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/8/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import "SPCollectionViewSphericalLayout.h"
#import "SPCoordinateManager.h"
#import <QuartzCore/QuartzCore.h>
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

        attr.center = self.collectionView.center;

        SPCoordinate coordinate = [[SPCoordinateManager sharedManager] coordinateForIndex:(idx+1) withMaximumIndex:count];
        NSLog(@"x: %f, y: %f, z: %f", coordinate.x, coordinate.y, coordinate.z);
        CGFloat radius = 200;
        CGFloat shrinkFactor =(coordinate.z + 1)/2 + 0.5;
        attr.transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(shrinkFactor, shrinkFactor), coordinate.x*radius/shrinkFactor, coordinate.y*radius/shrinkFactor);
        
//        attr.transform3D = CATransform3DTranslate(CATransform3DMakeRotation((1-fabs(coordinate.z) * M_PI_4), coordinate.y, coordinate.x, 0.0), coordinate.x *radius, coordinate.y*radius, coordinate.z*radius);
        attr.alpha = (coordinate.z +1)/2;
    }];
    
    return attributes;
}

@end
