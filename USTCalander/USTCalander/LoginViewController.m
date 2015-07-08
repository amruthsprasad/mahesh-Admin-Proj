//
//  LoginViewController.m
//  USTCalander
//
//  Created by Amruth on 08/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

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
    AppDelegate *appDelegateTemp = [[UIApplication sharedApplication]delegate];
    
    appDelegateTemp.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

- (IBAction)rememberMeAction:(id)sender {
}

- (IBAction)forgotPasswordAction:(id)sender {
}

@end
