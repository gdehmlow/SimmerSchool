//
//  SLYGameViewController.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/24/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYGameViewController.h"
#import "SLYRecipeViewController.h"

@interface SLYGameViewController ()

@end

@implementation SLYGameViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recipeSelected:(UIButton *)sender
{
    NSLog(@"%@",sender.titleLabel.text);
    [self.navigationController pushViewController:[[SLYRecipeViewController alloc] initWithRecipe:sender.titleLabel.text] animated:YES];
}

@end
