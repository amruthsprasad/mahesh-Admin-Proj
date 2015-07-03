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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityFeedCell" bundle:nil]
         forCellReuseIdentifier:@"Activity"];
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier =@"Activity";
    ActivityFeedCell *cell ;
    cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];    
    if(cell == nil)
    {
        cell = [[ActivityFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CGRect rect=cell.contentView.frame;
    float xPos=(rect.size.width-3)/4;
    cell.seperator1.frame=CGRectMake(xPos+1, cell.seperator1.frame.origin.y, cell.seperator1.frame.size.width, cell.seperator1.frame.size.height);
    cell.seperator2.frame=CGRectMake(xPos*2+2, cell.seperator2.frame.origin.y, cell.seperator2.frame.size.width, cell.seperator2.frame.size.height);
    cell.seperator3.frame=CGRectMake(xPos*3+3, cell.seperator3.frame.origin.y, cell.seperator3.frame.size.width, cell.seperator3.frame.size.height);
    return cell;
}
@end