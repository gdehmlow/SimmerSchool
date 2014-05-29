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

@property (nonatomic, strong) NSDictionary *box;
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

    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:50];

    // Draw the rectangle background
    const CGFloat* colors = CGColorGetComponents(self.color.CGColor);
    CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], 1.0);
    CGContextFillRect(context, rect);

    // Centered step number
    CGPoint point = CGPointMake(0, 0);

    // Circle around step number
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat radius = 30;
    path.lineWidth = 7;
    [path moveToPoint:CGPointMake(center.x + radius, center.y)];
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    [[UIColor whiteColor] setStroke];
    [[UIColor colorWithRed:colors[0] green:colors[1] blue:colors[2] alpha:1.0] setFill];

    // Drop shadow beneath circle
    CGContextSaveGState(context);
    UIColor * shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.07];
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 2, shadowColor.CGColor);
    [path stroke];
    CGContextRestoreGState(context);
    [path fill];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*[UIView animateWithDuration:0.15
                  animations:^{
                      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+10, self.frame.size.width, self.frame.size.height);
                  }
                  completion:^(BOOL finished){
                      //Do stuff when the animation completes
                  }];
    [self setNeedsDisplay];*/
    [self.boxDelegate boxTouchesBegan];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*[UIView animateWithDuration:0.15
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-10, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         //Do stuff when the animation completes
                     }];*/
    [self.boxDelegate boxTouchesEnded];
    [self setNeedsDisplay];
}

@end
