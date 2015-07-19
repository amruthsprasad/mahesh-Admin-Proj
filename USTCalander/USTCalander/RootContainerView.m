//
//  CustomContainerView.m
//  USTCalander
//
//  Created by Rony Antony on 11/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "RootContainerView.h"
#import "SWRevealViewController.h"

@interface RootContainerView ()

@end

@implementation RootContainerView

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
    
    self.rightFirstBarButton.hidden=YES;
    self.rightSecondBarButton.hidden=YES;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.slideMenuButton addTarget:self.revealViewController action:@selector( revealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.navigationController.navigationBarHidden=YES;
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];

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

-(void) detectOrientation
{
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        //It's Landscape
        NSLog(@"...Landscape...%f.....",self.headerView.frame.origin.y);
        
    }
    else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
    {
        //It's portrait time!
         NSLog(@"....Portrait...%f.....",self.headerView.frame.origin.y);
    }
}

- (IBAction)slideMenuAction:(id)sender {
    
}

- (IBAction)rightFirstBarButtonAction:(id)sender{
    [self.delegate rightFirstBarButtonAction:sender];
}

- (IBAction)rightSecondBarButtonAction:(id)sender{
    [self.delegate rightSecondBarButtonAction:sender];
}


@end
