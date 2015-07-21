//
//  PollTableCell.m
//  USTCalander
//
//  Created by Rony Antony on 21/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "PollTableCell.h"

@implementation PollTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
