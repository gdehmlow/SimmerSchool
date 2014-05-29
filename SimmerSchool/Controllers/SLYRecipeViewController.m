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

- (void)touchesBeganInBox:(SLYRecipeFlowBoxView *)box
{
    [UIView animateWithDuration:0.10
                     animations:^{
                         box.frame = CGRectMake(box.frame.origin.x, box.frame.origin.y+10, box.frame.size.width, box.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         //Do stuff when the animation completes
                     }];
}

- (void)touchesEndedForBox:(SLYRecipeFlowBoxView *)box inBox:(BOOL)inBox
{
    if (inBox) {
        NSLog(@"ended in view");
    }
    [UIView animateWithDuration:0.10
                     animations:^{
                         box.frame = CGRectMake(box.frame.origin.x, box.frame.origin.y-10, box.frame.size.width, box.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         //Do stuff when the animation completes
                     }];
}

// We'll create the colored boxes here
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Panned Cakes";
    
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Montserrat-Regular" size:18] forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    
    UIView *curView = self.view;
    
    UIView *extrusion = [[UIView alloc] initWithFrame:CGRectMake(32, 80 + 128, 128, 12)];
    UIColor *boxColorDark = [UIColor colorWithRed:0.85 green:0.687 blue:0.33 alpha:1.0];
    extrusion.backgroundColor = boxColorDark;
    [self.view addSubview:extrusion];
    
    UIColor *boxColor = [UIColor colorWithRed:1.0 green:0.837 blue:0.38 alpha:1.0];
    SLYRecipeFlowBoxView *box = [[SLYRecipeFlowBoxView alloc] initWithFrame:CGRectMake(32, 80, 128, 128)
                                                                    withBox:[self boxes][0]
                                                                  withColor:boxColor];
    box.boxDelegate = self;
    self.box = box;
    [self.view addSubview:box];
    
    CGPoint center = CGPointMake(box.bounds.origin.x + box.bounds.size.width / 2.0,
                                 box.bounds.origin.y + box.bounds.size.height / 2.0);
    
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:23];
    UILabel *stepNumber = [[UILabel alloc] initWithFrame:CGRectMake(box.bounds.origin.x + 51, box.bounds.origin.y + 19, 26, 26)];
    stepNumber.textColor = [UIColor whiteColor];
    stepNumber.textAlignment = NSTextAlignmentCenter;
    stepNumber.font = font;
    stepNumber.adjustsFontSizeToFitWidth = YES;
    stepNumber.layer.shadowColor = [[UIColor blackColor] CGColor];
    stepNumber.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    stepNumber.layer.shadowRadius = 1;
    stepNumber.layer.shadowOpacity = 0.10;
    [stepNumber setText:@"1"];
    self.boxLabel = stepNumber;
    [box addSubview:stepNumber];
    
    UIFont *font2 = [UIFont fontWithName:@"Montserrat-Regular" size:18];
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(box.bounds.origin.x + 10, box.bounds.origin.y + 46, 108, 80)];
    text.textColor = [UIColor whiteColor];
    text.numberOfLines = 2;
    text.font = font2;
    text.textAlignment = NSTextAlignmentCenter;
    text.layer.shadowColor = [[UIColor blackColor] CGColor];
    text.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    text.layer.shadowRadius = 1;
    text.layer.shadowOpacity = 0.10;
    [text setText:@"Fry all on griddle"];
    [box addSubview:text];
    
    UIColor *boxColorDark2 = [UIColor colorWithRed:.23 green:.61 blue:0.85 alpha:1.0];
    UIColor *boxColor2 = [UIColor colorWithRed:.38 green:.76 blue:1.0 alpha:1.0];
    
    UIView *extrusion2 = [[UIView alloc] initWithFrame:CGRectMake(32, 80 + 128 + 128, 128, 12)];
    extrusion2.backgroundColor = boxColorDark2;
    [self.view addSubview:extrusion2];
    
    SLYRecipeFlowBoxView *box2 = [[SLYRecipeFlowBoxView alloc] initWithFrame:CGRectMake(32, 80 + 128, 128, 128)
                                                                    withBox:[self boxes][1]
                                                                  withColor:boxColor2];
    box2.boxDelegate = self;
    self.box = box2;
    [self.view addSubview:box2];
    
    UILabel *stepNumber2 = [[UILabel alloc] initWithFrame:CGRectMake(box2.bounds.origin.x + 51, box2.bounds.origin.y + 19, 26, 26)];
    stepNumber2.textColor = [UIColor whiteColor];
    stepNumber2.textAlignment = NSTextAlignmentCenter;
    stepNumber2.font = font;
    stepNumber2.adjustsFontSizeToFitWidth = YES;
    stepNumber2.layer.shadowColor = [[UIColor blackColor] CGColor];
    stepNumber2.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    stepNumber2.layer.shadowRadius = 1;
    stepNumber2.layer.shadowOpacity = 0.10;
    [stepNumber2 setText:@"2"];
    [box2 addSubview:stepNumber2];
    
    UILabel *text2 = [[UILabel alloc] initWithFrame:CGRectMake(box2.bounds.origin.x + 10, box2.bounds.origin.y + 46, 108, 80)];
    text2.textColor = [UIColor whiteColor];
    text2.numberOfLines = 2;
    text2.font = font2;
    text2.textAlignment = NSTextAlignmentCenter;
    text2.layer.shadowColor = [[UIColor blackColor] CGColor];
    text2.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    text2.layer.shadowRadius = 1;
    text2.layer.shadowOpacity = 0.10;
    [text2 setText:@"Kick ass"];
    [box2 addSubview:text2];
    
    
    
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
