//
//  BBAnimatedViewController.m
//  AnimatedTableViewProgrammatically
//
//  Created by Bryan Boyko on 8/21/14.
//  Copyright (c) 2014 Bryan Boyko. All rights reserved.
//

#import "BBAnimatedViewController.h"
#import "BBTriangleGradient.h"

@interface BBAnimatedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UITableViewCell *cell;

//- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;

@end

@implementation BBAnimatedViewController
@synthesize cell;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add background view that will move underneath the tableview
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -150, 320, 620)];
    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PalmTreeLong"]];
    self.view.bounds = CGRectMake(0, -100, 320, 620);
    [self.view addSubview:self.backgroundView];

    
    //add tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;

    
    // add shadow to tableview (makes motion slightly choppy..)
    self.tableView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.tableView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.tableView.layer.shadowRadius = 4.0f;
    self.tableView.layer.shadowOpacity = 1.0f;
    self.tableView.layer.shouldRasterize = YES;
    self.tableView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    //COVER the nav bar
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.tableView];
    
    //OR animate UNDERNEATH nav bar
    //[self.view addSubview:self.tableView];

    //add this to prevent background image from jumping at the start of animation
    [self.tableView clipsToBounds];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}



//override this delegate method to coordinate the animation
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", self.tableView.contentOffset.y);
    
    //animate background view relative to tableview scrolling
    [UIView animateWithDuration:0.0 animations:^{self.backgroundView.center = CGPointMake(160, 150 + self.tableView.contentOffset.y/4);}
    ];
    
    //prevent tableview from stretching at the bottom and revelaing the view underneath
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - scrollView.frame.size.height)];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //create a clear cell through which the background view is seen
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor clearColor];
    
        //set selected bacground view to clear so that backgroundView remains visible
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
        [selectedBackgroundView setBackgroundColor:[UIColor clearColor]]; // set color here
        [cell setSelectedBackgroundView:selectedBackgroundView];
        
    } else {
        
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //increase the size of the first cell
    if (indexPath.row == 0) {
        return 450;
    } else {
        return 60;
    }
}





@end
