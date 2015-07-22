//
//  AgendaViewController.h
//  USTCalander
//
//  Created by Amruth on 07/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgendaFeedCell.h"
#import "ContainerBridgeView.h"


@interface AgendaViewController : UIViewController<AgendaFeedCellDelegate>{
    RootContainerView * rootContObj;
}
@property(nonatomic , strong)NSString * agendaType;

@end
