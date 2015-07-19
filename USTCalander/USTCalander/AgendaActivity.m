//
//  AgendaActivity.m
//  USTCalander
//
//  Created by Rony Antony on 15/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaActivity.h"
#import "USTServiceProvider.h"
#import "Constants.h"

@interface AgendaActivity ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSString * agendaID;
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
    //agendaDetailObj.delegate = self;
    _agendaID = agendaDetailObj.agendaID;
    [self executeNetworkService];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(agendaDetailNotoficationAction:) name:@"AgendaDetailNotification" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)executeNetworkService{
    [USTServiceProvider getAgendaDetail:_agendaID withCompletionHandler:^(USTRequest * request) {
        if (request.responseDict) {
           
        }
    }];
    
    
    [USTServiceProvider getSingleAgendaActivityList:_agendaID andPage:[NSNumber numberWithInt:0] withCompletionHandler:^(USTRequest *request) {
        NSArray * array = [request.responseDict objectForKey:@"activity"];
        self.dataArray = [NSMutableArray arrayWithArray:array];
        [_tableView reloadData];
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
    ActivityFeedCell *cell ;
    NSString *CellIdentifier;
    NSDictionary * post = [self.dataArray objectAtIndex:indexPath.row];
    
     NSNumber * imageStatus = [post objectForKey:@"user_image_stat"];
    NSString * postImageName = [post objectForKey:@"post_image"];
    if (postImageName.length)
    {
        CellIdentifier =@"ActivityWithImage";
    }
    else
    {
        CellIdentifier =@"Activity";
    }
    
    cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.post_AgendaName.text=[post objectForKey:@"agenda_name"];
    cell.post_textLabel.text=[post objectForKey:@"post_text"];
    cell.post_dateLabel.text=[post objectForKey:@"post_date"];
    cell.authorNameLabel.text=[NSString stringWithFormat:@"%@ %@",[post objectForKey:@"firstname"],[post objectForKey:@"lastname"]];
    cell.likeCountLabel.text=[NSString stringWithFormat:@"%@ Likes",[post objectForKey:@"like_count"]];
    cell.cmntCountLabel.text=[NSString stringWithFormat:@"%@ comments",[post objectForKey:@"cmnt_count"]];

    if (postImageName.length) {
        
        dispatch_async(kBgQueue, ^{
            NSData *imgData = [USTServiceProvider getImageWithName:postImageName];//[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlCroped,postImageName]]];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ActivityFeedCell * cell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (cell)
                            cell.activityImageView.image = image;
                        //cell.activityImageView.frame = CGRectMake(cell.activityImageView.frame.origin.x, cell.activityImageView.frame.origin.y,309, 180);
                        
                    });
                }
            }
        });
        if (imageStatus) {
            
        
            dispatch_async(kBgQueue, ^{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlCroped,[post objectForKey:@"user_image"]]]];
                if (imgData) {
                    UIImage *image = [UIImage imageWithData:imgData];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            ActivityFeedCell * cell = (id)[tableView cellForRowAtIndexPath:indexPath];
                            if (cell)
                                cell.profileImageView.image = image;
                        });
                    }
                }
            });
        }
    }
    
    return cell;}

- (void)configureCell:(ActivityFeedCell *)cell cellDict:(NSDictionary *)post atIndexPath:(NSIndexPath *)indexPath {
    
    cell.post_AgendaName.text=[post objectForKey:@"agenda_name"];
    cell.post_textLabel.text=[post objectForKey:@"post_text"];
    cell.post_dateLabel.text=[post objectForKey:@"post_date"];
    cell.likeCountLabel.text=[NSString stringWithFormat:@"%@ Likes",[post objectForKey:@"like_count"]];
    cell.cmntCountLabel.text=[NSString stringWithFormat:@"%@ comments",[post objectForKey:@"cmnt_count"]];

    NSString * postImageName = [post objectForKey:@"post_image"];
    if (postImageName.length) {
        
        //        dispatch_async(kBgQueue, ^{
        //           // NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlFull,postImageName]]];
        //            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ustglobaleventapp.com/php/uploads/image_full/(null)_1437157044.jpg"]]];
        //            NSLog(@"Image URL...%@%@..",BaseImageUrlFull,postImageName);
        //            if (imgData) {
        //                UIImage *image = [UIImage imageWithData:imgData];
        //                if (image) {
        //                    dispatch_async(dispatch_get_main_queue(), ^{
        //                        //ActivityFeedCell * cell = (id)[self.tableView cellForRowAtIndexPath:indexPath];
        //                        //if (cell)
        //                            cell.activityImageView.image = image;
        //                    });
        //                }
        //            }
        //        });
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}


- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * CellIdentifier;
    NSDictionary * post = [self.dataArray objectAtIndex:indexPath.row];
    NSString * postImageName = [post objectForKey:@"post_image"];
    if (postImageName.length)
    {
        CellIdentifier = @"ActivityWithImage";
    }
    else
    {
        CellIdentifier = @"Activity";
    }
    
    static ActivityFeedCell * sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    });
    
    [self configureCell:sizingCell cellDict:post atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

-(void) agendaDetailNotoficationAction:(NSNotification *)actionDict{
    NSLog(@"Hi... Activity");
    AgendaAbout * agendaObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaAboutView"];
    [self.navigationController pushViewController:agendaObj animated:NO];
}

@end
