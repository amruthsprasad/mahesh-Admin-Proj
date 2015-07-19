//
//  AddPostViewController.m
//  USTCalander
//
//  Created by Amruth on 19/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AddPostViewController.h"

@interface AddPostViewController ()

@end

@implementation AddPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ContainerBridgeView * contBridgObj = [ContainerBridgeView sharedInstance];
    RootContainerView * rootContObj = (RootContainerView *)[contBridgObj getRootContainerObj];
    rootContObj.titleLabel.text = @"Add Post";
    
    self.statusText.text = @"Status";
    self.statusText.textColor = [UIColor lightGrayColor];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.statusText.text = @"";
    self.statusText.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.statusText.text.length == 0){
        self.statusText.textColor = [UIColor lightGrayColor];
        self.statusText.text = @"Status";
    }
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

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(IBAction)openCamera:(id)sender{
    
}

-(IBAction)openGallery:(id)sender{
    
}

- (IBAction)tagAgenda:(id)sender{
    
}
- (IBAction)postActivity:(id)sender{
    
}
@end
