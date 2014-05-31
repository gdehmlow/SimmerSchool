//
//  SLYRecipeViewController.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/26/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYRecipeViewController.h"
#import "SLYRecipeFlowBoxView.h"
#import "SLYRecipeStepViewController.h"

#import "SLYModalAnimation.h"
#import "SLYFloodAnimation.h"

#import "SLYRecipeStep.h"

@interface SLYRecipeViewController () <SLYBoxDelegate, SLYNextDelegate>
{
    SLYFloodAnimation *_scaleAnimationController;
    SLYModalAnimation *_modalAnimationController;
}

@property (nonatomic) NSUInteger recipeId;
@property (nonatomic, strong) SLYRecipeFlowBoxView* box;
@property (nonatomic, strong) UILabel *boxLabel;
@property (nonatomic, strong) NSMutableDictionary *numToStepView;
@property (nonatomic, strong) NSMutableDictionary *numToStep;

@property (nonatomic) UILabel *text;
@property (nonatomic) UILabel *stepNumber;

@property (nonatomic) BOOL presentNext;

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
        self.presentNext = NO;
        self.recipeId = recipeId;
        self.numToStepView = [[NSMutableDictionary alloc] init];
        self.numToStep     = [[NSMutableDictionary alloc] init];
        
        NSArray *boxData = [self boxes];
        for (int i = 0; i < boxData.count; i++) {
        //for (int i = 0; i < 1; i++) {
            NSArray *data = boxData[i];
            
            // Create step model for data
            SLYRecipeStep *step = [[SLYRecipeStep alloc] initWithName:data[0]
                                                      withIngredients:data[1]
                                                            withSizes:data[2]
                                                           withAction:data[3]
                                                            withColor:data[4]];
            NSString *stepNumber = [NSString stringWithFormat:@"%d", i + 1];
            [[self numToStep] setObject:step forKey:stepNumber];
            
            // Create step view
            SLYRecipeFlowBoxView *boxView = [[SLYRecipeFlowBoxView alloc] initWithFrame:CGRectMake(32 + 128*i, 80, 128, 128)
                                                                               withStep:step];
            boxView.boxDelegate = self;
            self.box = boxView;
            self.numToStepView[stepNumber] = boxView;
        }
    }
    return self;
}

