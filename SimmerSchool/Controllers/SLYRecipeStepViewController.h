//
//  SLYRecipeStepViewController.h
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/28/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLYRecipeFlowBoxView.h"

@class SLYRecipeStepViewController;

@protocol SLYNextDelegate <NSObject>
@optional
- (void)doneWithStep:(SLYRecipeStep *)step;
@end

@interface SLYRecipeStepViewController : UIViewController

@property (nonatomic) BOOL next;
@property (nonatomic, weak) id <SLYNextDelegate> nextDelegate;

- (id)initWithBox:(SLYRecipeFlowBoxView *)box;

@end
