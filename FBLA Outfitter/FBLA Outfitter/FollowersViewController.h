//
//  FollowersViewController.h
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 5/4/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView * tableView;
}

@property (strong, nonatomic) NSMutableArray *follower;
@property (strong, nonatomic) NSMutableArray *usernames;
@property (strong, nonatomic) NSString *navTitle;

@end