- (void)touchesBeganInBox:(SLYRecipeFlowBoxView *)box
{
    [UIView animateWithDuration:0.10
                     animations:^{
                         box.frame = CGRectMake(box.frame.origin.x, box.frame.origin.y+10, box.frame.size.width, box.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)touchesEndedForBox:(SLYRecipeFlowBoxView *)box inBox:(BOOL)inBox
{
    [UIView animateWithDuration:0.10
                     animations:^{
                         box.frame = CGRectMake(box.frame.origin.x, box.frame.origin.y-10, box.frame.size.width, box.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
    if (inBox) {
        [self showRecipeStepForBox:box];
        
        /*SLYRecipeStepViewController *modal = [[SLYRecipeStepViewController alloc] initWithBox:self.box];
        modal.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.837 blue:0.38 alpha:0.50];
        modal.transitioningDelegate = self;
        modal.modalPresentationStyle = UIModalPresentationCustom;
        
        modal.view.opaque = NO; // Not really sure if needed
        modal.view.backgroundColor = [UIColor clearColor]; // Be sure in fact that EVERY background in your view's hierarchy is totally or at least partially transparent for a kind effect!
        
        UIToolbar *fakeToolbar = [[UIToolbar alloc] initWithFrame:modal.view.bounds]; // .bounds or .frame? Not really sure!
        fakeToolbar.autoresizingMask = modal.view.autoresizingMask;
        //fakeToolbar.barTintColor = [UIColor colorWithRed:1.0 green:0.837 blue:0.38 alpha:0.4];
        [modal.view insertSubview:fakeToolbar atIndex:0];
        
        [self presentViewController:modal animated:YES completion:nil];*/
        /*SLYRecipeStepViewController *rsvc = [[SLYRecipeStepViewController alloc] initWithBox:box];
        rsvc.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.837 blue:0.38 alpha:1.0];
        
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                          style:UIBarButtonItemStyleBordered
                                                                         target:nil
                                                                         action:nil];*/
        // Change the appearance of back button
        // Change the appearance of other navigation button
        /*UIImage *barButtonImage = [[UIImage imageNamed:@"button_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
        [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];*/
        
        /*UIImage *backButtonImage = [UIImage imageNamed:@"bak.png"];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];*/
        
        /*[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0) forBarMetrics:UIBarMetricsDefault];*/

        /*[[self navigationItem] setBackBarButtonItem:newBackButton];
        [self.navigationController pushViewController:rsvc animated:YES];*/
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _modalAnimationController = [[SLYModalAnimation alloc] init];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Panned Cakes";
    
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"Montserrat-Regular" size:18] forKey:NSFontAttributeName];
    [titleBarAttributes setValue:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forKey:NSForegroundColorAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    
    UIView *lastView = nil;
    for (NSString *stepNumber in self.numToStepView) {
        SLYRecipeStep *step = [self.numToStep objectForKey:stepNumber];
        SLYRecipeFlowBoxView *stepView = [self.numToStepView objectForKey:stepNumber];
        UIColor *color = step.color;
        const CGFloat* colors = CGColorGetComponents(color.CGColor);
        
        UIView *extrusion = [[UIView alloc] initWithFrame:CGRectMake(32, 80 + 128, 128, 12)];
        UIColor *boxColorDark = [UIColor colorWithRed:MAX(colors[0] - .2, 0.0)
                                                green:MAX(colors[1] - .2, 0.0)
                                                 blue:MAX(colors[2] - .2, 0.0)
                                                alpha:1.0];
        extrusion.backgroundColor = boxColorDark;
        
        if (!lastView) {
            [self.view addSubview:extrusion];
        } else {
            [self.view insertSubview:extrusion aboveSubview:lastView];
        }
        [self.view insertSubview:stepView aboveSubview:extrusion];
        
        UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:23];
        UILabel *stepNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(stepView.bounds.origin.x + 51, stepView.bounds.origin.y + 19, 26, 26)];
        stepNumberLabel.textColor = [UIColor whiteColor];
        stepNumberLabel.textAlignment = NSTextAlignmentCenter;
        stepNumberLabel.font = font;
        stepNumberLabel.adjustsFontSizeToFitWidth = YES;
        stepNumberLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        stepNumberLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        stepNumberLabel.layer.shadowRadius = 1;
        stepNumberLabel.layer.shadowOpacity = 0.10;
        [stepNumberLabel setText:stepNumber];
        [stepView addSubview:stepNumberLabel];
        self.stepNumber = stepNumberLabel;
        
        UIFont *font2 = [UIFont fontWithName:@"Montserrat-Regular" size:18];
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(stepView.bounds.origin.x + 10, stepView.bounds.origin.y + 46, 108, 80)];
        text.textColor = [UIColor whiteColor];
        text.numberOfLines = 2;
        text.font = font2;
        text.textAlignment = NSTextAlignmentCenter;
        text.layer.shadowColor = [[UIColor blackColor] CGColor];
        text.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        text.layer.shadowRadius = 1;
        text.layer.shadowOpacity = 0.10;
        self.text = text;
        [text setText:step.stepName];
        [stepView addSubview:text];
    }
    /*
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
        
    }*/
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
    
    _scaleAnimationController = [[SLYFloodAnimation alloc] init];
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

#pragma mark - Custom Methods

- (void)showRecipeStepForBox:(SLYRecipeFlowBoxView *)box
{
    SLYRecipeStepViewController *modal = [[SLYRecipeStepViewController alloc] initWithBox:box];
    modal.nextDelegate = self;
    const CGFloat *colors = CGColorGetComponents(box.step.color.CGColor);
    modal.view.backgroundColor = [UIColor colorWithRed:colors[0] green:colors[1] blue:colors[2] alpha:0.8];
    modal.transitioningDelegate = self;
    modal.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:modal animated:YES completion:nil];
}

- (void)doneWithStep:(SLYRecipeStep *)step
{
    self.text.text = @"complete";
    UIColor *color = step.color;
    const CGFloat* colors = CGColorGetComponents(color.CGColor);
    
    UIColor *boxColorDark = [UIColor colorWithRed:MAX(colors[0] - .1, 0.0)
                                            green:MAX(colors[1] - .1, 0.0)
                                             blue:MAX(colors[2] - .1, 0.0)
                                            alpha:1.0];
    
    UIColor *shadowColor  = [UIColor colorWithRed:MAX(colors[0] - .25, 0.0)
                                            green:MAX(colors[1] - .25, 0.0)
                                             blue:MAX(colors[2] - .25, 0.0)
                                            alpha:0.0];
    UIColor *insetColor   = [UIColor colorWithRed:1.0
                                            green:1.0
                                             blue:1.0
                                            alpha:1.0];
    self.text.textColor = boxColorDark;
    self.text.shadowOffset = CGSizeMake(0.0, -1.0);
    self.text.shadowColor = shadowColor;
    self.text.layer.shadowColor = insetColor.CGColor;
    self.text.layer.shadowOpacity = 0.0;
    
    self.stepNumber.textColor = boxColorDark;
    self.stepNumber.shadowOffset = CGSizeMake(0.0, -1.0);
    self.stepNumber.shadowColor = shadowColor;
    self.stepNumber.layer.shadowColor = insetColor.CGColor;
    self.stepNumber.layer.shadowOpacity = 0.0;
    
    SLYRecipeFlowBoxView *box = [self.numToStepView objectForKey:@"1"];
    box.complete = YES;
    [box setNeedsDisplay];
}

#pragma mark - Transitioning Delegate (Modal)

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _modalAnimationController.type = AnimationTypePresent;
    return _modalAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _modalAnimationController.type = AnimationTypeDismiss;
    return _modalAnimationController;
}


#pragma mark - Data

- (NSArray *)boxes
{
    return @[
                @[
                 @"Make dry mixture",
                 @[@"flour", @"baking powder", @"sugar", @"salt"],
                 @[@"1 1/2 cup", @"1 3/4 tsp.", @"3 tbsp.", @"1 tsp."],
                 @"Sift all together in mixing bowl",
                 [UIColor colorWithRed:1.0 green:0.837 blue:0.38 alpha:1.0]
                 ],
                @[
                 @"Make milk mixture",
                 @[@"milk", @"butter", @"egg yolks"],
                 @[@"1 1/4 cup", @"3 tbsp.", @"1 or 2"],
                 @"Stir milk mixture into dry mix thoroughly",
                 [UIColor colorWithRed:.38 green:.76 blue:1.0 alpha:1.0]
                 ]
             ];
}

- (NSArray *)ingredients
{
    return @[
             @[@"flour", @"baking powder", @"sugar", @"salt"],
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

#pragma mark - Navigation Controller Delegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    BaseAnimation *animationController = _scaleAnimationController;

    switch (operation) {
        case UINavigationControllerOperationPush:
            animationController.type = AnimationTypePresent;
            return  animationController;
        case UINavigationControllerOperationPop:
            animationController.type = AnimationTypeDismiss;
            return animationController;
        default: return nil;
    }
    
}
@end
