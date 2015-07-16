//
//  AgendaDetailView.m
//  USTCalander
//
//  Created by Rony Antony on 14/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaDetailView.h"

@interface AgendaDetailView ()

@end

@implementation AgendaDetailView

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
    
    ContainerBridgeView * contBridgObj = [ContainerBridgeView sharedInstance];
    RootContainerView * rootContObj = (RootContainerView *)[contBridgObj getRootContainerObj];
    rootContObj.titleLabel.text = @"Single Agenda";
    
    [self ActivityBtnAction:nil];
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

- (IBAction)ActivityBtnAction:(id)sender {
    self.ActivitySelectLine.frame = CGRectMake( self.ActivitySelectLine.frame.origin.x, 34, self.ActivitySelectLine.frame.size.width, 10);
    self.ActivityOpacityView.alpha=0;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 40, self.AboutSelectLine.frame.size.width, 4);
    self.AboutOpacityView.alpha=0.5;
}

- (IBAction)AboutBtnAction:(id)sender {
    self.ActivitySelectLine.frame = CGRectMake( self.ActivitySelectLine.frame.origin.x, 40, self.ActivitySelectLine.frame.size.width, 4);
    self.ActivityOpacityView.alpha=0.5;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 34, self.AboutSelectLine.frame.size.width, 10);
    self.AboutOpacityView.alpha=0;
}
@end
