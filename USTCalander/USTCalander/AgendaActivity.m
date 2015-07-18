//
//  AgendaActivity.m
//  USTCalander
//
//  Created by Rony Antony on 15/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaActivity.h"

@interface AgendaActivity ()

@end

@implementation AgendaActivity

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityFeedCell *cell ;
    if(indexPath.row%2==0){
        NSString *CellIdentifier =@"Activity";
        cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else{
        NSString *CellIdentifier =@"ActivityWithImage";
        cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height;
    if(indexPath.row%2==0){
        height= 190;
    }
    else{
        height= 380;
    }
    return height;
}

#pragma - mark Agenda Detail View Controller Delegate Methods

- (void) agendaAboutButtonAction{
    AgendaAbout * agendaObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaAboutView"];
    [self.navigationController pushViewController:agendaObj animated:NO];
}


@end
