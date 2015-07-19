//
//  CustomContainerView.h
//  USTCalander
//
//  Created by Rony Antony on 11/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protocol definition starts here
@protocol RootContainerViewDelegate <NSObject>
 @optional
- (void) rightFirstBarButtonAction:(id)sender;
- (void) rightSecondBarButtonAction:(id)sender;
 @end

@interface RootContainerView : UIViewController

@property (nonatomic,assign) id delegate;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UIButton * slideMenuButton;
@property (weak, nonatomic) IBOutlet UIButton * rightFirstBarButton;
@property (weak, nonatomic) IBOutlet UIButton * rightSecondBarButton;

- (IBAction)slideMenuAction:(id)sender;
- (IBAction)rightFirstBarButtonAction:(id)sender;
- (IBAction)rightSecondBarButtonAction:(id)sender;

@end
