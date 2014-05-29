//
//  SLYRecipeViewController.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/26/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYRecipeViewController.h"
#import "SLYRecipeFlowBoxView.h"

@interface SLYRecipeViewController () <SLYBoxDelegate>

@property (nonatomic) NSUInteger recipeId;
@property (nonatomic, strong) SLYRecipeFlowBoxView* box;
@property (nonatomic, strong) UILabel *boxLabel;

@end

@implementation SLYRecipeViewController

#pragma mark - Initializers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (instancetype)initWithRecipe:(NSUInteger)recipeId
{
    self = [super init];
    if (self) {
        self.recipeId = recipeId;
    }
    return self;
}

# pragma mark - View
/*
- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    SLYHypnosisView *backgroundView = [[SLYHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize Me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [backgroundView addSubview:textField];
    
    self.view = backgroundView;
}*/

- (void)boxTouchesBegan
{
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.box.frame = CGRectMake(self.box.frame.origin.x, self.box.frame.origin.y+10, self.box.frame.size.width, self.box.frame.size.height);
                         self.boxLabel.frame = CGRectMake(self.boxLabel.frame.origin.x, self.boxLabel.frame.origin.y+10, self.boxLabel.frame.size.width, self.boxLabel.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         //Do stuff when the animation completes
                     }];
}

- (void)boxTouchesEnded
{
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.box.frame = CGRectMake(self.box.frame.origin.x, self.box.frame.origin.y-10, self.box.frame.size.width, self.box.frame.size.height);
                         self.boxLabel.frame = CGRectMake(self.boxLabel.frame.origin.x, self.boxLabel.frame.origin.y-10, self.boxLabel.frame.size.width, self.boxLabel.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         //Do stuff when the animation completes
                     }];
}

// We'll create the colored boxes here
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *curView = self.view;
    
    UIColor *boxColor = [UIColor colorWithRed:1.0 green:0.837 blue:0.38 alpha:1.0];
    SLYRecipeFlowBoxView *box = [[SLYRecipeFlowBoxView alloc] initWithFrame:CGRectMake(32, 64, 128, 128)
                                                                    withBox:[self boxes][0]
                                                                  withColor:boxColor];
    box.boxDelegate = self;
    self.box = box;
    [self.view addSubview:box];
    
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:50];
    UILabel *stepNumber = [[UILabel alloc] initWithFrame:CGRectMake(box.frame.origin.x, box.frame.origin.y, 128, 128)];
    stepNumber.textColor = [UIColor whiteColor];
    stepNumber.textAlignment = NSTextAlignmentCenter;
    stepNumber.font = font;
    stepNumber.adjustsFontSizeToFitWidth = YES;
    stepNumber.layer.shadowColor = [[UIColor blackColor] CGColor];
    stepNumber.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    stepNumber.layer.shadowRadius = 1;
    stepNumber.layer.shadowOpacity = 0.10;
    [stepNumber setText:[self boxes][0][@"s"]];
    self.boxLabel = stepNumber;
    [self.view addSubview:stepNumber];
    
    UIView *extrusion = [[UIView alloc] initWithFrame:CGRectMake(32, 64 + 128, 128, 12)];
    UIColor *boxColorDark = [UIColor colorWithRed:0.85 green:0.687 blue:0.33 alpha:1.0];
    extrusion.backgroundColor = boxColorDark;
    [self.view addSubview:extrusion];
    
    UIColor *boxColor2 = [UIColor colorWithRed:.38 green:.76 blue:1.0 alpha:1.0];
    SLYRecipeFlowBoxView *box2 = [[SLYRecipeFlowBoxView alloc] initWithFrame:CGRectMake(32+128, 64, 128, 128)
                                                                     withBox:[self boxes][1]
                                                                   withColor:boxColor2];
    [self.view addSubview:box2];
    UIView *extrusion2 = [[UIView alloc] initWithFrame:CGRectMake(32 + 128, 64 + 128, 128, 12)];
    UIColor *boxColorDark2 = [UIColor colorWithRed:.23 green:.61 blue:0.85 alpha:1.0];
    extrusion2.backgroundColor = boxColorDark2;
    [self.view addSubview:extrusion2];
    
    // Iterate over the boxes and generate the flow
    NSArray *boxes = self.boxes;
    for (int i = 0; i < boxes.count; i++) {
        
    }
    /*
    for (int i = 0; i < numIngredients; i++) {
        CGRect newFrame = CGRectMake(bounds.origin.x + 64,
                                     bounds.origin.y + (i + 1)*64,
                                     1000,
                                     64);
        UILabel *label = [[UILabel alloc] initWithFrame:newFrame];
        label.text = [NSString stringWithFormat:@"%@ %@", self.sizes[self.recipeId][i], self.ingredients[self.recipeId][i]];
        label.backgroundColor = [UIColor lightGrayColor];
        [curView addSubview:label];
        NSLog(label.text);
    }*/
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Data

- (NSArray *)boxes
{
    return @[
             @{@"s": @"1", @"mg": @1, @"w": @2, @"lt": @[@1]},
             @{@"s": @"2", @"mg": @1, @"w": @1, @"lt": @[@0,@1]},
             @{@"s": @"2", @"mg": @1, @"w": @1, @"lt": @[@0,@1]},
             @{@"s": @"3", @"mg": @1, @"w": @1, @"lt": @[@1]},
             @{@"s": @"4", @"mg": @1, @"w": @1, @"lt": @[@0]},
             @{@"s": @"5", @"mg": @1, @"w": @1, @"lt": @[@1]},
             @{},
             @{@"s": @"6", @"mg": @1, @"w": @1, @"lt": @[]},
             ];
}

- (NSArray *)ingredients
{
    return @[
             @[@"flour", @"double-acting baking powder", @"sugar", @"salt"],
             ];
}
- (NSArray *)sizes
{
    return @[
             @[@"1 1/2 cup", @"1 3/4 tsp.", @"3 tbsp.", @"1 tsp."],
             ];
}
- (NSArray *)actions
{
    return @[
             @"Mix"
             ];
}

@end
