//
//  FollowersViewController.m
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 5/4/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "FollowersViewController.h"
#import "ViewMyOutfitsViewController.h"
#import "SearchCell.h"

@interface FollowersViewController ()

@end

@implementation FollowersViewController
@synthesize follower = _follower;
@synthesize usernames = _usernames;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUsernames];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 70;
    self.navigationItem.title = _navTitle;
}

-(NSString*) getUserNameById:(NSString *)user_id{
    NSString * urlString = [NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getUsername.php?user_id=%@", user_id];
    NSURL *url = [NSURL URLWithString:urlString];
    NSError *error;
    NSString *username = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    return username;
}

-(void) getUsernames{
    _usernames = [[NSMutableArray alloc] init];
    for (int i=0; i<[_follower count]; i++) {
        NSDictionary *info = [_follower objectAtIndex:i];
        if([self.navTitle isEqualToString:@"Followers"]){
            _usernames[i] = [self getUserNameById:[info objectForKey:@"user_id"]];
        } else{
            _usernames[i] = [self getUserNameById:[info objectForKey:@"person_following_id"]];
        }
    }
    NSLog(@"%@", _usernames);
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_usernames count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [self->tableView dequeueReusableCellWithIdentifier:@"user"];
    cell.searchLabel.text = [_usernames objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
