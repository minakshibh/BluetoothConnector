
#import "scanViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "SessionContainer.h"
#import "Transcript.h"
#import <Parse/Parse.h>
#import "loginViewController.h"
#import "Reachability.h"
#import "FMDatabase.h"

@interface scanViewController ()<MCBrowserViewControllerDelegate,SessionContainerDelegate>
{
    NSString *msgStr,*connectedDeviceNameStr;
    NSArray *docPaths;
    NSString *documentsDir, *dbPath;
    FMDatabase *database;
    NSTimer *aTimer;
}
@property (retain, nonatomic) SessionContainer *sessionContainer;
@property (retain, nonatomic) NSMutableArray *transcripts;
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
@property (strong, nonatomic) IBOutlet UIButton *nearByBtn;
@property (retain, nonatomic) MCBrowserViewController *browserViewController;
@property (strong, nonatomic) IBOutlet UILabel *hintLbl;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) IBOutlet UILabel *conectivityIndicatorLbl;
@property (strong, nonatomic) IBOutlet UILabel *browseBtnLbl;
@property (strong, nonatomic) IBOutlet UIView *gameSelectionView;
@property (strong, nonatomic) IBOutlet UILabel *logoutBtnLbl;
@property (retain, nonatomic) NSMutableDictionary *imageNameIndex;
@property (strong, nonatomic) NSString *gameTime, *gamePlayed, *startTime, *endTime;
@end

@implementation scanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.conectivityIndicatorLbl.hidden = YES;
    // Create the session
    [self createSession];
    self.hintLbl.hidden = NO;
    self.searchImg.hidden = NO;
    self.messageLbl.text = NotConnectedToAnyDevice;
    self.browseBtnLbl.text = BrowseButtontext;
    
    [self IPadDesignInatialize];
    // Do any additional setup after loading the view from its nib.
}
-(void) IPadDesignInatialize{
    if (IS_IPAD) {
        self.browseBtnLbl.font = [UIFont systemFontOfSize:34.0];
        self.logoutBtnLbl .font = [UIFont systemFontOfSize:34.0];
        [self.searchImg setFrame:CGRectMake(self.searchImg.frame.origin.x+13, self.searchImg.frame.origin.y+1.5, self.searchImg.frame.size.width-4, self.searchImg.frame.size.height-2)];
        [self.view addSubview:self.searchImg];
        self.messageLbl.font = [UIFont systemFontOfSize:40];
        self.hintLbl.font = [UIFont systemFontOfSize:30];
        
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [self IPadDesignInatialize];
    if ([msgStr isEqualToString:@"Connected"]) {
        
        
        //        self.conectivityIndicatorLbl.text = [NSString stringWithFormat:@"Connected To:%@",connectedDeviceNameStr];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Actions
- (IBAction)nearByAction:(UIButton*)sender {
    NSLog(@"%@",sender.titleLabel.text);
    if ([self.browseBtnLbl.text isEqualToString:@"Browse"]) {
        self.browserViewController = [[MCBrowserViewController alloc] initWithServiceType:@"Game" session:self.sessionContainer.session];
        
        self.browserViewController.delegate = self;
        self.browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
        self.browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
        
        [self presentViewController:self.browserViewController animated:YES completion:nil];
    }else{
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setLocale:[NSLocale currentLocale]];
        [format setDateFormat:@"hh:mm:ss a"];
        self.endTime = [format stringFromDate:date];
        
        self.gameTime = [CommonHelperClass remaningTime:self.startTime endDate:self.endTime];
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable) {
            [self saveDataToDatabase];
            aTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(aTime) userInfo:nil repeats:YES];
            NSLog(@"There IS NO internet connection");
        } else {
            NSLog(@"There IS internet connection");
            [self saveData];
            
        }
        
    }
    
}

- (IBAction)selectedGameAction:(UIButton *)sender {
    if (sender.tag == 0) {
        self.gamePlayed = @"Hangman";
    }else{
        self.gamePlayed = @"Battle Ship";
    }
    Transcript *transcript = [self.sessionContainer sendMessage:@"Game Selected"];
    
    if (transcript) {
        // Add the transcript to the table view data source and reload
        [self insertTranscript:transcript];
    }
}

