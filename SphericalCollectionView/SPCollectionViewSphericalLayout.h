//
//  SPCollectionViewSphericalLayout.h
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/8/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CATransform3D.h>
#import "SPCoordinateManager.h"



@interface SPCollectionViewSphericalLayout : UICollectionViewFlowLayout
@property (nonatomic,assign) SPCoordinate originAxis;
@end
