//
//  AgendaAbout.m
//  USTCalander
//
//  Created by Rony Antony on 15/07/15.
//  Copyright (c) 2015 Amruth. All rights reserved.
//

#import "AgendaAbout.h"

@interface AgendaAbout ()

@end

@implementation AgendaAbout

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
    AgendaDetailView * agendaDetailObj = (AgendaDetailView *)self.parentViewController.parentViewController;
    agendaDetailObj.delegate = self;
    self.descripLabel.text  = @"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem";
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

#pragma mark Collection view Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"SpeakerCell";
    
    SpeakerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* NSLog(@"SETTING SIZE FOR ITEM AT INDEX %d", indexPath.row);
     CGSize mElementSize = CGSizeMake(104, 104);
     return mElementSize;*/
    int screenWidth = self.speakerCollection.frame.size.width;
    int cellSpacing = 6;
    int cellWidth = 151;
    int cellHeight = 158;
    int cellCount;
    int remainder;
    if(screenWidth>308)
    {
        cellCount = screenWidth / (cellWidth+cellSpacing);
        remainder = screenWidth % (cellWidth+cellSpacing);
        if(remainder>=cellWidth){
            cellCount = cellCount + 1;
            int increWidth = remainder - cellWidth;
            if(increWidth>0)
                increWidth = increWidth/cellCount;
            cellWidth = cellWidth + increWidth;
            cellHeight = cellHeight + increWidth;
            return CGSizeMake(cellWidth,cellHeight);
            
        }
        else{
            int increWidth = remainder / cellCount;
            cellWidth = cellWidth + increWidth;
            cellHeight = cellHeight + increWidth;
            return CGSizeMake(cellWidth,cellHeight);
        }
    }
    
    return CGSizeMake(151, 158);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 6.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 6.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}


#pragma - mark Agenda Detail View Controller Delegate Methods

- (void) agendaActivityButtonAction{
    /*AgendaActivity * agendaObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaActivityView"];
    [self.navigationController pushViewController:agendaObj animated:NO];*/
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
