//
//  DetailViewController.m
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/23/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentViewCell.h"
#import "ViewMyOutfitsViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.likeOufit.enabled = YES;
    usernameArray = [[NSMutableArray alloc]init];
    likesLabel.text = [NSString stringWithFormat:@"%@",_likes];
    NSMutableString *str = [NSMutableString stringWithString:_caption];
    str = [str stringByReplacingOccurrencesOfString:@"%2B" withString:@"+"];
    str = [str stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
    str = [str stringByReplacingOccurrencesOfString:@"%26" withString:@"&"];
    str = [str stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
    captionText.text = str;
    photoImg.image = [UIImage imageWithData:_photo];
    self.navigationItem.title = @"View Outfits";
    
    _logged_user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    
    _chatInput.lblPlaceholder.text = @"Response...";
    
    [self getUserName];
    [self setUsername];
    [self receiveComments];
    [self getUsers];
    self->tableView.rowHeight = UITableViewAutomaticDimension;
    self->tableView.estimatedRowHeight = 100;
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self->tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *BackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:BackButton];
    
    
    NSError *error;
    NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getlikesforoutfit.php?post_id=%@",_post_id]];
    NSString *resultS = [NSString stringWithContentsOfURL:url2 encoding:NSUTF8StringEncoding error:&error];
    if([resultS isEqualToString:@"0"]){
        
    }else{
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        NSMutableArray *json2 = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:&error];
        for(int i=0;i<[json2 count];i++){
            NSDictionary *dict2 = [json2 objectAtIndex:i];
            if ([[dict2 objectForKey:@"user_id" ] isEqualToString: [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]]) {
                //blur out like_oufit
                self.likeOufit.enabled = NO;
                [self.likeOufit setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateDisabled];
                //[self.likeOufit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getAllUsers:(NSData *)data{
    NSError *error;
    jsonUsers = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

-(void)getUsers{
    NSURL *url = [NSURL URLWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/getUsers.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getAllUsers:data];
}

-(void) getUser:(NSData *)data{
    NSError *error;
    jsonUser = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

-(void) getUserName{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://thestudysolution.com/fbla_outfitter/serverside/infoforuser.php"];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_id", _user_id]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    postConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    NSURL *url = [NSURL URLWithString:postString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getUser:data];
    //NSLog(@"%@", jsonUser);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"comment" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"goToUser"]){
        ViewMyOutfitsViewController *mine = [segue destinationViewController];
        mine.user_id = _user_id;
        mine.usernameText = usernameLabel.titleLabel.text;
        NSDictionary *info = [jsonUser objectAtIndex:0];
        mine.bioText= [info objectForKey:@"bio"];
        mine.nameText = [NSString stringWithFormat:@"(%@ %@)",[info objectForKey:@"first_name"],[info objectForKey:@"last_name"]];
    }
    
    if([segue.identifier isEqualToString:@"comment"]){
        ViewMyOutfitsViewController *viewUser = [segue destinationViewController];
        NSIndexPath *indexPath = [self->tableView indexPathForSelectedRow];
        NSDictionary *info = [usernameArray objectAtIndex:indexPath.row];
        viewUser.user_id = [info objectForKey:@"user_id"];
        viewUser.usernameText = [info objectForKey:@"username"];
        viewUser.bioText = [info objectForKey:@"bio"];
        viewUser.nameText = [NSString stringWithFormat:@"(%@ %@)", [info objectForKey:@"first_name"],[info objectForKey:@"last_name"]];
        
    }
}

-(void) setUsername{
    NSIndexPath *indexPath;
    NSDictionary *info = [jsonUser objectAtIndex:indexPath.row];
    [usernameLabel setTitle:[info objectForKey:@"username"] forState:UIControlStateNormal];
}

-(void)getComments:(NSData *) data{
    NSError * error;
    jsonComments = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}

-(void)receiveComments{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://thestudysolution.com/fbla_outfitter/serverside/getcommentsforoutfit.php"];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", @"post_id", _post_id]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSURL *url = [NSURL URLWithString:postString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self getComments:data];
    NSLog(@"%@", jsonComments);
}



-(void) refreshTable{
    [self getUserName];
    //[self setUsername];
    [self receiveComments];
    //[self getUsers];
    [refreshControl endRefreshing];
    [self->tableView reloadData];
}

//Chat Input Properties
- (void)tappedView:(UITapGestureRecognizer*)tapper
{
    [_chatInput resignFirstResponder];
}

#pragma mark - THChatInputDelegate

- (void)chat:(THChatInput*)input sendWasPressed:(NSString*)text
{
    [self makeComment:text];
    [_chatInput setText:@""];
    [_chatInput resignFirstResponder];
    [self refreshTable];
}

- (void)chatShowEmojiInput:(THChatInput*)input
{
    _chatInput.textView.inputView = _chatInput.textView.inputView == nil ? _emojiInputView : nil;
    
    [_chatInput.textView reloadInputViews];
}

- (void)chatShowAttachInput:(THChatInput*)input
{
    
}


-(void) makeComment:(NSString *)comment{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                     message:@"Please fill out a response"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    
    
    if([comment isEqual:@""] || [comment isEqual:@"Question about outfit?"])
        [alert show];

    
    NSMutableString *str = [NSMutableString stringWithString:comment];
    [str replaceOccurrencesOfString:@"'" withString:@"%27" options:kNilOptions range:NSMakeRange(0, [comment length])];
    [str replaceOccurrencesOfString:@"&" withString:@"%26" options:kNilOptions range:NSMakeRange(0, [comment length])];
    [str replaceOccurrencesOfString:@"/" withString:@"%2F" options:kNilOptions range:NSMakeRange(0, [comment length])];

    
    NSMutableString *postString = [NSMutableString stringWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/makecomment.php"];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_id", _logged_user_id]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", @"post_id", _post_id]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", @"comment_text", str]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //if ([postString rangeOfString:@"+"].location != NSNotFound)
    //{
        postString = [postString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    //}
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:postString]];
    [request setHTTPMethod:@"POST"];
    postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self refreshTable];
}



