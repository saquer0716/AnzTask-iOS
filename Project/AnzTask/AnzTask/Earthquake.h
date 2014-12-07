//
//  Earthquake.h
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//  Copyright (c) 2014 Ning Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Earthquake : NSObject

@property (nonatomic, strong) NSString *eqid;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *magnitude;
@property (nonatomic, strong) NSString *depth;
@property (nonatomic, strong) NSString *src;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@end
