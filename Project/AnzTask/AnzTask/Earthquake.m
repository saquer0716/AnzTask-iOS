//
//  Earthquake.m
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//  Copyright (c) 2014 Ning Gu. All rights reserved.
//
//  This class is not used yet, but might need in the future
//

#import "Earthquake.h"

@implementation Earthquake

- (instancetype) init
{
    if (self = [super init]) {
        _eqid      = @"";
        _region    = @"";
        _date      = @"";
        _magnitude = @"";
        _depth     = @"";
        _src       = @"";
        _longitude = @"";
        _latitude  = @"";
    }
    
    return self;
}

#pragma mark - override "set" accessor for MRR
/*!
 Set earthquake ID
 @param eqid The earthquake ID
 */
- (void)setEqid:(NSString *)eqid
{
    [eqid retain];
    [_eqid release];
    
    _eqid = eqid;
}

/*!
 Set earthquake region
 @param eqid The earthquake region
 */
- (void)setRegion:(NSString *)region
{
    [region retain];
    [_region release];
    
    _region = region;
}

/*!
 Set earthquake region
 @param eqid The earthquake region
 */
- (void)setDate:(NSString *)date
{
    [date retain];
    [_date release];
    
    _date = date;
}

/*!
 Set earthquake magnitude
 @param eqid The earthquake magnitude
 */
- (void)setMagnitude:(NSString *)magnitude
{
    [magnitude retain];
    [_magnitude release];
    
    _magnitude = magnitude;
}

/*!
 Set earthquake depth
 @param eqid The earthquake depth
 */
- (void)setDepth:(NSString *)depth
{
    [depth retain];
    [_depth release];
    
    _depth = depth;
}

/*!
 Set earthquake src
 @param eqid The earthquake src
 */
- (void)setSrc:(NSString *)src
{
    [src retain];
    [_src release];
    
    _src = src;
}

/*!
 Set earthquake longitude
 @param eqid The earthquake longitude
 */
- (void)setLongitude:(NSString *)longitude
{
    [longitude retain];
    [_longitude release];
    
    _longitude = longitude;
}

/*!
 Set earthquake latitude
 @param eqid The earthquake latitude
 */
- (void)setLatitude:(NSString *)latitude
{
    [latitude retain];
    [_latitude release];
    
    _latitude = latitude;
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
