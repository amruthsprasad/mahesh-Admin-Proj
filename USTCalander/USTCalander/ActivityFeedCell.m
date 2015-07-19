//
//  ActivityFeedCell.m
//  USTCalander
//
//  Created by Amruth on 02/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "ActivityFeedCell.h"

@implementation ActivityFeedCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 1.50f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;

}



- (IBAction)viewAllLikeAction:(id)sender{
     [self.delegate viewAllLikeAction:self];
}

- (IBAction)viewAllCommentAction:(id)sender{
     [self.delegate viewAllCommentBtnAction:self];
}

- (IBAction)likeBtnAction:(id)sender{
    [self.delegate likeBtnAction:self];
}

- (IBAction)commentBtnAction:(id)sender{
    [self.delegate commentBtnAction:self];
}

- (IBAction)twitterBtnAction:(id)sender{
    [self.delegate twitterBtnAction:self];
}

- (IBAction)facebookBtnAction:(id)sender{
    [self.delegate facebookBtnAction:self];
}

@end
