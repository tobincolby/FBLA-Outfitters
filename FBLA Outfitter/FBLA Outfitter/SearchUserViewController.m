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
#import "ViewMyOutfitsViewController.h"
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

    UIBarButtonItem *BackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:BackButton];
    
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
        [usersSearch addObject:info];
    }
}

//Search Bar Properties
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText.lowercaseString isEqualToString:@""]){
        [usersSearch removeAllObjects];
        for(int i=0; i<[jsonUsers count]; i++){
            NSDictionary *info = [jsonUsers objectAtIndex:i];
            [usersSearch addObject:info];
        }
        [self->tableView reloadData];
    }else{
    NSMutableArray *newArr = [[NSMutableArray alloc]init];
    for(int i=0;i<[jsonUsers count];i++){
        NSString *username = [[jsonUsers objectAtIndex:i] objectForKey:@"username"];
        if([username rangeOfString:searchText.lowercaseString].location != NSNotFound){
            [newArr addObject:[jsonUsers objectAtIndex:i]];
        }
    }
    usersSearch = newArr;
    [self->tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"findperson" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"findperson"]){
        ViewMyOutfitsViewController *mine = [segue destinationViewController];
        NSIndexPath *indexPath = [self->tableView indexPathForSelectedRow];
        NSDictionary *info = [usersSearch objectAtIndex:indexPath.row];
        mine.nameText = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"first_name"],[info objectForKey:@"last_name"]];
        mine.usernameText = [info objectForKey:@"username"];
        mine.bioText = [info objectForKey:@"bio"];
        mine.user_id = [info objectForKey:@"user_id"];
        
    }
    
}

//TableView Properties
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentViewCell *cell = [self->tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.commentLabel.text = [[usersSearch objectAtIndex:indexPath.row] objectForKey:@"username"];
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
