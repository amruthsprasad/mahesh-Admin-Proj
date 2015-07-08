//
//  LoginViewController.h
//  USTCalander
//
//  Created by Amruth on 08/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *userBG;
@property (weak, nonatomic) IBOutlet UIView *passwordBG;
@property (weak, nonatomic) IBOutlet UIView *signinView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginAction:(id)sender;
- (IBAction)rememberMeAction:(id)sender;
- (IBAction)forgotPasswordAction:(id)sender;

@end
