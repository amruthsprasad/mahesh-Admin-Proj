//
//  AgendaViewController.m
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaViewController.h"
#import "AgendaDetailView.h"
#import "USTServiceProvider.h"

@interface AgendaViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;


@end

@implementation AgendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ContainerBridgeView * contBridgObj = [ContainerBridgeView sharedInstance];
    RootContainerView * rootContObj = (RootContainerView *)[contBridgObj getRootContainerObj];
    rootContObj.titleLabel.text = @"Agenda";
    _dataArray = [[NSMutableArray alloc]init];
    [self executeNetworkService];

}

-(void)executeNetworkService{
    [USTServiceProvider getAgendaListwithCompletionHandler:^(USTRequest * request) {
        if (request.responseDict) {
            self.dataArray = [NSMutableArray arrayWithArray:[request.responseDict objectForKey:@"agenda"]];
            [_tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Agenda Feed Cell Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier =@"AgendaCell";
    AgendaFeedCell * cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    [self configureCell:cell atIndexPath:indexPath];
    
    NSDictionary * agendaDict = [_dataArray objectAtIndex:indexPath.row];
    
    cell.title.text = [agendaDict objectForKey:@"agenda_name"];
    cell.time.text  = [NSString stringWithFormat:@"%@ - %@,%@",[agendaDict objectForKey:@"agenda_from"],[agendaDict objectForKey:@"agenda_to"],[agendaDict objectForKey:@"agenda_date"]];
    cell.description.text = [agendaDict objectForKey:@"agenda_place"];
    cell.actionButton.tag=indexPath.row;
    cell.cellButton.tag=indexPath.row;
    int  userattending = [[agendaDict objectForKey:@"user_attending"] intValue];
    if (userattending) {
        cell.actionImg.image = [UIImage imageNamed:@"activate_icon"];
    }
    else
    {
        cell.actionImg.image = [UIImage imageNamed:@"deactivate_icon"];
    }
    
    return cell;
}

- (void)configureCell:(AgendaFeedCell *)cell atIndexPath:(NSIndexPath *)indexPath {
        
    
    NSDictionary * agendaDict = [_dataArray objectAtIndex:indexPath.row];
    
    cell.title.text = [agendaDict objectForKey:@"agenda_name"];
    cell.time.text  = [NSString stringWithFormat:@"%@ - %@,%@",[agendaDict objectForKey:@"agenda_from"],[agendaDict objectForKey:@"agenda_to"],[agendaDict objectForKey:@"agenda_date"]];
    cell.description.text = [agendaDict objectForKey:@"agenda_place"];
    if ([agendaDict objectForKey:@"user_attending"]) {
        cell.actionImg.image = [UIImage imageNamed:@"activate_icon"];
    }
    else
    {
        cell.actionImg.image = [UIImage imageNamed:@"deactivate_icon"];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}


- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    static AgendaFeedCell * sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"AgendaCell"];
    });
    
    [self configureCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

#pragma mark - Agenda Feed Cell Delegate Methods

- (void) cellButtonAction:(AgendaFeedCell*)sender{
    NSDictionary * agendaDict = [_dataArray objectAtIndex:sender.actionButton.tag];
    NSString * agendaID = [agendaDict objectForKey:@"agenda_id"];

}

- (void) activateButtonAction:(AgendaFeedCell*)sender{
    NSDictionary * agendaDict = [_dataArray objectAtIndex:sender.actionButton.tag];
    int  userattending = [[agendaDict objectForKey:@"user_attending"] intValue];

    if (userattending) {
        sender.actionImg.image = [UIImage imageNamed:@"deactivate_icon"];
    }
    else
    {
        sender.actionImg.image = [UIImage imageNamed:@"activate_icon"];
    }
    [USTServiceProvider attendingAgendaWithAgendaID:[agendaDict objectForKey:@"agenda_id"] withCompletionHandler:^(USTRequest * request) {
        [self executeNetworkService];
    }];
}


@end
