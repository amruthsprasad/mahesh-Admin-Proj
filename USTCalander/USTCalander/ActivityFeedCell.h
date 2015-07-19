//
//  ActivityFeedCell.h
//  USTCalander
//
//  Created by Amruth on 02/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protocol definition starts here
@class ActivityFeedCell;
@protocol ActivityFeedCellDelegate <NSObject>
@required
- (void) likeBtnAction:(ActivityFeedCell *)sender;
- (void) commentBtnAction:(ActivityFeedCell *)sender;
- (void) twitterBtnAction:(ActivityFeedCell *)sender;
- (void) facebookBtnAction:(ActivityFeedCell *)sender;
- (void) viewAllLikeBtnAction:(ActivityFeedCell *)sender;
- (void) viewAllCommentBtnAction:(ActivityFeedCell *)sender;
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
@property (weak, nonatomic) IBOutlet UILabel * likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel * cmntCountLabel;
@property (weak, nonatomic) IBOutlet UIButton * likeButton;

@property (nonatomic,assign) id delegate;

- (IBAction)viewAllLikeAction:(id)sender;
- (IBAction)viewAllCommentAction:(id)sender;

- (IBAction)likeBtnAction:(id)sender;
- (IBAction)commentBtnAction:(id)sender;
- (IBAction)twitterBtnAction:(id)sender;
- (IBAction)facebookBtnAction:(id)sender;

@end
