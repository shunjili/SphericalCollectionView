//
//  SPSphericalCollectionView.m
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/8/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import "SPSphericalCollectionView.h"
#import "SPCoordinateManager.h"
#import "SPCollectionViewSphericalLayout.h"
@implementation SPSphericalCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blueColor]];
        _scrollView = [[UIScrollView alloc] initWithFrame:[self bounds]];
        [_scrollView setBackgroundColor: [UIColor clearColor]];
        [_scrollView setDelegate:self];
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width*2, _scrollView.frame.size.height *2)];

}


#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    SPCoordinate axis;
    CGSize scrollViewSize = scrollView.frame.size;
    axis.x = MAX(1-(scrollView.contentOffset.x/ scrollViewSize.width), -1);
    axis.x = MIN(axis.x, 1);
    axis.z = sqrtf(1- powf(axis.x, 2));
    axis.y = 0;
    SPCollectionViewSphericalLayout *layout = (SPCollectionViewSphericalLayout *) self.collectionViewLayout;
    if (axis.x ==0 && axis.y == 0 && axis.z == 0) {
        return;
    }else
    {
        [layout setOriginAxis:axis];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
