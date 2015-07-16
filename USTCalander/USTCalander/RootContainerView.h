//
//  CustomContainerView.h
//  USTCalander
//
//  Created by Rony Antony on 11/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootContainerView : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *slideMenuButton;

- (IBAction)slideMenuAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel * titleLabel;

@end
