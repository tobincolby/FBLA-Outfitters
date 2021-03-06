//
//  ViewMyOutfitsViewController.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 1/18/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "ViewMyOutfitsViewController.h"
#import "SWRevealViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
#import "FollowersViewController.h"

@interface ViewMyOutfitsViewController ()

@end

@implementation ViewMyOutfitsViewController
@synthesize username = _username;
@synthesize name = _name;
@synthesize bio = _bio;


- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    _barButton.image = [UIImage imageNamed:@"menu2.png"];
    
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if([self.user_id isEqualToString:@""] || self.user_id == nil){
        self.navigationItem.title = @"View My Outfits";
        self.user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
        self.username.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
        self.name.text = [NSString stringWithFormat:@"(%@)",[[NSUserDefaults standardUserDefaults] valueForKey:@"name"] ];
        NSMutableString *bioStuff = [NSMutableString stringWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"bio"]];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"PLUSPLUS" withString:@"+"];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"COMMA7727" withString:@"'"];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"%26" withString:@"&"];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
        self.bio.text = bioStuff;
    }else{
        if([self.usernameText isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"username"]]){
            self.navigationItem.title = @"View My Outfits";
        }else
        self.navigationItem.title = [NSString stringWithFormat:@"View %@'s Outfits", self.usernameText];
        self.username.text = self.usernameText;
        self.name.text = self.nameText;
        NSMutableString *bioStuff = [NSMutableString stringWithString:self.bioText];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"PLUSPLUS" withString:@"+"];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"COMMA7727" withString:@"'"];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"%26" withString:@"&"];
        bioStuff = [bioStuff stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
        self.bio.text = bioStuff;
    }
    
    if(![self.navigationItem.title isEqualToString:@"View My Outfits"]){
        self.followButton.hidden = NO;
        self.followButton.layer.cornerRadius = 6;
        NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/followinguser.php?user_id=%@&person_following=%@",user,self.user_id]];
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if([result isEqualToString:@"following"]){
            [self.followButton setTitle:@"Unfollow User" forState:UIControlStateNormal];
            [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.followButton setBackgroundColor:[UIColor redColor]];
        }else{
            [self.followButton setTitle:@"Follow User" forState:UIControlStateNormal];
            [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.followButton setBackgroundColor:[UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0 /255.0 alpha:1.0]];
        }
    }else{
        self.followButton.hidden = YES;
    }
    
    [self followers];
    

    
    
    //NSLog(@"%@", _user_id);
    [self getMyPhotos];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self->collectionView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshCollection) forControlEvents:UIControlEventValueChanged];
    self->collectionView.alwaysBounceVertical = YES;
    UIBarButtonItem *BackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:BackButton];
    
}

-(void)followers{
    NSURL *urlFollower = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getFollowers.php?user_id=%@",self.user_id]];
    NSURL *urlFollowing = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getFollowing.php?user_id=%@", self.user_id]];
    NSError *error;
    NSData *followerData = [NSData dataWithContentsOfURL:urlFollower];
    NSData *followingData = [NSData dataWithContentsOfURL:urlFollowing];
    followers = [NSJSONSerialization JSONObjectWithData:followerData options:kNilOptions error:&error];
    following = [NSJSONSerialization JSONObjectWithData:followingData options:kNilOptions error:&error];
    NSString *followerNum = [NSString stringWithFormat:@"%lu", (unsigned long)[followers count]];
    NSString *followingNum = [NSString stringWithFormat:@"%lu", (unsigned long)[following count]];
    
    if([followerNum isEqualToString:@"null"] || followerNum == nil){
        followerNum = @"0";
    }
    if([followingNum isEqualToString:@"null"] || followingNum == nil){
        followingNum = @"0";
    }
    
    [self.viewFollowers setTitle:followerNum forState:UIControlStateNormal];
    [self.viewFollowing setTitle:followingNum forState:UIControlStateNormal];
}

- (IBAction)followUser:(id)sender {
    if([self.followButton.titleLabel.text isEqualToString:@"Follow User"]){
    NSString *user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    NSString *follow_id = self.user_id;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/followuser.php?user_id=%@&person_following=%@",user_id,follow_id]];
        //NSLog(url);
    NSError *error;
    NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if([result isEqualToString:@"yes"]){
        /*[self.followButton setTitle:@"Unfollow User" forState:UIControlStateNormal];
        
        [self.followButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];*/
        [self.followButton setTitle:@"Unfollow User" forState:UIControlStateNormal];
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setBackgroundColor:[UIColor redColor]];

        [self followers];
        //self.followButton.titleLabel.textColor = [UIColor grayColor];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was a problem when trying to follow this user. Please try again!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
    }
    }else{
        //unfollow
        NSString *user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
        NSString *follow_id = self.user_id;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/unfollowuser.php?user_id=%@&person_following=%@",user_id,follow_id]];
        //NSLog(url);
        NSError *error;
        NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        
        if([result isEqualToString:@"yes"]){
            /*[self.followButton setTitle:@"Follow User" forState:UIControlStateNormal];
            
            [self.followButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];*/
            [self.followButton setTitle:@"Follow User" forState:UIControlStateNormal];
            [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.followButton setBackgroundColor:[UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0 /255.0 alpha:1.0]];

            [self followers];
            //self.followButton.titleLabel.textColor = [UIColor grayColor];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was a problem when trying to unfollow this user. Please try again!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [alert show];
        }

    }
    [self followers];
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    [self getMyPhotos];
    [self followers];
    [self refreshCollection];
    [super viewDidAppear:YES];
}

-(void) getData:(NSData *) data{
    NSError *error;
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //NSLog(@"%@", json);
}

-(void) getMyPhotos{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/viewmyoutfits.php"];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_id", _user_id]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    NSURL *url = [NSURL URLWithString:postString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getData:data];
    //NSLog(@"%@", postString);
    
    UIBarButtonItem *BackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:BackButton];
}

-(void) refreshCollection{
    //[refreshControl beginRefreshing];
    [self getMyPhotos];
    [refreshControl endRefreshing];
    [self->collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"go" sender:self];
}*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"go"]){
        DetailViewController *detailView = [segue destinationViewController];
        NSArray *arrayOfIndexPaths = [self->collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [arrayOfIndexPaths firstObject];
        NSDictionary *info = [json objectAtIndex:indexPath.row];
        detailView.post_id = [info objectForKey:@"post_id"];
        detailView.caption = [info objectForKey:@"post_text"];
        detailView.likes = [info objectForKey:@"num_likes"];
        detailView.user_id = [info objectForKey:@"user_id"];
        NSString *img = [@"http://www.thestudysolution.com/fbla_outfitter/" stringByAppendingString:[info objectForKey:@"post_image_url"]];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
        detailView.photo = data;
    }
    
    if([[segue identifier] isEqualToString:@"follower"]){
        FollowersViewController *view = [segue destinationViewController];
        view.follower = followers;
        view.navTitle = @"Followers";
    }
    
    if([[segue identifier] isEqualToString:@"following"]){
        FollowersViewController *view = [segue destinationViewController];
        view.follower = following;
        view.navTitle = @"Following";
    }
    
}


//Collection View properties
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [json count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Reusable Cell" forIndexPath:indexPath];*/
    CollectionViewCell *cell = [self->collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *info = [json objectAtIndex:indexPath.row];
    NSString *img = [@"http://www.thestudysolution.com/fbla_outfitter/" stringByAppendingString:[info objectForKey:@"post_image_url"]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
    cell.photo.image = [UIImage imageWithData:data];
    NSLog(@"%@", img);
    return cell;
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
