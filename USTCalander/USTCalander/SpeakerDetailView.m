//
//  SpeakerDetailView.m
//  USTCalander
//
//  Created by Rony Antony on 19/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "SpeakerDetailView.h"

@interface SpeakerDetailView ()

@end

@implementation SpeakerDetailView

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
    
    self.currentView=@"speakerAbout";
    [self setSpeakerAboutActive];

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

-(void)setSpeakerSessionActive{
    self.SessionSelectLine.frame = CGRectMake( self.SessionSelectLine.frame.origin.x, 34, self.SessionSelectLine.frame.size.width, 10);
    self.SessionOpacityView.alpha=0;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 40, self.AboutSelectLine.frame.size.width, 4);
    self.AboutOpacityView.alpha=0.5;
}

-(void)setSpeakerAboutActive{
    self.SessionSelectLine.frame = CGRectMake( self.SessionSelectLine.frame.origin.x, 40, self.SessionSelectLine.frame.size.width, 4);
    self.SessionOpacityView.alpha=0.5;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 34, self.AboutSelectLine.frame.size.width, 10);
    self.AboutOpacityView.alpha=0;
}


- (IBAction)SessionBtnAction:(id)sender {
    self.currentView=@"speakerSession";
    [self setSpeakerSessionActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeakerDetailNotification" object:nil userInfo:nil];
}

- (IBAction)AboutBtnAction:(id)sender {
    self.currentView=@"speakerAbout";
    [self setSpeakerAboutActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeakerDetailNotification" object:nil userInfo:nil];
}


@end
