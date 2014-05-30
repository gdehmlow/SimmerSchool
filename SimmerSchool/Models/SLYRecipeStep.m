//
//  SLYRecipe.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/24/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYRecipeStep.h"

@interface SLYRecipeStep ()

@property (nonatomic) NSString *privateStepName;
@property (nonatomic) NSArray *privateIngredients;
@property (nonatomic) NSArray *privateSizes;
@property (nonatomic) NSString *privateAction;

@end


@implementation SLYRecipeStep

#pragma mark - Initializer

- (instancetype)initWithName:(NSString *)name withIngredients:(NSArray *)ingredients
                   withSizes:(NSArray *)sizes      withAction:(NSString *)action
                   withColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        self.privateStepName = name;
        self.privateIngredients = ingredients;
        self.privateSizes = sizes;
        self.privateAction = action;
        self.color = color;
        self.completed = NO;
    }
    return self;
}

#pragma mark - Getters

- (NSString *)stepName
{
    return self.privateStepName;
}

- (NSString *)action
{
    return self.privateAction;
}

- (NSArray *)ingredients
{
    return self.privateIngredients;
}

- (NSArray *)sizes
{
    return self.privateSizes;
}

@end
