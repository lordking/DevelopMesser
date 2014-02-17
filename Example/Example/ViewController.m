//
//  ViewController.m
//  Example
//
//  Created by 金磊 on 14-1-22.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "DMDebug.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_list;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ViewController


- (NSArray*)list
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.list;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_list = [self list];
    DMPRINT(@"list:%@", _list);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_list[section][@"list"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _list[section][@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *subList = _list[indexPath.section][@"list"];
    
    if ([subList count] > 0) {
        cell.textLabel.text = subList[indexPath.row][@"title"];
        cell.detailTextLabel.text = subList[indexPath.row][@"description"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *subList = _list[indexPath.section][@"list"];
    
    if ([subList count] > 0) {
        NSString *title = subList[indexPath.row][@"title"];
        [self performSegueWithIdentifier:title sender:subList[indexPath.row]];
    }
    
}

@end
