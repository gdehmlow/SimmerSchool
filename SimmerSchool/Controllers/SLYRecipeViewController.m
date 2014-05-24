//
//  SLYRecipeViewController.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/24/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYRecipeViewController.h"

@interface SLYRecipeViewController ()

@end

@implementation SLYRecipeViewController

- (instancetype)initWithRecipe:(NSString *)recipeName;
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)recipeSelected:(id)sender
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
