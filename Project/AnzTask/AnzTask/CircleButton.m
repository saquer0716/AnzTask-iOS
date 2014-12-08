//
//  CircleButton.m
//  AnzTask
//
//  Created by Ning Gu on 7/12/2014.
//  Copyright (c) 2014 Ning Gu. All rights reserved.
//

#import "CircleButton.h"

@interface CircleButton ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UIColor *color;

@end

@implementation CircleButton

/*!
 Set button filled color
 @param newColor The filled color
 */
- (void)setColor: (UIColor *)newColor
{
    [newColor retain];
    [_color release];
    
    _color = newColor;
}

/*!
 Set new layer for button
 @param circleLayer The new layer
 */
- (void)setCircleLayer:(CAShapeLayer *)circleLayer
{
    [circleLayer retain];
    [_circleLayer release];
    
    _circleLayer = circleLayer;
}

- (void)drawCircleButton:(UIColor *)color
{
    if (_circleLayer) {
        return;
    }
    self.color = color;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.circleLayer = [CAShapeLayer layer];
    
    [self.circleLayer setBounds:CGRectMake(0.0f, 0.0f, [self bounds].size.width, [self bounds].size.height)];
    [self.circleLayer setPosition:CGPointMake(CGRectGetMidX([self bounds]),CGRectGetMidY([self bounds]))];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    [self.circleLayer setPath:[path CGPath]];
    [self.circleLayer setFillColor:[color CGColor]];
    
    [[self layer] addSublayer:self.circleLayer];
}

- (void)dealloc
{
    [_circleLayer release];
    [_color release];
    
    [super dealloc];
}

@end