- (IBAction)like:(id)sender {
    [self likeOutfit];
}
                       
-(void)likeOutfit{
    NSError *error;
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thestudysolution.com/fbla_outfitter/serverside/likeoutfit.php?user_id=%@&post_id=%@",user_id,_post_id]];
    NSLog(@"%@", url);
    NSString *result = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if([result isEqualToString:@"success"]){
        likesLabel.text = [NSString stringWithFormat:@"%i",([_likes intValue] + 1)];
        self.likeOufit.enabled = NO;
        [self.likeOufit setImage:[UIImage imageNamed:@"liked.png"] forState:UIControlStateDisabled];
        //[self.likeOufit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    }else{
        
    }
}

-(IBAction)shareOutfit:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Notice" message:@"If you are using the simulator to run this application, the share feature will not work due to the limited capabilities of the simulator!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [alert show];
    NSString *shareCaption = captionText.text;
    UIImage *shareImage = [UIImage imageWithData:_photo];
    NSURL *appStoreURL = [NSURL URLWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/openapp.php"];
    //NSString *appStoreURL = @"<a href=\"http://www.thestudysolution.com/fbla_outfitter/serverside/openapp.php\">Open App</a>";
    NSArray *shareItems = @[shareCaption, shareImage, appStoreURL];
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    activity.excludedActivityTypes = @[];
    [self presentViewController:activity animated:YES completion:nil];
    
}

//TableView Properties

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([jsonComments count]) {
        
        messageLabel.text = @"";
        messageLabel.hidden = YES;
        self->tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
        
    } else {
        
        // Display a message when the table is empty
        /*UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];*/
        messageLabel.hidden = NO;
        messageLabel.text = @"No data is available. Pull to refresh";
        //messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        //messageLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [messageLabel sizeToFit];
        
        self->tableView.backgroundView = messageLabel;
        self->tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return 0;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [jsonComments count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentViewCell *cell = [self->tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *info = [jsonComments objectAtIndex:indexPath.row];
    NSDictionary *userInfo;
    for(int i=0; i<[jsonUsers count]; i++){
        userInfo =[jsonUsers objectAtIndex:i];
        if([[userInfo objectForKey:@"user_id"]isEqualToString:[info objectForKey:@"user_id"]]){
            [usernameArray addObject:userInfo];
        cell.usernameLabel.text = [userInfo objectForKey:@"username"];
        }
    }
    NSMutableString *str = [NSMutableString stringWithString:[info objectForKey:@"comment"]];
    [str replaceOccurrencesOfString:@"%27" withString:@"'" options:kNilOptions range:NSMakeRange(0, [str length])];
    [str replaceOccurrencesOfString:@"%26" withString:@"&" options:kNilOptions range:NSMakeRange(0, [str length])];
    [str replaceOccurrencesOfString:@"%2F" withString:@"/" options:kNilOptions range:NSMakeRange(0, [str length])];

    
    cell.commentLabel.text = str;
    //cell.usernameLabel.text = [[usernameArray objectAtIndex:indexPath.row]objectForKey:@"username"];
    //NSLog(@"%@", usernameArray);
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
