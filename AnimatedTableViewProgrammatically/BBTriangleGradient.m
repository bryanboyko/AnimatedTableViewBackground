//
//  BBTriangleGradient.m
//  CGGradientShape
//
//  Created by Bryan Boyko on 8/25/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "BBTriangleGradient.h"

@implementation BBTriangleGradient

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGPoint center;
    center.x = self.bounds.origin.x + self.bounds.size.width/2;
    center.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    
    // Get the currentContext value inside drawRect:
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    
    // Save the state of the current graphics context
    CGContextSaveGState(currentContext);
    
    // Setting the gradient constants
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.9, 0.9, 1.0,    // Start color
        1.0, 0.0, 0.0, 1.0 };  // End color
    
    // Set the color space for gradient application
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    CGPoint startPoint; // Gradient start point
    startPoint.x = center.x;
    startPoint.y = self.bounds.origin.y;
    CGPoint endPoint;   // Gradient end point
    endPoint.x = center.x;
    endPoint.y = self.bounds.size.height;
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    // Restore the state of the current graphics context
    CGContextRestoreGState(currentContext);
}


@end
