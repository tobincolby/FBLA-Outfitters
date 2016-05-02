//
//  ViewMyOutfitsViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewMyOutfitsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    IBOutlet UICollectionView *collectionView;
    IBOutlet UILabel *username;
    IBOutlet UILabel *name;
    IBOutlet UITextView *bio;
    NSMutableArray *json;
    UIRefreshControl *refreshControl;
}
@property (weak, nonatomic) IBOutlet UILabel *followerNum;
@property (weak, nonatomic) IBOutlet UILabel *followingNum;

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic)UILabel *username;
@property (strong, nonatomic)UILabel *name;
@property (strong, nonatomic)UITextView *bio;
@property (strong, nonatomic)NSString *nameText;
@property (strong, nonatomic)NSString *usernameText;
@property (strong, nonatomic)NSString *bioText;
@property (weak, nonatomic) IBOutlet UIButton *followButton;


@end