- (IBAction)logoutAction:(id)sender {
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        return;
    } else {
        // Correct Approach for logout using pop action.
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            //Do not forget to import AnOldViewController.h
            if ([controller isKindOfClass:[loginViewController class]]) {
                
                [self.navigationController popToViewController:controller
                                                      animated:YES];
                break;
            }
        }
    }
}

#pragma mark Useful Methods
-(void)aTime
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return;
    }else{
        PFObject *gameData = [PFObject objectWithClassName:@"gameScores"];
        docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDir = [docPaths objectAtIndex:0];
        dbPath = [documentsDir   stringByAppendingPathComponent:@"hangman.sqlite"];
        database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        NSString *queryString = [NSString stringWithFormat:@"Select * FROM gameScores "];
        FMResultSet *results = [database executeQuery:queryString];
        while ([results next]) {
            NSString *playerName = [results stringForColumn:@"playerName"];
            NSString *gameTime = [results stringForColumn:@"gameTime"];
            NSString *gamePoint = [results stringForColumn:@"gamePoint"];
            NSString *gamePlayed = [results stringForColumn:@"gamePlayed"];
            
            [gameData setObject:gameTime forKey:@"gameTime"];
            [gameData setObject:playerName forKey:@"playerName"];
            [gameData setObject:gamePoint forKey:@"gamePoint"];
            [gameData setObject:gamePlayed forKey:@"gamePlayed"];
            [gameData save];
        }
        [self deleteDataFromDatabase];
        [aTimer invalidate];
    }
}

- (void)createSession
{
    NSString *udid = [[UIDevice currentDevice] name];
    // Create the SessionContainer for managing session related functionality.
    self.sessionContainer = [[SessionContainer alloc] initWithDisplayName:udid serviceType:@"Game"];
    // Set this view controller as the SessionContainer delegate so we can display incoming Transcripts and session state changes in our table view.
    _sessionContainer.delegate = self;
}

#pragma mark - MCBrowserViewControllerDelegate methods

// Override this method to filter out peers based on application specific needs
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    return YES;
}

// Override this to know when the user has pressed the "done" button in the MCBrowserViewController
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Override this to know when the user has pressed the "cancel" button in the MCBrowserViewController
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SessionContainerDelegate

- (void)insertTranscript:(Transcript *)transcript
{
    // Add to the data source
    [_transcripts addObject:transcript];
    
    // If this is a progress transcript add it's index to the map with image name as the key
    if (nil != transcript.progress) {
        NSNumber *transcriptIndex = [NSNumber numberWithUnsignedLong:(_transcripts.count - 1)];
        [_imageNameIndex setObject:transcriptIndex forKey:transcript.imageName];
    }
    NSString *message =[NSString stringWithFormat:@"%@",transcript.message];
    if ([self.browseBtnLbl.text isEqualToString:@"Browse"]) {
        
        [self.browserViewController dismissViewControllerAnimated:YES completion:nil];
        
        NSArray *strArray =[message componentsSeparatedByString: @" is "];
        msgStr = [NSString stringWithFormat:@"%@",[strArray objectAtIndex:1]];
        connectedDeviceNameStr = [NSString stringWithFormat:@"%@",[strArray objectAtIndex:0]];
        self.messageLbl.text = message;
        
        if ([msgStr isEqualToString:@"Connected"]) {
            [self.gameSelectionView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:self.gameSelectionView];
            self.browseBtnLbl.text = @"End Game";
            self.searchImg.hidden = YES;
            
            self.messageLbl.text = @"Game is processing...";
            self.conectivityIndicatorLbl.hidden = NO;
            self.hintLbl.hidden = YES;
            NSString *name = [NSString stringWithFormat:@"Connected To:%@",connectedDeviceNameStr];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:name];
            
            NSArray *words=[name componentsSeparatedByString:@":"];
            
            
            NSString *word=[NSString stringWithFormat:@"%@:",[words objectAtIndex:0]];
            NSRange range=[name rangeOfString:word];
            [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:14] range :range];
            
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0 green:0.0f/255.0 blue:0.0f/255.0 alpha:1.0] range:range];
            
            
            [self.conectivityIndicatorLbl setAttributedText:string];
            
            
            
        }else if([msgStr isEqualToString:@"Not Connected"]){
            [self viewDidLoad];
        }
    }else{
        NSString *endSessionStr = [NSString stringWithFormat:@"%@ is Not Connected",connectedDeviceNameStr];
        NSLog(@"End Game Session: %@",message);
        if ([message isEqualToString:@"End Session"] || [message isEqualToString:endSessionStr]) {
            //            [_sessionContainer.advertiserAssistant stop];
            [_sessionContainer.session disconnect];
            
            
            [self viewDidLoad];
        }else if ([message isEqualToString:@"Game Selected"]){
            [self.gameSelectionView removeFromSuperview];
            NSDate *date = [NSDate date];
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setLocale:[NSLocale currentLocale]];
            [format setDateFormat:@"hh:mm:ss a"];
            self.startTime = [format stringFromDate:date];
            
        }
        
    }
    
}

