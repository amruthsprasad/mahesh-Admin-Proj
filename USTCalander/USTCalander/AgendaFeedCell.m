//
//  ActivityFeedCell.m
//  USTCalander
//
//  Created by Amruth on 02/06/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaFeedCell.h"

@implementation AgendaFeedCell
@synthesize description;

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)cellButtonAction:(id)sender{
    [self.delegate cellButtonAction:sender];
}

- (IBAction)activateButtonAction:(id)sender{
    [self.delegate activateButtonAction:sender];
}


@end
