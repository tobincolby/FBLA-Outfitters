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

@interface FollowersViewController (){
    NSMutableArray *userArr;
    NSString *selectedUserID;
}

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
    [self getUsers];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *username = [_usernames objectAtIndex:indexPath.row];
    NSString *select = @"0";
    for(int i=0;i<[userArr count];i++){
        NSDictionary *info = [userArr objectAtIndex:i];
        if([[info objectForKey:@"username"] isEqualToString:username]){
            select = [info objectForKey:@"user_id"];
        }
    }
    selectedUserID = select;
    [self performSegueWithIdentifier:@"toPerson" sender:self];
}

-(void)getUsers{
    NSURL *url = [NSURL URLWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getUsers.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    userArr = [[NSMutableArray alloc]init];
    NSDictionary *info;
    for(int i=0;i<[jsonArray count];i++){
        info = [jsonArray objectAtIndex:i];
        [userArr addObject:info];
    }
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toPerson"]){
        ViewMyOutfitsViewController *mine = [segue destinationViewController];
        for(int i=0;i<[userArr count];i++){
            NSDictionary *dict = [userArr objectAtIndex:i];
            if ([[dict objectForKey:@"user_id"] isEqualToString:selectedUserID]) {
                mine.nameText = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"]];
                mine.usernameText = [dict objectForKey:@"username"];
                mine.bioText = [dict objectForKey:@"bio"];
                mine.user_id = [dict objectForKey:@"user_id"];
            }
        
        }
    }
}


@end
