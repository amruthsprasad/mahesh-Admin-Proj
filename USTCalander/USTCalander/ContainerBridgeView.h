//
//  ContainerBridgeView.h
//  USTCalander
//
//  Created by Rony Antony on 11/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerBridgeView : UIViewController{
}

+ (ContainerBridgeView *)sharedInstance;
- (void)swapViewControllers:(NSString *)segueIdentifier;

@end

@interface EmptySegue : UIStoryboardSegue

@end

