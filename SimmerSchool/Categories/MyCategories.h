//
//  UIBarButtonItem+backArrowButtonWithTarget.h
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/29/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (projectButtons)

+ (UIBarButtonItem *)backArrowButtonWithTarget:(id)target action:(SEL)action;

@end