//
//  SLYRecipeFlowView.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/28/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYRecipeFlowView.h"

@interface SLYRecipeFlowView ()

@property (nonatomic, strong) NSArray *boxes;
@property (nonatomic) CGSize boxSize;

@end

@implementation SLYRecipeFlowView

#pragma mark - Initializers

- (id)initWithBoxes:(NSArray *)boxes withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.boxes = boxes;
        self.boxSize = CGSizeMake(200, 200);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return nil;
}

#pragma mark - Drawing

/*
    |---------------|
    |               |
    |   ---------   |
    |   |   1   |   |
    |   ---------   |
    |   | 2 | 3 |   |
    |   ---------   |
    |               |
    |               |
    |               |
    -----------------
 
    Width of the flow is boxSize.width * 2
    Its offset from the corner is bounds.width - flow width + at least 100 pix from top
*/

/*
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    CGFloat flowWidth = self.boxSize.width * 2.0;
    
    CGPoint drawPoint = CGPointMake(self.bounds.size.width - flowWidth, 100);
    
    for (int i = 0; i < self.boxes.count; i++) {
        
    }
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path.lineWidth = 10;
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
        if (useRandomColors) {
            self.circleColor = [self generateRandomColor];
        }
        [self.circleColor setStroke];
        [path stroke];
    }
}
*/

@end
