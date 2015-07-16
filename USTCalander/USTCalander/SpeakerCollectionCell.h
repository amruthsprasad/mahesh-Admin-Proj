//
//  SpeakerCollectionCell.h
//  USTCalander
//
//  Created by Rony Antony on 16/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakerCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView * profileImg;

@end

@interface SpeakerCellFlowLayout : UICollectionViewFlowLayout

@end
