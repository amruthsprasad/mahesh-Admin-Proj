//
//  LeaderBoardCell.h
//  USTCalander
//
//  Created by Rony Antony on 16/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel * title;
@property (weak, nonatomic) IBOutlet UILabel * descrip;
@property (weak, nonatomic) IBOutlet UILabel * pointLabel;
@property (weak, nonatomic) IBOutlet UIImageView * profileImg;

@end
