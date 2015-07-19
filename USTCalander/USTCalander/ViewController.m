//
//  ViewController.m
//  USTCalander
//
//  Created by Amruth on 01/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "RootContainerView.h"
#import "ContainerBridgeView.h"
#import "USTServiceProvider.h"
#import "Constants.h"
#import "AddPostViewController.h"



@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,RootContainerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     //  [self.tableView registerNib:[UINib nibWithNibName:@"ActivityFeedCell" bundle:nil] forCellReuseIdentifier:@"Activity"];
    
    ContainerBridgeView * contBridgObj = [ContainerBridgeView sharedInstance];
    RootContainerView * rootContObj = (RootContainerView *)[contBridgObj getRootContainerObj];
    rootContObj.delegate=self;
    rootContObj.headerView.hidden = NO;
    rootContObj.titleLabel.text = @"Activity Feed";
    rootContObj.rightFirstBarButton.hidden=false;
    
    _dataArray=[[NSMutableArray alloc]init];
    [self executeNetworkService];
}

-(void)viewWillAppear:(BOOL)animated{
}


-(void)executeNetworkService{
    
    
//    //to post activity
//    UIImage * image=[UIImage imageNamed:@"images.jpeg"];
//    NSData *data= [[NSData alloc]init];//
//    data=UIImagePNGRepresentation(image);
//    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:@"test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth" forKey:@"text"];
//    [dict setObject:@"" forKey:@"agendaId"];
//    [dict setObject:data forKey:@"imageData"];
//    [USTServiceProvider uploadImage:data WithCompletionHandler:^(USTRequest * request) {
//        NSString* imageName = [NSString stringWithFormat:@"%@",[request.responseDict objectForKey:@"image_name"]];
//        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//        [dict setObject:@"test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth test post by amruth" forKey:@"text"];
//        [dict setObject:@"" forKey:@"agendaId"];
//        if ([[request.responseDict objectForKey:@"status"] isEqualToString:@"success"]) {
//            [USTServiceProvider addPostWithData:dict andImageName:imageName WithCompletionHandler:^(USTRequest * request) {
//                [USTServiceProvider getActivityFeed:[NSNumber numberWithInt:20] andPage:[NSNumber numberWithInt:0] withCompletionHandler:^(USTRequest * request) {
//                    
//                    if (request.responseDict) {
//                        self.dataArray = [NSMutableArray arrayWithArray:[request.responseDict objectForKey:@"post"]];
//                        [_tableView reloadData];
//                    }
//                    
//                }];
//            }];
//        }
//
//    }];
//    
    [USTServiceProvider getActivityFeed:[NSNumber numberWithInt:20] andPage:[NSNumber numberWithInt:0] withCompletionHandler:^(USTRequest * request) {
        
                            if (request.responseDict) {
                                self.dataArray = [NSMutableArray arrayWithArray:[request.responseDict objectForKey:@"post"]];
                                [_tableView reloadData];
                            }
        
                        }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
   // NSNumber * imageStatus = [post objectForKey:@"user_image_stat"];
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
    
    cell.post_textLabel.text=[post objectForKey:@"post_text"];
    cell.post_dateLabel.text=[post objectForKey:@"post_date"];
    cell.authorNameLabel.text=[NSString stringWithFormat:@"%@ %@",[post objectForKey:@"firstname"],[post objectForKey:@"lastname"]];
    cell.likeCountLabel.text=[NSString stringWithFormat:@"%@ Likes",[post objectForKey:@"like_count"]];
    cell.cmntCountLabel.text=[NSString stringWithFormat:@"%@ comments",[post objectForKey:@"cmnt_count"]];
    NSNumber * LikeStatus=[post objectForKey:@"user_like_stat"];
    if (LikeStatus.boolValue) {
        [cell.likeButton setImage:[UIImage imageNamed:@"likeIcon"] forState:UIControlStateNormal];
    }
    else{
        [cell.likeButton setImage:[UIImage imageNamed:@"likeIcon"] forState:UIControlStateNormal];
    }
    
    cell.tag=indexPath.row;
    if (postImageName.length) {
        
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [USTServiceProvider getImageWithName:postImageName];//[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlCroped,postImageName]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                   ActivityFeedCell * cell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (cell){
                        cell.activityImageView.contentMode= UIViewContentModeScaleAspectFit;
                        cell.activityImageView.image = image;
                    }
                    //cell.activityImageView.frame = CGRectMake(cell.activityImageView.frame.origin.x, cell.activityImageView.frame.origin.y,309, 180);

                });
            }
        }
    });
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
    
    return cell;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height;
    if(indexPath.row%2==0){
        height= 190;
    }
    else{
        height= 380;
    }
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityFeedCell *cell ;
    NSString *CellIdentifier;
    NSDictionary * post = [self.dataArray objectAtIndex:indexPath.row];
    // NSNumber * imageStatus = [post objectForKey:@"user_image_stat"];
    NSString * postImageName = [post objectForKey:@"post_image"];
    if (postImageName.length)
    {
        CellIdentifier =@"ActivityWithImage";
    }
    else
    {
        CellIdentifier =@"Activity";
    }
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    [self configureCell:cell cellDict:post atIndexPath:indexPath];
    return cell;
}*/

