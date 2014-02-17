//
//  FontDownLoad.m
//  TransitionsDemo
//
//  Created by sohu on 14-1-9.
//  Copyright (c) 2014年 Colin Eberhardt. All rights reserved.
//

#import "FontViewDonwload.h"
#import <CoreText/CoreText.h>

@interface FontViewDonwload ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _installFontsArray;
    NSArray * _canDownloadFontArray;
    UIProgressView * _progressView;
    UITextView * _textView;
    UIActivityIndicatorView * _activityIndicatorView;
}
@end

@implementation FontViewDonwload

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Download Font";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, CGRectGetHeight(self.view.bounds) - 40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _textView = [[UITextView  alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 40, 320, 60)];
    [_textView  setUserInteractionEnabled:NO];
    _textView.textAlignment = NSTextAlignmentCenter;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor redColor];
    [self.view addSubview:_textView];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(self.view.bounds) - 10, 280, 60)];
    _progressView.progress = 0.f;
    [self.view addSubview:_progressView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.center = _tableView.center;
    [self.view addSubview:_activityIndicatorView];
    _activityIndicatorView.hidesWhenStopped = YES;
    [_activityIndicatorView stopAnimating];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadData)];
    
    _installFontsArray = [[UIFont familyNames] mutableCopy];
 
   _canDownloadFontArray = @[@"STXingkai-SC-Light",
                             @"DFWaWaSC-W5",
                             @"FZLTXHK--GBK1-0",
                             @"STLibian-SC-Regular",
                             @"LiHeiPro",
                             @"HiraginoSansGB-W3",
                             @"Weibei-SC-Bold"];
    _textView.text = @"我是测试字体 test font";
    [self reloadData];

}

- (void)reloadData
{
    [_tableView reloadData];
}
#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? [_installFontsArray count] : _canDownloadFontArray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? @"系统自带字体" : @"单独下载字体";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FONT"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FONT"];
    }
    if (indexPath.section) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ 汉字",_installFontsArray[indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@ 汉字",_canDownloadFontArray[indexPath.row]];
        cell.accessoryType = [self hasInstalled:_canDownloadFontArray[indexPath.row]] ? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section) {
        [self asynchronouslySetFontName:_canDownloadFontArray[indexPath.row]];
    }else{
        _textView.font = [UIFont fontWithName:_installFontsArray[indexPath.row] size:14.f];
    }
}
#pragma mark --
- (BOOL)hasInstalled:(NSString *)fontName
{
    UIFont* aFont = [UIFont fontWithName:fontName size:12.];
    NSLog(@"%@",aFont);
    // If the font is already downloaded
	if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        // Go ahead and display the sample text.
		return YES;
	}
    return NO;
}
- (void)asynchronouslySetFontName:(NSString *)fontName
{
	
	if ([self hasInstalled:fontName]) {
        _textView.font = [UIFont fontWithName:fontName size:12.f];
        return;
    }
    // Create a dictionary with the font's PostScript name.
	NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    // Create a new font descriptor reference from the attributes dictionary.
	CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
	__block BOOL errorDuringDownload = NO;
	
	// Start processing the font descriptor..
    // This function returns immediately, but can potentially take long time to process.
    // The progress is notified via the callback block of CTFontDescriptorProgressHandler type.
    // See CTFontDescriptor.h for the list of progress states and keys for progressParameter dictionary.
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
		double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
		
		if (state == kCTFontDescriptorMatchingDidBegin) {
			dispatch_async( dispatch_get_main_queue(), ^ {
                // Show an activity indicator
				[_activityIndicatorView startAnimating];
				_activityIndicatorView.hidden = NO;
                [_progressView setHidden:NO];
                // Show something in the text view to indicate that we are downloading
				_textView.font = [UIFont systemFontOfSize:14.];
				
				NSLog(@"Begin Matching");
			});
		} else
            
            if (state == kCTFontDescriptorMatchingDidFinish) {
			dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the activity indicator
				[_activityIndicatorView stopAnimating];
				_activityIndicatorView.hidden = YES;
                [_progressView setHidden:YES];
                // Display the sample text for the newly downloaded font
				_textView.font = [UIFont fontWithName:fontName size:14];
				[_tableView reloadData];
//                // Log the font URL in the console
//				CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, 0., NULL);
//                CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
//				NSLog(@"%@", (__bridge NSURL*)(fontURL));
//                CFRelease(fontURL);
//				CFRelease(fontRef);
                
				if (!errorDuringDownload) {
					NSLog(@"%@ downloaded", fontName);
				}
			});
		} else
            
            if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
			dispatch_async( dispatch_get_main_queue(), ^ {
                // Show a progress bar
				_progressView.progress = 0.0;
				_progressView.hidden = NO;
				NSLog(@"Begin Downloading");
			});
		} else
            
            if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
			dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the progress bar
				_progressView.hidden = YES;
				NSLog(@"Finish downloading");
			});
		} else
            
            if (state == kCTFontDescriptorMatchingDownloading) {
			dispatch_async( dispatch_get_main_queue(), ^ {
                // Use the progress bar to indicate the progress of the downloading
				[_progressView setProgress:progressValue / 100.0 animated:YES];
				NSLog(@"Downloading %.0f%% complete", progressValue);
			});
		} else
            
            if (state == kCTFontDescriptorMatchingDidFailWithError) {
            // An error has occurred.
            // Get the error message
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            // Set our flag
            NSLog(@"%@",[error description]);
            errorDuringDownload = YES;
            
            dispatch_async( dispatch_get_main_queue(), ^ {
                _progressView.hidden = YES;
			});
		}
        
		return (bool)YES;
	});
    
}
@end
