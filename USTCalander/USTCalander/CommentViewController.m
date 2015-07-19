//
//  CommentViewController.m
//  USTCalander
//
//  Created by Amruth on 20/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissModalView)];
        self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void)dismissModalView{
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 20;//[_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CommentCell *cell ;
    NSString *CellIdentifier =@"commentCell";
    cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

//    NSDictionary * attendee = [_dataArray objectAtIndex:indexPath.row];
//    
//    cell.commenterNameLabel.text=[NSString stringWithFormat:@"%@ %@",[attendee objectForKey:@"firstname"],[attendee objectForKey:@"lastname"]];
//    cell.commentLabel.text = [attendee objectForKey:@"designation"];
    

    return cell;
}

- (void)configureCell:(CommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
//    NSDictionary * attendee = [_dataArray objectAtIndex:indexPath.row];
//    cell.commenterNameLabel.text=[NSString stringWithFormat:@"%@ %@",[attendee objectForKey:@"firstname"],[attendee objectForKey:@"lastname"]];
//    cell.commentLabel.text = [attendee objectForKey:@"designation"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}


- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    static CommentCell * sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"commentCell"];
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



@end
