//
//  SLYRecipe.h
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/24/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLYRecipeStep : NSObject

- (instancetype)initWithName:(NSString *)name withIngredients:(NSArray *)ingredients
                   withSizes:(NSArray *)sizes withAction:(NSString *)action
                   withColor:(UIColor *)color;

@property (nonatomic, copy, readonly) NSString *stepName;
@property (nonatomic, readonly) NSArray *ingredients;
@property (nonatomic, readonly) NSArray *sizes;
@property (nonatomic, copy, readonly) NSString *action;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) BOOL completed;

@end
