//
//  ViewController.m
//  yasi
//
//  Created by MrLee on 2020/4/23.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"http://q9882xtkz.bkt.clouddn.com/static/avatars/1587622642_Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202020-03-23%20at%2014.09.58.png"] placeholderImage:[UIImage imageNamed:@"ll.jpg"]];
    
}


@end
