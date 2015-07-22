//
//  SpeakerDetailView.h
//  USTCalander
//
//  Created by Rony Antony on 19/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerBridgeView.h"

@interface SpeakerDetailView : UIViewController

@property(nonatomic,strong) NSString * currentView;

@property(nonatomic,strong) NSString * speakerID;
@property(nonatomic,strong) NSMutableArray * speakerSeassions;
@property(nonatomic,strong) NSString * aboutSpeaker;


@property(nonatomic,weak) IBOutlet UIImageView * profileImg;
@property(nonatomic,weak) IBOutlet UILabel * titleLabel;
@property(nonatomic,weak) IBOutlet UILabel * descripLabel;
@property (weak, nonatomic) IBOutlet UIView *SessionSelectLine;
@property (weak, nonatomic) IBOutlet UIView *AboutSelectLine;
@property (weak, nonatomic) IBOutlet UIView *SessionOpacityView;
@property (weak, nonatomic) IBOutlet UIView *AboutOpacityView;
- (IBAction)SessionBtnAction:(id)sender;
- (IBAction)AboutBtnAction:(id)sender;

@end