- (void)configureCell:(ActivityFeedCell *)cell cellDict:(NSDictionary *)post atIndexPath:(NSIndexPath *)indexPath {
    
    cell.post_textLabel.text=[post objectForKey:@"post_text"];
    cell.post_dateLabel.text=[post objectForKey:@"post_date"];
    NSString * postImageName = [post objectForKey:@"post_image"];
    cell.likeCountLabel.text=[NSString stringWithFormat:@"%@ Likes",[post objectForKey:@"like_count"]];
    cell.cmntCountLabel.text=[NSString stringWithFormat:@"%@ comments",[post objectForKey:@"cmnt_count"]];

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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * post = [self.dataArray objectAtIndex:indexPath.row];
    NSString * postImageName = [post objectForKey:@"post_image"];
    if (postImageName.length)
    {
         return [self heightForImageCellAtIndexPath:indexPath];
    }
    else{
         return [self heightForCellAtIndexPath:indexPath];
    }

}

- (CGFloat)heightForImageCellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * post = [self.dataArray objectAtIndex:indexPath.row];
    NSString * CellIdentifier = @"ActivityWithImage";
    static ActivityFeedCell * sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    });
    [self configureCell:sizingCell cellDict:post atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * post = [self.dataArray objectAtIndex:indexPath.row];
    NSString *  CellIdentifier = @"Activity";

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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height;
    NSDictionary * post = [self.dataArray objectAtIndex:indexPath.row];
    NSString * postImageName = [post objectForKey:@"post_image"];
    if (postImageName.length){
         height= 380;
    }
    else{
        height= 190;
    }
    return height;

}

#pragma mark - Activate Feed Cell Delegate Methods

- (void) likeBtnAction:(ActivityFeedCell *)sender{
    NSDictionary * post = [self.dataArray objectAtIndex:sender.tag];

    [USTServiceProvider likePostWithPostId:[post objectForKey:@"post_id"] WithCompletionHandler:^(USTRequest * request) {
        NSNumber * LikeStatus=[post objectForKey:@"user_like_stat"];
        if (LikeStatus.boolValue) {
            [sender.likeButton setImage:[UIImage imageNamed:@"likeIcon"] forState:UIControlStateNormal];
        }
        else{
            [sender.likeButton setImage:[UIImage imageNamed:@"likeIcon"] forState:UIControlStateNormal];
        }
    }];
}

- (void) commentBtnAction:(ActivityFeedCell *)sender{
    NSLog(@"Sender...%@",sender);
}

- (void) twitterBtnAction:(ActivityFeedCell *)sender{
    NSLog(@"Sender...%@",sender);
}

- (void) facebookBtnAction:(ActivityFeedCell *)sender{
    NSLog(@"Sender...%@",sender);
}

- (void) viewAllLikeBtnAction:(ActivityFeedCell *)sender{
    NSLog(@"Sender...%@",sender);
}

- (void) viewAllCommentBtnAction:(ActivityFeedCell *)sender{
    NSLog(@"Sender...%@",sender);
}


#pragma mark - RootContainer Delegate Methods
-(void)rightFirstBarButtonAction:(id)sender{
    AddPostViewController * addPost = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddPostViewController"];
     [self.navigationController presentViewController:addPost animated:YES completion:^{
         
     }];
}

@end
