//
//  ActivityFeedCell.h
//  USTCalander
//
//  Created by Amruth on 02/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protocol definition starts here
@protocol ActivityFeedCellDelegate <NSObject>
@required
- (void) likeBtnAction:(id)sender;
- (void) commentBtnAction:(id)sender;
@end

@interface ActivityFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *seperator1;
@property (weak, nonatomic) IBOutlet UIView *seperator2;
@property (weak, nonatomic) IBOutlet UIView *seperator3;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel * authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel * post_dateLabel;
@property (weak, nonatomic) IBOutlet UILabel * post_textLabel;
@property (weak, nonatomic) IBOutlet UILabel * post_AgendaName;

@property (nonatomic,assign) id delegate;

- (IBAction)likeBtnAction:(id)sender;
- (IBAction)commentBtnAction:(id)sender;

@end
