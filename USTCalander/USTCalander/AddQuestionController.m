//
//  AddQuestionController.m
//  USTCalander
//
//  Created by Rony Antony on 22/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AddQuestionController.h"

@interface AddQuestionController ()

@end

@implementation AddQuestionController

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

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    //self.statusText.text = @"";
    // self.statusText.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.QuestionTextView.text.length == 0){
        // self.statusText.textColor = [UIColor lightGrayColor];
        //self.statusText.text = @"Status";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)postQuestion:(id)sender{
    
}

@end
