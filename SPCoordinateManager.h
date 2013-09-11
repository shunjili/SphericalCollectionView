//
//  SPCoordinateManager.h
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/9/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPConstants.h"


//Coodinate Structs

typedef struct {
	CGFloat x;
	CGFloat y;
    CGFloat z;
} SPCoordinate;

@interface SPCoordinateManager : NSObject

@property (nonatomic, strong) NSDictionary *coordDict;
+ (SPCoordinateManager *)sharedManager;
- (SPCoordinate) coordinateForIndex: (NSUInteger) index withMaximumIndex: (NSUInteger)max;
- (SPCoordinate) coordinateForIndex:(NSUInteger)index withMaximumIndex:(NSUInteger)max originAxis:(SPCoordinate) originAxis;

@end
