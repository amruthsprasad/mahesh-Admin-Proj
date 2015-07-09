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
    [USTServiceProvider loginWithUserId:_userNameTextField.text andPassword:_passwordTextField.text withCompletionHandler:^(USTRequest * request) {
        
        AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
        
        appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        
    }];
}

- (IBAction)rememberMeAction:(id)sender {
}

- (IBAction)forgotPasswordAction:(id)sender {
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
