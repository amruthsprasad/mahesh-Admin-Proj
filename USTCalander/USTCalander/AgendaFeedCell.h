//
//  ActivityFeedCell.h
//  USTCalander
//
//  Created by Amruth on 02/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AgendaFeedCell;
// Protocol definition starts here
@protocol AgendaFeedCellDelegate <NSObject>

@required
- (void) cellButtonAction:(AgendaFeedCell*)sender;
- (void) activateButtonAction:(AgendaFeedCell*)sender;
@end

@interface AgendaFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel * title;
@property (weak, nonatomic) IBOutlet UILabel * time;
@property (weak, nonatomic) IBOutlet UIButton * cellButton;
@property (weak, nonatomic) IBOutlet UIButton * actionButton;
@property (weak, nonatomic) IBOutlet UILabel * description;
@property (weak, nonatomic) IBOutlet UIImageView * actionImg;

@property (nonatomic,assign) id delegate;

- (IBAction)cellButtonAction:(id)sender;
- (IBAction)activateButtonAction:(id)sender;

@end
