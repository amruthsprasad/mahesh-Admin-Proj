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
    
    self.currentView=@"agendaActivity";
    [self setAgendaActivityActive];
    // [self performSegueWithIdentifier:@"AgendaContainerSegue" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
  //  UINavigationController * navCtrl = segue.destinationViewController;
   /*
    UIViewController * vcObj;
    if([self.currentView isEqualToString:@"agendaAbout"]){
        AgendaAbout * agendaAboutObj = [[AgendaAbout alloc]init];
        vcObj = agendaAboutObj;
    }
    else{
        AgendaActivity * agendaActivityObj = [[AgendaActivity alloc]init];
        vcObj= agendaActivityObj;
    }
    //[navCtrl pushViewController:vcObj animated:YES];
    navCtrl = [navCtrl initWithRootViewController:vcObj];
    
    [self addChildViewController:navCtrl];
    UIView* destView = ((UINavigationController *)segue.destinationViewController).view;
    destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:destView];
    [navCtrl didMoveToParentViewController:self];*/
    
    
}

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
    //[self performSegueWithIdentifier:@"AgendaContainerSegue" sender:nil];
    [self.delegate agendaActivityButtonAction];
}

- (IBAction)AboutBtnAction:(id)sender {
    self.currentView=@"agendaAbout";
    [self setAgendaAboutActive];
    //[self performSegueWithIdentifier:@"AgendaContainerSegue" sender:nil];//AgendaContainerSegue
    [self.delegate agendaAboutButtonAction];
}
@end
