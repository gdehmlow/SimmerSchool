//
//  SLYRecipeFlowBoxView.h
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/28/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLYRecipeFlowBoxView;

@protocol SLYBoxDelegate <NSObject>
@optional
- (void)boxTouchesBegan;
- (void)boxTouchesEnded;
@end

@interface SLYRecipeFlowBoxView : UIView

@property (nonatomic, weak) id <SLYBoxDelegate> boxDelegate;

// Designated initializer
- (id)initWithFrame:(CGRect)frame withBox:(NSDictionary *)box withColor:(UIColor *)color;

@end
