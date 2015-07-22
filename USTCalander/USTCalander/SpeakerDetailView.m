//
//  SpeakerDetailView.m
//  USTCalander
//
//  Created by Rony Antony on 19/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "SpeakerDetailView.h"
#import "USTServiceProvider.h"
#import "Constants.h"

@interface SpeakerDetailView ()

@end

@implementation SpeakerDetailView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ContainerBridgeView * contBridgObj = [ContainerBridgeView sharedInstance];
    RootContainerView * rootContObj = (RootContainerView *)[contBridgObj getRootContainerObj];
    rootContObj.titleLabel.text = @"Single Agenda";
    _speakerSeassions=[[NSMutableArray alloc]init];
    self.currentView=@"speakerAbout";
    [self setSpeakerAboutActive];
    [self executeNetworkService];

}


-(void)executeNetworkService{
    [USTServiceProvider getSpeakerDetailsWithId:_speakerID withCompletionHandler:^(USTRequest *request) {
        [self setViewWithSpeakerValues:request];
    }];
}

-(void)setViewWithSpeakerValues:(USTRequest*)request
{
    _titleLabel.text=[NSString stringWithFormat:@"%@ %@",[request.responseDict objectForKey:@"speaker_fname"],[request.responseDict objectForKey:@"speaker_fname"]];
    _descripLabel.text=[request.responseDict objectForKey:@"speaker_desg"];
    _speakerSeassions = [request.responseDict objectForKey:@"agendas"];
    _aboutSpeaker = [request.responseDict objectForKey:@"speaker_about"];
    NSString * imageName = [request.responseDict objectForKey:@"speaker_img"];
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [USTServiceProvider getImageWithName:imageName];//[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrlCroped,postImageName]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                        self.profileImg.image = image;
                    //cell.activityImageView.frame = CGRectMake(cell.activityImageView.frame.origin.x, cell.activityImageView.frame.origin.y,309, 180);
                    
                });
            }
        }
    });
    [self SessionBtnActionpost];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setSpeakerSessionActive{
    self.SessionSelectLine.frame = CGRectMake( self.SessionSelectLine.frame.origin.x, 34, self.SessionSelectLine.frame.size.width, 10);
    self.SessionOpacityView.alpha=0;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 40, self.AboutSelectLine.frame.size.width, 4);
    self.AboutOpacityView.alpha=0.5;
}

-(void)setSpeakerAboutActive{
    self.SessionSelectLine.frame = CGRectMake( self.SessionSelectLine.frame.origin.x, 40, self.SessionSelectLine.frame.size.width, 4);
    self.SessionOpacityView.alpha=0.5;
    self.AboutSelectLine.frame = CGRectMake( self.AboutSelectLine.frame.origin.x, 34, self.AboutSelectLine.frame.size.width, 10);
    self.AboutOpacityView.alpha=0;
}

- (void)SessionBtnActionpost {
    self.currentView=@"speakerSession";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"speakerdetailsRecieved" object:nil userInfo:nil];
}

- (IBAction)SessionBtnAction:(id)sender {
    self.currentView=@"speakerSession";
    [self setSpeakerSessionActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeakerDetailNotification" object:nil userInfo:nil];
}

- (IBAction)AboutBtnAction:(id)sender {
    self.currentView=@"speakerAbout";
    [self setSpeakerAboutActive];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeakerDetailNotification" object:nil userInfo:nil];
}


@end
