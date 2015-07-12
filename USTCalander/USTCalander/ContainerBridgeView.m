//
//  ContainerBridgeView.m
//  USTCalander
//
//  Created by Rony Antony on 11/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "ContainerBridgeView.h"
#import "ViewController.h"
#import "SWRevealViewController.h"

#define SegueIdentifierActivity @"embedActivity"

@interface ContainerBridgeView ()

@property (strong, nonatomic) NSMutableDictionary * viewContrlDict;
@property (strong, nonatomic) NSString * previousSegueIdentifier;
@property (strong, nonatomic) NSString * currentSegueIdentifier;
@property (assign, nonatomic) BOOL transitionInProgress;

@end

static ContainerBridgeView * sharedContBridObj;

@implementation ContainerBridgeView

+ (ContainerBridgeView *)sharedInstance{
   
  /*static ContainerBridgeView * sharedContBridObj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedContBridObj  = [[ContainerBridgeView alloc] init];
    });*/
    return sharedContBridObj;
}

- (id)init
{
    if (self = [super init]) {
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
    // Do any additional setup after loading the view.

    sharedContBridObj = self;
    self.viewContrlDict = [[NSMutableDictionary alloc] init];
    self.transitionInProgress = NO;
    self.currentSegueIdentifier = SegueIdentifierActivity;
    [self performSegueWithIdentifier:SegueIdentifierActivity sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    
    ViewController * vc = segue.destinationViewController;
    [self.viewContrlDict setValue:vc forKey:self.currentSegueIdentifier];
    if(self.previousSegueIdentifier.length==0||[self.previousSegueIdentifier isEqual: [NSNull null]]||self.previousSegueIdentifier==nil){
        //vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self addChildViewController:vc];
        UIView* destView = ((UIViewController *)segue.destinationViewController).view;
        destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:destView];
        [vc didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }
    else{
        [self swapFromViewController:[self.viewContrlDict objectForKey:self.previousSegueIdentifier]toViewController:[self.viewContrlDict objectForKey:self.currentSegueIdentifier]];
    }
    
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
   // NSLog(@"%s", __PRETTY_FUNCTION__);
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
        SWRevealViewController * revealViewController = self.revealViewController;
        [revealViewController revealToggleAnimated:YES];
    }];
    
}

- (void)swapViewControllers:(NSString *)segueIdentifier;
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.transitionInProgress) {
        return;
    }
    
    if([self.currentSegueIdentifier isEqualToString:segueIdentifier]){
        [self.revealViewController revealToggleAnimated:YES];
        return;
    }
    
    self.transitionInProgress = YES;
    self.previousSegueIdentifier = self.currentSegueIdentifier;
    self.currentSegueIdentifier = segueIdentifier;
    [self performSegueWithIdentifier:segueIdentifier sender:nil];
    
}

-(UIViewController *)getRootContainerObj{
    return self.parentViewController;
}


@end

/* For StoryBoard Support */

@implementation EmptySegue

- (void)perform
{
    // Nothing. The ContainerViewController class handles all of the view
    // controller action.
}

@end

