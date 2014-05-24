//
//  SLYRecipeBadge.h
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/22/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLYRecipeBadge : NSObject

@property (nonatomic, copy) NSString *badgeName;
@property (nonatomic, copy) NSString *recipeId;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic) NSUInteger score;

@end
