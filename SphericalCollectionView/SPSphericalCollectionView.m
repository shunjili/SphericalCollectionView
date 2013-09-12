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
        [_scrollView setContentSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        
        [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [_scrollView addGestureRecognizer:tapRecognizer];
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if ([_scrollView contentOffset].x < 10 || _scrollView.contentOffset.y < 10) {
        [_scrollView setContentOffset:CGPointMake(10000,10000)];
    }

}


#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    SPCoordinate axis;
    CGSize scrollViewSize = scrollView.frame.size;
    axis.x = sinf(-((fmodf(scrollView.contentOffset.x,  scrollViewSize.width* M_PI)/(scrollViewSize.width* M_PI))-0.5) * 2*  M_PI);
    axis.z = cosf(-((fmodf(scrollView.contentOffset.x,  scrollViewSize.width* M_PI)/(scrollViewSize.width* M_PI))-0.5) * 2*  M_PI);
    axis.y = 0;
    SPCollectionViewSphericalLayout *layout = (SPCollectionViewSphericalLayout *) self.collectionViewLayout;
    if (axis.x ==0 && axis.y == 0 && axis.z == 0) {
        return;
    }else
    {
        [layout setOriginAxis:axis];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [scrollView setContentOffset: CGPointMake(CGFLOAT_MAX/2, CGFLOAT_MAX/2)];
}
                                                 
                                
#pragma mark Manage Tap Gesture Recognizers

- (void) tapped:(UITapGestureRecognizer*) sender
{
    NSLog(@"tapped");

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
