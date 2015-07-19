//
//  AgendaDetailView.m
//  USTCalander
//
//  Created by Rony Antony on 14/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaDetailView.h"
#import "AgendaActivity.h"

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
    
    self.currentView=@"agendaActivity";
    [self setAgendaActivityActive];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}*/

-(void)setAgendaActivityActive{
    self.ActivitySelectLine.frame = CGRectMake( self.ActivitySelectLine.frame.origin.x, 34, self.ActivitySelectLine.frame.size.width, 10);
    self.ActivityOpacityView.alpha=0;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 40, self.AboutSelectLine.frame.size.width, 4);
    self.AboutOpacityView.alpha=0.5;
}

-(void)setAgendaAboutActive{
    self.ActivitySelectLine.frame = CGRectMake( self.ActivitySelectLine.frame.origin.x, 40, self.ActivitySelectLine.frame.size.width, 4);
    self.ActivityOpacityView.alpha=0.5;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 34, self.AboutSelectLine.frame.size.width, 10);
    self.AboutOpacityView.alpha=0;
}


- (IBAction)ActivityBtnAction:(id)sender {
    self.currentView=@"agendaActivity";
    [self setAgendaActivityActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AgendaDetailNotification" object:nil userInfo:nil];
}

- (IBAction)AboutBtnAction:(id)sender {
    self.currentView=@"agendaAbout";
    [self setAgendaAboutActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AgendaDetailNotification" object:nil userInfo:nil];
}

-(void) agendaDetailNotoficationAction:(NSNotification *)actionDict{
    NSLog(@"Hi... Activity");
    AgendaAbout * agendaObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaAboutView"];
    [self.navigationController pushViewController:agendaObj animated:NO];
}

@end
