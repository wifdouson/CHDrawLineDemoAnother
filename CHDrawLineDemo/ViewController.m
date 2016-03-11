//
//  ViewController.m
//  CHDrawLineDemo
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "ViewController.h"
#import "DrawSignView.h"
#import "Masonry.h"


@interface ViewController ()
{
   
}
@property (nonatomic,strong)DrawSignView * drawView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor=[UIColor whiteColor];
    self.drawView=[[DrawSignView alloc]initWithFrame:CGRectMake(10, 60, 500, 300)];

    [self.view addSubview:self.drawView];
    self.drawView.backgroundColor=[UIColor orangeColor];

//    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    [self.drawView sizeToFit];
 
    
}



- (BOOL)shouldAutorotate{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

//Returns the interface orientation to use when presenting the view controller.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
