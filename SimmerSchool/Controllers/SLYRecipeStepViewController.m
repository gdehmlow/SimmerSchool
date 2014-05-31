//
//  SLYRecipeStepViewController.m
//  SimmerSchool
//
//  Created by Gregory Dehmlow on 5/28/14.
//  Copyright (c) 2014 Silly Wombat. All rights reserved.
//

#import "SLYRecipeStepViewController.h"

@interface SLYRecipeStepViewController ()

@property (nonatomic) SLYRecipeFlowBoxView *box;

@end

@implementation SLYRecipeStepViewController

#pragma mark - Initializers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithBox:(SLYRecipeFlowBoxView *)box
{
    self = [super init];
    if (self) {
        self.box = box;
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0 green:143.0/255.0 blue:220.0/255.0 alpha:1.0]];
    }
    return self;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)next:(id)sender {
    SLYRecipeStep *step = self.box.step;
    [self dismissViewControllerAnimated:YES completion:^(){
        [self.nextDelegate doneWithStep:step];
    }];
}

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}

 -(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }    
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setFontFamily:@"Montserrat-Regular" forView:self.view andSubViews:YES];
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:18];
    
    CGPoint center = CGPointMake(self.view.bounds.origin.x + self.view.bounds.size.width / 2.0,
                                 self.view.bounds.origin.y + self.view.bounds.size.height / 2.0);
    
    CGFloat lastY = 0.0;
    for (int i = 0; i < self.box.step.ingredients.count; i++) {
        NSString *size       = self.box.step.sizes[i];
        NSString *ingredient = self.box.step.ingredients[i];
        NSString *fullString = [NSString stringWithFormat:@"%@ %@", size, ingredient];
        
        
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:fullString
                                                                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,
                                                                 [UIColor whiteColor], NSForegroundColorAttributeName, style, NSParagraphStyleAttributeName, nil]];
        CGRect labelRect = [attributedText boundingRectWithSize:CGSizeMake(self.view.bounds.size.width,self.view.bounds.size.height)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                        context:nil];
        
        labelRect.origin.x = 0.0; //center.x - labelRect.size.width / 2;
        labelRect.origin.y = 40.0 + 60.0 * i;
        
        lastY = 60 + 40.0 * i;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x - 15.0, lastY, self.view.bounds.size.width, 40.0)];
        //UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.font = font;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = fullString;
        label.layer.shadowColor = [[UIColor blackColor] CGColor];
        label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        label.layer.shadowRadius = 1;
        label.layer.shadowOpacity = 0.10;
        [self.view addSubview:label];
        NSDictionary *views = NSDictionaryOfVariableBindings(self.view, label);
        NSArray *_constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-15-|" options:0 metrics:nil views:views];
        if (i == 0) {
            [_constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[label]-15-|" options:0 metrics:nil views:views]];
        }
        [self.view addConstraints:_constraints];
        NSLog(@"%f", label.frame.origin.y);
        lastY = lastY + 40.0;
    }
    
    UIFont *font2 = [UIFont fontWithName:@"Montserrat-Bold" size:24];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x - 5.0, lastY + 40.0, self.view.bounds.size.width - 20, 80.0)];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    //UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = font2;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.box.step.action;
    label.layer.shadowColor = [[UIColor blackColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    label.layer.shadowRadius = 1;
    label.layer.shadowOpacity = 0.10;
    [self.view addSubview:label];
    
    UIButton *dismiss = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismiss.titleLabel.font = font2;
    [dismiss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dismiss.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    dismiss.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    dismiss.titleLabel.layer.shadowRadius = 1;
    dismiss.titleLabel.layer.shadowOpacity = 0.10;
    [dismiss setTitle:@"X" forState:UIControlStateNormal];
    dismiss.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, 60.0, 65.0);
    [dismiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismiss];
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    next.titleLabel.font = font2;
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    next.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    next.titleLabel.layer.shadowRadius = 1;
    next.titleLabel.layer.shadowOpacity = 0.10;
    next.layer.borderColor = [UIColor whiteColor].CGColor;
    next.layer.borderWidth = 3.0;
    next.layer.cornerRadius = 15.0;
    next.layer.shadowColor = [[UIColor blackColor] CGColor];
    next.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    next.layer.shadowRadius = 1;
    next.layer.shadowOpacity = 0.10;
    [next setTitle:@"done" forState:UIControlStateNormal];
    next.frame = CGRectMake(center.x - 55.0, lastY + 140.0, 80, 60);
    [next addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
