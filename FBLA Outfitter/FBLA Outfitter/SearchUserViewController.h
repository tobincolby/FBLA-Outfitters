//
//  SearchUserViewController.h
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/31/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchUserViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>{
    IBOutlet UITableView *tableView;
    IBOutlet UISearchBar *searchBar;
    
    NSMutableArray *jsonUsers;
    NSMutableArray *usersSearch;
}

@property (weak,nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
