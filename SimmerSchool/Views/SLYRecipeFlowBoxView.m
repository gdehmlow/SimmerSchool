//
//  SLYRecipeFlowBoxView.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/28/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYRecipeFlowBoxView.h"
#import <QuartzCore/QuartzCore.h>

@interface SLYRecipeFlowBoxView ()

@property (nonatomic) CGSize boxSize;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UILabel *stepNumber;

@end

@implementation SLYRecipeFlowBoxView

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame withBox:(NSDictionary *)box withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.box = box;
        self.boxSize = CGSizeMake(200, 200);
        self.color = color;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    
    CGPoint center = CGPointMake(bounds.origin.x + bounds.size.width / 2.0, bounds.origin.y + 32);

    // Draw the rectangle background
    const CGFloat* colors = CGColorGetComponents(self.color.CGColor);
    CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], 1.0);
    CGContextFillRect(context, rect);

    // Circle around step number
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat radius = 16;
    path.lineWidth = 4;
    [path moveToPoint:CGPointMake(center.x + radius, center.y)];
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    [[UIColor whiteColor] setStroke];
    [[UIColor colorWithRed:colors[0] green:colors[1] blue:colors[2] alpha:1.0] setFill];

    // Drop shadow beneath circle
    CGContextSaveGState(context);
    UIColor *shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.07];
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor.CGColor);
    [path stroke];
    CGContextRestoreGState(context);
    [path fill];
    
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    [triangle moveToPoint:CGPointMake(center.x-3, 115)];
    [triangle addLineToPoint:CGPointMake(center.x+3, 115)];
    [triangle addLineToPoint:CGPointMake(center.x, 115 + 5)];
    [triangle closePath];
    [[UIColor whiteColor] setStroke];
    [[UIColor whiteColor] setFill];
    [triangle fill];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.boxDelegate touchesBeganInBox:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInView:self];
    CGRect fingerRect = CGRectMake(location.x-5, location.y-5, 10, 10);
    
    BOOL inBox = NO;
    if (CGRectIntersectsRect(fingerRect, self.bounds)) {
        inBox = YES;
    }
    
    [self.boxDelegate touchesEndedForBox:self inBox:inBox];
    [self setNeedsDisplay];
}

@end
