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


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes =  [super layoutAttributesForElementsInRect:rect];
    [attributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"loop");
        UICollectionViewLayoutAttributes *attr = (UICollectionViewLayoutAttributes*) obj;
        attr.alpha = (idx+0.01) / [attributes count];
    }];
    return attributes;
}

@end
