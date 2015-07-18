//
//  AgendaAbout.m
//  USTCalander
//
//  Created by Rony Antony on 15/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaAbout.h"

@interface AgendaAbout ()

@end

@implementation AgendaAbout

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
    AgendaDetailView * agendaDetailObj = (AgendaDetailView *)self.parentViewController.parentViewController;
    agendaDetailObj.delegate = self;
    self.descripLabel.text  = @"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem";
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

#pragma - mark Agenda Detail View Controller Delegate Methods

- (void) agendaActivityButtonAction{
    AgendaActivity * agendaObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaActivityView"];
    [self.navigationController pushViewController:agendaObj animated:NO];
}

@end
