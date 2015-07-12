//
//  LoginViewController.m
//  USTCalander
//
//  Created by Amruth on 08/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "USTServiceProvider.h"
#import "USTUser.h"

@interface LoginViewController ()
@property (nonatomic,weak)UITextField * selectedTextField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=true;
    _userBG.layer.cornerRadius = _userBG.frame.size.height/2;
    _passwordBG.layer.cornerRadius = _passwordBG.frame.size.height/2;
    _signinView.layer.cornerRadius = _signinView.frame.size.height/2;
    _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Your Userame" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Your Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    _activityIndicator.hidden=true;
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

- (IBAction)loginAction:(id)sender {
    //[self executeServiceRequest];
    [self goToHomeScreen];
}

- (IBAction)rememberMeAction:(id)sender {
}

- (IBAction)forgotPasswordAction:(id)sender {
}

-(void)executeServiceRequest{
    _loginButton.enabled=NO;
    _activityIndicator.hidden=false;
    [self.activityIndicator startAnimating];
    USTUser *sharedUser = [USTUser sharedInstance];
    [sharedUser loadCredentialsFromKeychain];
    sharedUser.userID = _userNameTextField.text;
    sharedUser.userPassword = _passwordTextField.text;
    
    [USTServiceProvider loginWithUserId:_userNameTextField.text andPassword:_passwordTextField.text withCompletionHandler:^(USTRequest * request) {
        
        [self.activityIndicator stopAnimating];
        _activityIndicator.hidden=true;
        _loginButton.enabled = YES;
        NSString * success=[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:1]];
        NSString * fail = [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:0]];
        NSString * status = [NSString stringWithFormat:@"%@",[request.responseDict objectForKey:@"status"]];
        if ([status isEqualToString:success] ) {
            NSDictionary * userData=[request.responseDict objectForKey:@"user"];
            sharedUser.userData = [request.responseDict objectForKey:@"user"];
            sharedUser.userSessionID = [userData objectForKey:@"deviceid"];
            sharedUser.userFirstName = [userData objectForKey:@"firstname"];
            sharedUser.userLastName = [userData objectForKey:@"lastname"];
            sharedUser.userDesignation = [userData objectForKey:@"designation"];
            sharedUser.userEventID = [userData objectForKey:@"event_active"];
            sharedUser.userEventWelcomeMessage = [userData objectForKey:@"event_welcome"];
            sharedUser.userLocation = [userData objectForKey:@"location"];
            sharedUser.userImage = [userData objectForKey:@"user_image"];
            sharedUser.userImageStatus = [userData objectForKey:@"user_image_stat"];
            [sharedUser setCredentialsToKeychain];
            [self goToHomeScreen];
            
        }
        else if ([status isEqualToString:fail]){
            [self showAlertWithMessage:@"Failed to login please check your credentials"];
        }
        else{
            if ([self performOfflineLogin]) {
                
            }
            else
            {
                [self showAlertWithMessage:@"Login failed please check your credentials"];
            }
        }
        
        
        
    }];

}

-(BOOL)performOfflineLogin{
    return YES;
    
}
-(void)goToHomeScreen{
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

-(void)showAlertWithMessage:(NSString *)message
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"UST" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _selectedTextField=textField;
    return YES;
}



#define kOFFSET_FOR_KEYBOARD 50.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
//    if (_selectedTextField==_passwordTextField) {
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
//    }
}

-(void)keyboardWillHide {
//    if (_selectedTextField==_passwordTextField) {
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
   // }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:_passwordTextField])
    {
        //move the main view, so that the keyboard does not hide it.
//        if  (self.view.frame.origin.y >= 0)
//        {
//            [self setViewMovedUp:YES];
//        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
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
@end
