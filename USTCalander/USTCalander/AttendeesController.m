//
//  AttendeesController.m
//  USTCalander
//
//  Created by Rony Antony on 16/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AttendeesController.h"
#import "Constants.h"
#import "USTServiceProvider.h"

@interface AttendeesController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation AttendeesController

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
    rootContObj.titleLabel.text = @"Attendees";
    
    _dataArray=[[NSMutableArray alloc]init];
    [self executeNetworkService];

}

-(void)executeNetworkService{
    [USTServiceProvider getAttendeesListWithCompletionHandler:^(USTRequest * request) {
        if (request.responseDict) {
            self.dataArray = [NSMutableArray arrayWithArray:[request.responseDict objectForKey:@"attendees"]];
            [_tableView reloadData];
        }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttendeesFeedCell *cell ;
    NSString *CellIdentifier =@"AttendeesCell";
    cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.profileImg.layer.masksToBounds=YES;
    cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.height/2;
    cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.profileImg.layer.masksToBounds=YES;
    cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.height/2;
    NSDictionary * attendee = [_dataArray objectAtIndex:indexPath.row];
    
    cell.title.text=[NSString stringWithFormat:@"%@ %@",[attendee objectForKey:@"firstname"],[attendee objectForKey:@"lastname"]];
    cell.descrip.text = [attendee objectForKey:@"designation"];
    NSNumber * imageStatus = [attendee objectForKey:@"user_image_stat"];
    NSString * imageName = [attendee objectForKey:@"user_image"];
    
    if (imageStatus) {
        
        
        dispatch_async(kBgQueue, ^{
            NSData *imgData = [USTServiceProvider getImageWithName:imageName];//[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlCroped,postImageName]]];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        AttendeesFeedCell * cell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (cell)
                            cell.profileImg.image = image;
                    });
                }
            }
        });
    }
    
    return cell;
}

- (void)configureCell:(AttendeesFeedCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary * attendee = [_dataArray objectAtIndex:indexPath.row];
    cell.title.text=[NSString stringWithFormat:@"%@ %@",[attendee objectForKey:@"firstname"],[attendee objectForKey:@"lastname"]];
    cell.descrip.text = [attendee objectForKey:@"designation"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}


- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    static AttendeesFeedCell * sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"AttendeesCell"];
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
