//
//  SPCoordinateManager.m
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/9/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import "SPCoordinateManager.h"

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
@end
