//
//  BaseViewController.m
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseView.h"
#import "SWRevealViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"BaseView" owner:self options:nil];
    BaseView *baseView = [nibObjects objectAtIndex:0];
    self.slideMenuButton=baseView.slideMenuButton;
    [self.view addSubview:baseView];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.slideMenuButton addTarget:self.revealViewController action:@selector( revealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        [self.slideMenuButton addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.navigationController.navigationBarHidden=true;

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

@end
