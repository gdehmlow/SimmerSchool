//
//  SLYRecipeFlowBoxView.h
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/28/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLYRecipeStep.h"

@class SLYRecipeFlowBoxView;

@protocol SLYBoxDelegate <NSObject>
@optional
- (void)touchesBeganInBox:(SLYRecipeFlowBoxView *)box;
- (void)touchesEndedForBox:(SLYRecipeFlowBoxView *)box inBox:(BOOL)inBox;
@end

@interface SLYRecipeFlowBoxView : UIView

@property (nonatomic, weak) id <SLYBoxDelegate> boxDelegate;
@property (nonatomic, strong) SLYRecipeStep *step;
@property (nonatomic) BOOL complete;

// Designated initializer
- (id)initWithFrame:(CGRect)frame withStep:(SLYRecipeStep *)step;

@end
