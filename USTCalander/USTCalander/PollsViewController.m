//
//  PollsViewController.m
//  USTCalander
//
//  Created by Rony Antony on 21/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "PollsViewController.h"
#import "USTServiceProvider.h"

@interface PollsViewController ()
@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation PollsViewController

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
    rootContObj.titleLabel.text = @"Ask Csk";
    
    _dataArray=[[NSMutableArray alloc]init];
    [self executeNetworkService];

}


-(void)executeNetworkService{
    [USTServiceProvider getQuestionListWithAgendaID:_agendaID withCompletionHandler:^(USTRequest * request) {
        
    }];
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

#pragma mark - Agenda Feed Cell Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==1){
        static NSString *CellIdentifier = @"PollTableHeader";
        UITableViewCell *headerView = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (headerView == nil){
            [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
        }
        return headerView;
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier =@"PollTableCellView";
    PollTableCell * cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.profileImageView.layer.masksToBounds=YES;
    cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.height/2;

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(PollTableCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.titleLabel.text = @"App Admin Edited";
    cell.timeLabel.text =@"Edited 20 Aprl 5:40 PM";
    cell.descripLabel.text = @"Edited what's the team motto for success kjhkhkhkjhkhkjhkjhkhjkjhkjhkhkjhkjhkjhkjhkjhkjhkjhkhkhjkjkhkjhkjhkjhkjhkjhkjhkjhkjhkhkhjlkhkhjkhkhkjhkhkhkkhkhkhkk";
    cell.voteLabel.text = @"40";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==1){
        return 44.0f;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}


- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    static PollTableCell * sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"PollTableCellView"];
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
    return 170;
}


- (IBAction)postQuestionBtnAction:(id)sender{
    AddPostViewController * postQues_Obj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PostQuestionView"];
    [self presentViewController:postQues_Obj animated:YES completion:nil];
    
}

@end
