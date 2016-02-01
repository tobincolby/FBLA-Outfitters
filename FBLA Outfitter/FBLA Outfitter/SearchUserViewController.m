//
//  SearchUserViewController.m
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/31/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "SearchUserViewController.h"
#import "CommentViewCell.h"
#import "SWRevealViewController.h"

@interface SearchUserViewController ()

@end

@implementation SearchUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    _barButton.image = [UIImage imageNamed:@"menu2.png"];
    self.navigationItem.title = @"Search for Users";

    [self getUsers];
    [self setSearchArray];
    self->tableView.rowHeight = UITableViewAutomaticDimension;
    self->tableView.estimatedRowHeight = 70;
}

-(void)getData:(NSData *)data{
    NSError *error;
    jsonUsers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

-(void)getUsers{
    NSURL *url = [NSURL URLWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getUsers.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getData:data];
}

-(void)setSearchArray{
    NSDictionary *info;
    usersSearch = [[NSMutableArray alloc]init];
    for(int i=0; i<[jsonUsers count]; i++){
        info = [jsonUsers objectAtIndex:i];
        [usersSearch addObject:[info objectForKey:@"username"]];
    }
}

//Search Bar Properties
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}


//TableView Properties
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentViewCell *cell = [self->tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.commentLabel.text = [usersSearch objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [usersSearch count];
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
