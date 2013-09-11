//
//  SPCoordinateManager.m
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/9/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import "SPCoordinateManager.h"
#import <QuartzCore/QuartzCore.h>

static SPCoordinate SPCoordinateZAxis = {
    .x = 0.0f,
    .y = 0.0f,
    .z = 1.0f,
};

@implementation SPCoordinateManager



-(id) init
{
    self = [super init];
    if (self) {
        //loading the coordinates plist
        NSString *path = [[NSBundle mainBundle] pathForResource:@"coordinate" ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
        [self setCoordDict:dictionary];
        NSNumber *number = [[[dictionary objectForKey:[@1 stringValue]] objectForKey:[@1 stringValue]] objectForKey:@"x"];
        NSLog(@"%f", [number floatValue]);
    }
    return self;
}

+ (SPCoordinateManager *)sharedManager
{
    static dispatch_once_t pred;
    static SPCoordinateManager *singleton = nil;
    dispatch_once(&pred, ^{ singleton = [[self alloc] init]; });
    return singleton;
}



- (SPCoordinate) coordinateForIndex: (NSUInteger) index withMaximumIndex: (NSUInteger)max
{
    SPCoordinate revalt;
    NSString *maxKey = [[NSNumber numberWithInteger:max] stringValue];
    NSString *indexKey = [[NSNumber numberWithInteger:index] stringValue];

    NSNumber *xvalue = [[[_coordDict objectForKey: maxKey] objectForKey:indexKey] objectForKey:@"x"];
    revalt.x = [xvalue floatValue];
    NSNumber *yvalue = [[[_coordDict objectForKey: maxKey] objectForKey:indexKey] objectForKey:@"y"];
    revalt.y = [yvalue floatValue];
    NSNumber *zvalue = [[[_coordDict objectForKey: maxKey] objectForKey:indexKey] objectForKey:@"z"];
    revalt.z = [zvalue floatValue];
    return revalt;
}

- (SPCoordinate) coordinateForIndex:(NSUInteger)index withMaximumIndex:(NSUInteger)max originAxis:(SPCoordinate) originAxis
{
    SPCoordinate originalCoordinate = [self coordinateForIndex:index withMaximumIndex:max];
    
    //TO DO:figure out the formula
    CATransform3D transform = [self transitionFrom:SPCoordinateZAxis to:originAxis];
    //Apply transition matrix;

    SPCoordinate retval;
    retval.x = transform.m11 * originalCoordinate.x + transform.m12 * originalCoordinate.y + transform.m13 *originalCoordinate.z;
    retval.y = transform.m21 * originalCoordinate.x + transform.m22 * originalCoordinate.y + transform.m23 *originalCoordinate.z;
    retval.z = transform.m31 * originalCoordinate.x + transform.m32 * originalCoordinate.y + transform.m33 *originalCoordinate.z;
    return retval;
}

- (SPCoordinate) coordinateForCoordinate: (SPCoordinate) originalCoordinate afterRotationAround: (SPCoordinate) axis
                                 byAngle: (CGFloat) angle
{
    
    //TO DO: figure out the formula
    
    return originalCoordinate;
}

//Utility Methods

- (CATransform3D)transitionFrom: (SPCoordinate) start to:(SPCoordinate) end
{
    SPCoordinate pole = [self EulerPole:start and:end];
    CGFloat angle = [self angleBetweenUnivectors:start and:end];
    CGFloat cosine = cosf(angle);
    CGFloat sine = sinf(angle);
    CATransform3D transform = CATransform3DIdentity;
    transform.m11 = pole.x *pole.x *(1 - cosine) + cosine;
    transform.m22 = pole.y *pole.y *(1 - cosine) + cosine;
    transform.m33 = pole.z *pole.z *(1 - cosine) + cosine;
    
    transform.m12 = pole.x *pole.y *(1 - cosine) - pole.z * sine;
    transform.m13 = pole.x *pole.z *(1 - cosine) + pole.y * sine;
    transform.m21 = pole.x *pole.y *(1 - cosine) + pole.z * sine;
    transform.m23 = pole.y *pole.z *(1 - cosine) - pole.x * sine;
    transform.m31 = pole.x *pole.z *(1 - cosine) - pole.y * sine;
    transform.m32 = pole.y *pole.z *(1 - cosine) + pole.x * sine;
    return transform;
}

- (CGFloat)angleBetweenUnivectors:(SPCoordinate) coord1 and: (SPCoordinate) coord2
{
    return acosf([self dotProductOfUnivectors:coord1 and:coord2]);
}

- (CGFloat)dotProductOfUnivectors:(SPCoordinate) coord1 and: (SPCoordinate) coord2
{
    return coord1.x *coord2.x + coord1.y *coord2.y + coord1.z *coord2.z;
}

- (SPCoordinate)EulerPole:(SPCoordinate) coord1 and: (SPCoordinate) coord2
{
    SPCoordinate result;
    result.x = coord1.y * coord2.z - coord1.z * coord2.y;
    result.y = coord1.z * coord2.x - coord1.x * coord2.z;
    result.z = coord1.x * coord2.y - coord1.y * coord2.x;
    CGFloat length = sqrtf(powf(result.x, 2) + powf(result.y, 2) + powf(result.z, 2)) ;
    if (length != 0) {
        result.x = result.x/length;
        result.y = result.y/length;
        result.z = result.z/length;
    }

    return result;
}

@end
