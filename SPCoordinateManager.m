//
//  SPCoordinateManager.m
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/9/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import "SPCoordinateManager.h"
#import <QuartzCore/QuartzCore.h>

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
    SPCoordinate result = [self coordinateForIndex:index withMaximumIndex:max];
    //TO DO:figure out the formula
    SPCoordinate xAxis;
    xAxis.x = 1.0f;
    xAxis.y = 0.0f;
    xAxis.z = 0.0f;
    CATransform3D transform = [self transitionFrom:xAxis to:originAxis];
    //Apply transition matrix;
    SPCoordinate retval;
    retval.x = transform.m11 * result.x + transform.m12 * result.y + transform.m13 *result.z;
    retval.y = transform.m21 * result.x + transform.m22 * result.y + transform.m23 *result.z;
    retval.z = transform.m31 * result.x + transform.m32 * result.y + transform.m33 *result.z;
    NSLog(@"%f, %f, %f", result.x, result.y, result.z);
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
