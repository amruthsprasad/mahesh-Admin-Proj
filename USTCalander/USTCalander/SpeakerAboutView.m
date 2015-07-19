//
//  SpeakerAboutView.m
//  USTCalander
//
//  Created by Rony Antony on 20/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "SpeakerAboutView.h"

@interface SpeakerAboutView ()

@end

@implementation SpeakerAboutView

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
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(speakerDetailNotoficationAction:) name:@"SpeakerDetailNotification" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(void) speakerDetailNotoficationAction:(NSNotification *)actionDict{
    AgendaViewController * agendaVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaVC"];
    agendaVc.agendaType=@"fromSpeakerView";
    [self.navigationController pushViewController:agendaVc animated:NO];
}

@end
