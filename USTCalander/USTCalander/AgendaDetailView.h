//
//  AgendaDetailView.h
//  USTCalander
//
//  Created by Rony Antony on 14/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerBridgeView.h"

@interface AgendaDetailView : UIViewController

@property (weak, nonatomic) IBOutlet UIView *ActivitySelectLine;
@property (weak, nonatomic) IBOutlet UIView *AboutSelectLine;
@property (weak, nonatomic) IBOutlet UIView *ActivityOpacityView;
@property (weak, nonatomic) IBOutlet UIView *AboutOpacityView;
- (IBAction)ActivityBtnAction:(id)sender;
- (IBAction)AboutBtnAction:(id)sender;

@end
