//
//  DailySummaryViewController.m
//  TimeList
//
//  Created by LiHaomiao on 2016/12/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "DailySummaryViewController.h"
#import "Constants.h"
#import "DailySummaryDataSource+FMDB.h"

@interface DailySummaryViewController()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, readwrite, strong) DailySummaryDataSource *dataSource;

@property (nonatomic, readwrite, copy) DailySumaryComplete complete;

@end

@implementation DailySummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"每日总结";
    [self p_configTimeLabel];
    if ( !_dataSource ){
        _dataSource = [[DailySummaryDataSource alloc] init];
        [_dataSource insertSQL];
    }
    _textView.text = _dataSource.summaryContent;
    _textView.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_dataSource upadteSQL];
}

- (void)p_configTimeLabel
{
   self.timeLabel.text = [NSDate stringFromDay:[NSDate date]];
}

- (void)data:(DailySummaryDataSource *)data complete:(DailySumaryComplete)complete
{
    _dataSource = data;
    _complete = complete;
}

#pragma mark - textViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _dataSource.summaryContent = textView.text;
}


@end
