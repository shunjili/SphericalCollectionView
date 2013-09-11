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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blueColor]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _scrollView = [[UIScrollView alloc] initWithFrame:[self bounds]];
    [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [_scrollView setBackgroundColor: [UIColor clearColor]];
    [_scrollView setDelegate:self];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width*2, _scrollView.frame.size.height *2)];
    [self addSubview:_scrollView];
}


#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    SPCoordinate axis;
    axis.x = sqrtf(fabsf(scrollView.contentOffset.x)/(fabsf(scrollView.contentOffset.y) + fabsf(scrollView.contentOffset.x) + 0.00001));
    axis.z = sqrtf(fabsf(scrollView.contentOffset.y)/(fabsf(scrollView.contentOffset.y) + fabsf(scrollView.contentOffset.x)+ 0.00001));
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
