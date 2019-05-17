//
//  ViewController.m
//  XYAVPlayer
//
//  Created by liu on 2019/5/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *myPlayer;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) AVPlayerItem *playerItem;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer addSublayer:self.playerLayer];
    self.playerLayer.frame = CGRectMake(0, 64, 300, 400);
    
    [self playerWithUrl:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp"];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setTitle:@"播放" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(doPlayerVideo:) forControlEvents:UIControlEventTouchUpInside];
    playButton.frame = CGRectMake(100, 450, 45, 30);
    playButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:playButton];
}

- (void)doPlayerVideo:(UIButton *)sender
{
    [self.myPlayer play];
}

- (void)playerWithUrl:(NSString *)urlString{
    
    _playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlString]];
    [self.myPlayer replaceCurrentItemWithPlayerItem:_playerItem];
    
}

#pragma mark - KVODelegate


#pragma mark - lazy
- (AVPlayerLayer *)playerLayer
{
    if(!_playerLayer){
        _myPlayer = [[AVPlayer alloc]init];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_myPlayer];
    }
    return _playerLayer;
}
@end
