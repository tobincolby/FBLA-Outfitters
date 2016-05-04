//
//  FollowersViewController.h
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 5/4/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowersViewController : UIViewController 
{
    
}
@property (strong, nonatomic) NSMutableArray *follower;
@property (strong, nonatomic) NSMutableArray *usernames;
-(void) setFollower:(NSMutableArray *)follower;

@end
