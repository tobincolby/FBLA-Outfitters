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
   
}

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;


@end

