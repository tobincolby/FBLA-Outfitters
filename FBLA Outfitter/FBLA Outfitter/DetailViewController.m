//
//  DetailViewController.m
//  FBLA Outfitter
//
//  Created by Ryan Tobin on 1/23/16.
//  Copyright © 2016 Tobin Technologies. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentViewCell.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.likeOufit.enabled = YES;
    
    likesLabel.text = [NSString stringWithFormat:@"Likes: %@",_likes];
    captionText.text = _caption;
    photoImg.image = [UIImage imageWithData:_photo];
    self.navigationItem.title = @"View Outfits";
    
    _chatInput.lblPlaceholder.text = @"Response...";
    
    [self getUserName];
    [self setUsername];
    [self receiveComments];
    self->tableView.rowHeight = UITableViewAutomaticDimension;
    self->tableView.estimatedRowHeight = 75;
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self->tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    
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
                [self.likeOufit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) setUsername{
    NSIndexPath *indexPath;
    NSDictionary *info = [jsonUser objectAtIndex:indexPath.row];
    usernameLabel.text = [info objectForKey:@"username"];
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
    [self receiveComments];
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

    
    NSMutableString *postString = [NSMutableString stringWithString:@"http://www.thestudysolution.com/fbla_outfitter/serverside/makecomment.php"];
    [postString appendString:[NSString stringWithFormat:@"?%@=%@", @"user_id", _user_id]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", @"post_id", _post_id]];
    [postString appendString:[NSString stringWithFormat:@"&%@=%@", @"comment_text", comment]];
    [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
        likesLabel.text = [NSString stringWithFormat:@"Likes: %i",([_likes intValue] + 1)];
        self.likeOufit.enabled = NO;
        [self.likeOufit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    }else{
        
    }
}

-(IBAction)shareOutfit:(id)sender{
    NSString *shareCaption = captionText.text;
    UIImage *shareImage = [UIImage imageWithData:_photo];
    NSString *appName = [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleName"]];
    //NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.com/app/%@",[appName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    NSString *appStoreURL = @"<BR><BR><BR><A HREF=\"http://FBLAOutfitter://\">Open App</A>";
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
    cell.commentLabel.text = [info objectForKey:@"comment"];
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
