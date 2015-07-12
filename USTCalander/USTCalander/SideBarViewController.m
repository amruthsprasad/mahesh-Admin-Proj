//
//  SideBarViewController.m
//  USTCalander
//
//  Created by Amruth on 01/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "SideBarViewController.h"
#import "SlidebarTableViewCell.h"
#import "SlideBarTitleTableViewCell.h"
#import "SWRevealViewController.h"

#import "ViewController.h"
#import "AgendaViewController.h"
#import "AppDelegate.h"
#import "ContainerBridgeView.h"

#define SegueIdentifierActivity @"embedActivity"
#define SegueIdentifierAgenda @"embedAgenda"
#define SegueIdentifierSpeakers @"embedSpeakers"
#define SegueIdentifierLeaderboard @"embedLeaderboard"
#define SegueIdentifierAttendees @"embedAttendees"
#define SegueIdentifierPolls @"embedPolls"

@interface SideBarViewController ()
{
    NSArray * menuItems;
    NSArray * imageArray;
}
@end

@implementation SideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SlidebarTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MenuItem"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SlideBarTitleTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"Title"];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     menuItems = @[@"TITLE", @"Home",@"Activity feed", @"Agenda", @"Speakers", @"Attendees", @"Leaderboard", @"Polls", @"Log out"];
    
    imageArray = @[@"MenuIconHome", @"MenuIconHome",@"MenuIconActivityFeed", @"MenuIconAgenda", @"MenuIconSpeakers", @"MenuIconAttendees", @"MenuIconLeaderboard", @"MenuIconPolls", @"MenuIconLogout"];
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
    return [menuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * CellIdentifier1 = @"MenuItem";
    NSString * CellIdentifier2 = @"Title";
    if (indexPath.row ==0) {
        SlideBarTitleTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        return cell;
    }
    else
    {
        SlidebarTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
        cell.icon_imageView.image=[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
        cell.title_Label.text=[menuItems objectAtIndex:indexPath.row];
        
        return cell;
    }
        return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=60;
    if (indexPath.row==0) {
        height=175;
    }
    return height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContainerBridgeView * contBrdgObj = [ContainerBridgeView sharedInstance];
    UIViewController *FrontVC=nil;
    switch (indexPath.row) {
        case 1:
        {
            /*UIStoryboard * storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController * activityFeed=[storyboard instantiateViewControllerWithIdentifier:@"ActivityFeedVC"];
            FrontVC=activityFeed;*/
            [contBrdgObj swapViewControllers:SegueIdentifierActivity];
            break;
        }
        case 3:
        {
            [contBrdgObj swapViewControllers:SegueIdentifierAgenda];
            break;
        }
        case 4:{
            [contBrdgObj swapViewControllers:SegueIdentifierSpeakers];
            break;
        }
        case 5:{
            [contBrdgObj swapViewControllers:SegueIdentifierAttendees];
            break;
        }
        case 6:{
            [contBrdgObj swapViewControllers:SegueIdentifierLeaderboard];
            break;
        }
        case 7:{
            [contBrdgObj swapViewControllers:SegueIdentifierPolls];
            break;
        }
        case 8:
        {
            AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
            
            UIViewController* rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
            
            UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
            appDelegateTemp.window.rootViewController = navigation;
        }
            break;
            
        default:
            break;
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SWRevealViewController *revealViewController = self.revealViewController;
    if (FrontVC) {
        [revealViewController pushFrontViewController:FrontVC animated:FrontViewPositionRightMostRemoved];

    }

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
