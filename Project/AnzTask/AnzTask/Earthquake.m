//
//  Earthquake.m
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//  Copyright (c) 2014 Ning Gu. All rights reserved.
//

#import "Earthquake.h"

@implementation Earthquake

- (instancetype) init
{
    if (self = [super init]) {
        self.eqid      = @"";
        self.region    = @"";
        self.date      = @"";
        self.magnitude = @"";
        self.depth     = @"";
        self.src       = @"";
        self.longitude = @"";
        self.latitude  = @"";
    }
    
    return self;
}

- (void)dealloc
{
    [_eqid release];
    [_region release];
    [_date release];
    [_magnitude release];
    [_depth release];
    [_src release];
    [_longitude release];
    [_latitude release];
    
    [super dealloc];
}

@end