-(void)saveData
{
    //Added Class for user defaults
    NSString *playername = [NSString stringWithFormat:@"%@",[HelperUDLib getObject:@"Username"]];
    PFObject *gameData = [PFObject objectWithClassName:@"gameScores"];
    [gameData setObject:self.gameTime forKey:@"gameTime"];
    [gameData setObject:playername forKey:@"playerName"];
    [gameData setObject:@"1" forKey:@"gamePoint"];
    [gameData setObject:self.gamePlayed forKey:@"gamePlayed"];
    [kappDelegate ShowIndicator];
    // Upload recipe to Parse
    [gameData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [kappDelegate HideIndicator];
        if (!error) {
            // Show success message
            Transcript *transcript = [self.sessionContainer sendMessage:@"End Session"];
            
            if (transcript) {
                // Add the transcript to the table view data source and reload
                [self insertTranscript:transcript];
            }
            
            //[HelperAlert alertWithOneBtn:AlerttTitleComplete description:AlertMessageSavedScoreSuccessfully okBtn:OkButtonText withTag:0];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlerttTitleComplete message:AlertMessageSavedScoreSuccessfully delegate:self cancelButtonTitle:OkButtonText otherButtonTitles:nil];
//            alert.tag =0;
//            [alert show];
            [self addRanking];
            // Dismiss the controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [HelperAlert alertWithOneBtn:AlerttTitleFailure description:[error localizedDescription] okBtn:OkButtonText];//tag=3
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlerttTitleFailure message:[error localizedDescription] delegate:self cancelButtonTitle:OkButtonText otherButtonTitles:nil];
//            alert.tag =3;
//            [alert show];
        }
        
    }];
}


#pragma mark - SessionContainerDelegate
- (void)receivedTranscript:(Transcript *)transcript
{
    // Add to table view data source and update on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [self insertTranscript:transcript];
    });
}

- (void)updateTranscript:(Transcript *)transcript
{
    // Find the data source index of the progress transcript
    NSNumber *index = [_imageNameIndex objectForKey:transcript.imageName];
    NSUInteger idx = [index unsignedLongValue];
    // Replace the progress transcript with the image transcript
    [_transcripts replaceObjectAtIndex:idx withObject:transcript];
    
}

- (void) saveDataToDatabase{
    //Added Class for user defaults
    NSString *playername = [NSString stringWithFormat:@"%@",[HelperUDLib getObject:@"Username"]];
    
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"hangman.sqlite"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *insertSQL  = [NSString stringWithFormat:@"INSERT INTO gameScores (gameTime,gamePoint,gamePlayed,playerName) VALUES ( \"%@\",1,\"%@\", \"%@\")",self.gameTime,self.gamePlayed,playername];
    [database executeUpdate:insertSQL];
    [database close];
}

