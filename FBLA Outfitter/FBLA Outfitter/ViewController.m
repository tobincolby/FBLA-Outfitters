//
//  ViewController.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 10/25/15.
//  Copyright (c) 2015 Tobin Technologies. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "CustomCell.h"
#import "DetailViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    _barButton.image = [UIImage imageNamed:@"menu2.png"];
    self.navigationItem.title = @"View Outfits";
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self getPosts];
    [self getUsers];
    self->tableView.rowHeight = UITableViewAutomaticDimension;
    self->tableView.estimatedRowHeight = 310;
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self->tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [self refreshTable];
    
    UIBarButtonItem *BackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:BackButton];

        
}

-(void) getData:(NSData *) data{
    NSError *error;
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}


-(void) getPosts{
    
    NSURL *url = [NSURL URLWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/viewalloutfits.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getData:data];
}

-(void) getUsernames:(NSData *) data{
    NSError *error;
    userArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

-(void) getUsers{
    NSURL *url = [NSURL URLWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getUsers.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getUsernames:data];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"go" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"go"]){
        DetailViewController *detailView = [segue destinationViewController];
        NSIndexPath *indexPath = [self->tableView indexPathForSelectedRow];
        NSDictionary *info = [json objectAtIndex:indexPath.row];
        detailView.post_id = [info objectForKey:@"post_id"];
        detailView.caption = [info objectForKey:@"post_text"];
        detailView.likes = [info objectForKey:@"num_likes"];
        detailView.user_id = [info objectForKey:@"user_id"];
        NSString *img = [@"http://www.thestudysolution.com/fbla_outfitter/" stringByAppendingString:[info objectForKey:@"post_image_url"]];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
        detailView.photo = data;
    }

}
-(void)viewDidAppear:(BOOL)animated{
    [self refreshTable];

}
-(void) refreshTable{
    [self getPosts];
    [refreshControl endRefreshing];
    [self->tableView reloadData];
}


//Table view properties
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([json count]) {
        
        messageLabel.text = @"";
        messageLabel.hidden = YES;
        self->tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        /*UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];*/
        messageLabel.hidden = NO;
        messageLabel.text = @"No data is available. Pull to refresh";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [messageLabel sizeToFit];
        
        self->tableView.backgroundView = messageLabel;
        self->tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [json count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    
    CustomCell *cell = [self->tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    
    NSDictionary *info = [json objectAtIndex:indexPath.row];
    /*//for (int i=0; i<[userArray count]; i++) {
        NSDictionary *userInfo = [userArray objectAtIndex:indexPath.row];
        //if ([[userInfo objectForKey:@"user_id"] isEqualToString:[info objectForKey:@"user_id"]]) {
            cell.username.text = [userInfo objectForKey:@"username"];
        //}
    //}*/
    
    NSString *img = [@"http://www.thestudysolution.com/fbla_outfitter/" stringByAppendingString:[info objectForKey:@"post_image_url"]];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    
    
    cell.username.text = [info objectForKey:@"user_id"];
    cell.caption.text = [info objectForKey:@"post_text"];
    cell.photo.image = [UIImage imageWithData:data];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
