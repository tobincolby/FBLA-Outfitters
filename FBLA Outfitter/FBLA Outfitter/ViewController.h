//
//  ViewController.h
//  FBLA Outfitter
//
//  Created by Colby Tobin on 10/25/15.
//  Copyright (c) 2015 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *tableView;
    NSMutableArray *json;
    IBOutlet UILabel *messageLabel;
    UIRefreshControl *refreshControl;
    NSString *user_id;
    NSString *username;
    NSMutableArray *userArray;
    NSMutableArray *usernameArray;
    
   
}

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (strong, nonatomic) NSString * navTitle;

@end