-(void) deleteDataFromDatabase
{
    docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDir = [docPaths objectAtIndex:0];
    dbPath = [documentsDir   stringByAppendingPathComponent:@"hangman.sqlite"];
    database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    
    NSString* queryString = [NSString stringWithFormat:@"DELETE FROM gameScores"];
    [database executeUpdate:queryString];
}
-(void)addRanking
{
    //Added Class for user defaults
    NSString *playername = [NSString stringWithFormat:@"%@",[HelperUDLib getObject:@"Username"]];
    PFQuery *query = [PFQuery queryWithClassName:@"gameRanking"];
    [query whereKey:@"playerName" equalTo:playername];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSLog(@"Found the data = %@",[objects valueForKey:@"gamePoint"]);
            NSString *rankingStr = [NSString stringWithFormat:@"%@", [objects valueForKey:@"gamePoint"]];
            int ranking = [rankingStr intValue];
            
            if (objects.count == 0) {
                rankingStr = [NSString stringWithFormat:@"%d",ranking];
                rankingStr = [NSString stringWithFormat:@"%d",ranking];
                PFObject *gameRatingData = [PFObject objectWithClassName:@"gameRanking"];
                
                [gameRatingData setObject:playername forKey:@"playerName"];
                gameRatingData [@"gamePoint"] = @1;
                [gameRatingData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [kappDelegate HideIndicator];
                    if (!error) {
                        
                        [HelperAlert alertWithOneBtn:AlerttTitleComplete description:Alert_Message_Successfully_Ranking_and_Score_Saved okBtn:OkButtonText];//tag=1
                        
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlerttTitleComplete message:AlertMessageSuccessfullyRankingSaved delegate:self cancelButtonTitle:OkButtonText otherButtonTitles:nil];
//                        alert.tag =1;
//                        [alert show];
                        
                        // Dismiss the controller
                        [self dismissViewControllerAnimated:YES completion:nil];
                        
                    } else {
                        
                        [HelperAlert alertWithOneBtn:AlerttTitleFailure description:[error localizedDescription] okBtn:OkButtonText];//tag=2
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlerttTitleFailure message:[error localizedDescription] delegate:self cancelButtonTitle:OkButtonText otherButtonTitles:nil];
//                        alert.tag =2;
//                        [alert show];
                        
                    }
                    
                }];
            }else{
                NSString *ObjectID = [NSString stringWithFormat:@"%@",[objects valueForKey:@"objectId"]];
                ObjectID = [ObjectID stringByReplacingOccurrencesOfString:@"(" withString:@""];
                ObjectID = [ObjectID stringByReplacingOccurrencesOfString:@")" withString:@""];
                ObjectID = [ObjectID stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                ObjectID = [ObjectID stringByReplacingOccurrencesOfString:@" " withString:@""];
                PFObject *gameRatingData = [PFObject objectWithoutDataWithClassName:@"gameRanking" objectId:ObjectID];
                [gameRatingData incrementKey:@"gamePoint"];
                [gameRatingData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        
                        [HelperAlert alertWithOneBtn:AlerttTitleComplete description:Alert_Message_Successfully_Ranking_and_Score_Saved okBtn:OkButtonText];//tag=1
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlerttTitleComplete message:AlertMessageSuccessfullyRankingSaved delegate:self cancelButtonTitle:OkButtonText otherButtonTitles:nil];
//                        alert.tag =1;
//                        [alert show];
                        
                    } else {
                        
                        [HelperAlert alertWithOneBtn:AlerttTitleFailure description:[error localizedDescription] okBtn:OkButtonText]; //tag=2
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AlerttTitleFailure message:[error localizedDescription] delegate:self cancelButtonTitle:OkButtonText otherButtonTitles:nil];
//                        alert.tag =2;
//                        [alert show];
                    }
                }];
            }
            
            // The find succeeded. The first 100 objects are available in objects
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 0) {
//        [self addRanking];
//    }
//}
@end
