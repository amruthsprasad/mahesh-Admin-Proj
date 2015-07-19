//
//  AgendaAbout.h
//  USTCalander
//
//  Created by Rony Antony on 15/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaDetailView.h"
#import "AgendaActivity.h"
#import "SpeakerCollectionCell.h"

@interface AgendaAbout : UIViewController

@property (nonatomic,weak) IBOutlet UILabel * dayLabel;
@property (nonatomic,weak) IBOutlet UILabel * monthLabel;
@property (nonatomic,weak) IBOutlet UILabel * yearLabel;
@property (nonatomic,weak) IBOutlet UILabel * tilteLabel;
@property (nonatomic,weak) IBOutlet UILabel * timeLabel;
@property (nonatomic,weak) IBOutlet UILabel * descripLabel;
@property (nonatomic,weak) IBOutlet UICollectionView * speakerCollection;
@property (nonatomic, strong)NSString * agendaID;


@end
