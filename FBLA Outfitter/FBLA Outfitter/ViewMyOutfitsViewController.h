//
//  ViewMyOutfitsViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewMyOutfitsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (strong, nonatomic) IBOutlet UICollectionView *allOutfits;

@end
