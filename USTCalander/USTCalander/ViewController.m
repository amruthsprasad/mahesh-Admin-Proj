//
//  ViewController.m
//  USTCalander
//
//  Created by Amruth on 01/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "ActivityFeedCell.h"
#import "RootContainerView.h"
#import "ContainerBridgeView.h"
#import "USTServiceProvider.h"
#import "Constants.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

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
    rootContObj.headerView.hidden = NO;
    rootContObj.titleLabel.text = @"Activity Feed";

    _dataArray=[[NSMutableArray alloc]init];
    [self executeNetworkService];
    
    
    
}


-(void)executeNetworkService{
    [USTServiceProvider getActivityFeed:[NSNumber numberWithInt:20] andPage:[NSNumber numberWithInt:0] withCompletionHandler:^(USTRequest * request) {
        
        if (request.responseDict) {
            self.dataArray = [NSMutableArray arrayWithArray:[request.responseDict objectForKey:@"post"]];
            [_tableView reloadData];
        }
        
    }];
    
    
//    UIImage * image=[UIImage imageNamed:@"ActivityPage"];
//    NSData *data= [[NSData alloc]init];//
//    data=UIImagePNGRepresentation(image);
//    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//    [dict setObject:@"text" forKey:@"text"];
//    [dict setObject:@"" forKey:@"agendaId"];
//    [dict setObject:data forKey:@"imageData"];
//    
//    [USTServiceProvider addPost:[dict mutableCopy] WithCompletionHandler:^(USTRequest * request) {
//        
//    }];
    
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
    
    cell.post_textLabel.text=[post objectForKey:@"post_text"];
    cell.post_dateLabel.text=[post objectForKey:@"post_date"];
    if (postImageName.length) {
        
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlFull,postImageName]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                   ActivityFeedCell * cell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (cell)
                        cell.activityImageView.image = image;
                });
            }
        }
    });
    }
    
    
    /* if(cell == nil)
     {
     cell = [[ActivityFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     CGRect rect=cell.contentView.frame;
     float xPos=(rect.size.width-3)/4;
     cell.seperator1.frame=CGRectMake(xPos+1, cell.seperator1.frame.origin.y, cell.seperator1.frame.size.width, cell.seperator1.frame.size.height);
     cell.seperator2.frame=CGRectMake(xPos*2+2, cell.seperator2.frame.origin.y, cell.seperator2.frame.size.width, cell.seperator2.frame.size.height);
     cell.seperator3.frame=CGRectMake(xPos*3+3, cell.seperator3.frame.origin.y, cell.seperator3.frame.size.width, cell.seperator3.frame.size.height);*/
    
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



@end
