//
//  CommentViewController.m
//  USTCalander
//
//  Created by Amruth on 20/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "USTServiceProvider.h"
#import "Constants.h"
#import "USTUser.h"

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.commentTextView.layer.borderWidth = 2.0f;
    _commentTextView.layer.cornerRadius=5;
    self.commentTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    _dataArray=[[NSMutableArray alloc]init];
    [self executeNetworkService];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


-(void)executeNetworkService{
    [USTServiceProvider getCommentListForPostWithID:_postID WithCompletionHandler:^(USTRequest * request) {
        if (request.responseDict) {
            _dataArray = [NSMutableArray arrayWithArray:[request.responseDict objectForKey:@"comment"]];

        }
        [_tableView reloadData];
    }];
    
}

-(void)dismissModalView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CommentCell *cell ;
    NSString *CellIdentifier =@"commentCell";
    cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSDictionary * attendee = [_dataArray objectAtIndex:indexPath.row];
    cell.profileImage.layer.masksToBounds=YES;
    cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height/2;
    cell.commenterNameLabel.text=[NSString stringWithFormat:@"%@ %@",[attendee objectForKey:@"firstname"],[attendee objectForKey:@"lastname"]];
    cell.commentLabel.text = [attendee objectForKey:@"cmnt_text"];
    
    NSNumber * imageStatus = [attendee objectForKey:@"user_image_stat"];
    NSString * imageName = [attendee objectForKey:@"user_image"];
    
    if (imageStatus) {
        
        
        dispatch_async(kBgQueue, ^{
            NSData *imgData = [USTServiceProvider getImageWithName:imageName];//[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlCroped,postImageName]]];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CommentCell * cell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (cell)
                            cell.profileImage.image = image;
                    });
                }
            }
        });
    }

    

    return cell;
}

- (void)configureCell:(CommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary * attendee = [_dataArray objectAtIndex:indexPath.row];
    cell.commenterNameLabel.text=[NSString stringWithFormat:@"%@ %@",[attendee objectForKey:@"firstname"],[attendee objectForKey:@"lastname"]];
    cell.commentLabel.text = [attendee objectForKey:@"designation"];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;//[self heightForCellAtIndexPath:indexPath];
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



- (IBAction)closeView:(id)sender {
    [self dismissModalView];
}

- (IBAction)commentAction:(id)sender {
    [USTServiceProvider commentPostWithPostId:_postID andComment:_commentTextView.text WithCompletionHandler:^(USTRequest * request) {
        USTUser * user =[USTUser sharedInstance];
        NSMutableDictionary * dict= [[NSMutableDictionary alloc]init];
        [dict setObject:_commentTextView.text forKey:@"cmnt_text"];
        [dict setObject:user.userFirstName forKey:@"firstname"];
        [dict setObject:user.userLastName forKey:@"lastname"];
        [dict setObject:user.userImage forKey:@"user_image"];
        [dict setObject:user.userImageStatus forKey:@"user_image_stat"];
        
        [_dataArray insertObject:[dict mutableCopy] atIndex:0];
        [_tableView reloadData];
        
        _commentTextView.text=@"";
    }];
}
@end
