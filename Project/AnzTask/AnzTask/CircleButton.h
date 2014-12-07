//
//  CircleButton.h
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//  Copyright (c) 2014 Ning Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleButton : UIButton

/*!
 Convert a normal rectange button into a round button
 
 @param color The filled button color
 */
- (void)drawCircleButton:(UIColor *)color;

@end
