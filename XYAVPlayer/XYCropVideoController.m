//
//  XYCropVideoController.m
//  XYAVPlayer
//
//  Created by liu on 2019/5/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import "XYCropVideoController.h"
#import <AVFoundation/AVFoundation.h>

@interface XYCropVideoController ()
{
    UIImageView *_cImageView;
}

@property (nonatomic, strong) NSMutableArray *imageArr;

@end

@implementation XYCropVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBtn.frame = CGRectMake(30, 350, 50, 40);
    imgBtn.backgroundColor = [UIColor greenColor];
    [imgBtn addTarget:self action:@selector(doCropAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn];
    
    _cImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 300)];
    _cImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_cImageView];

    

    
}


- (void)doCropAction:(UIButton *)sender
{
    // 视频裁剪
    [self cropWithURL:@"https://vd2.bdstatic.com/mda-ifixy7fapcza1r00/mda-ifixy7fapcza1r00.mp4?auth_key=1557592350-0-0-0ce7948778630527181fa4fe458bce3e&amp"];
}

- (void)cropWithURL:(NSString *)urlString
{
    AVURLAsset *videoAsset = [[AVURLAsset alloc]initWithURL:[NSURL URLWithString:urlString] options:nil];
    AVAssetImageGenerator *  generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:videoAsset];
    
    
    //获取总视频的长度 = 总帧数 / 每秒的帧数
    long videoSumTime = videoAsset.duration.value / videoAsset.duration.timescale ;
    
    //大于
    
    self.imageArr = [NSMutableArray array];
    for ( int i = 0 ; i < videoSumTime ; i ++){
        CMTime time = CMTimeMake(i * videoAsset.duration.timescale , videoAsset.duration.timescale);
        NSValue *value = [NSValue valueWithCMTime:time];
        [self.imageArr addObject:value];
    }
    
    
    
//    CMTime time = CMTimeMakeWithSeconds(10.2, 1);
//    CMTime actualTime;
//    NSError *error;
//    CGImageRef cgImage = [generator copyCGImageAtTime:time actualTime:&actualTime error:&error];
//    if(error){
//        NSLog(@"截取视频缩略图时发生错误 %@",error.localizedDescription);
//    }
//    CMTimeShow(actualTime);
//    UIImage *image=[UIImage imageWithCGImage:cgImage];//转化为UIImage
//    _cImageView.image = image;
    
    //    // 添加需要帧数的时间集合
    //    self.framesArray = [NSMutableArray array];
    //    for (int i = 0; i < videoSumTime; i++) {
    //        CMTime time = CMTimeMake(i *videoAsset.duration.timescale , videoAsset.duration.timescale);
    //        NSValue *value = [NSValue valueWithCMTime:time];
    //        [self.framesArray addObject:value];
    //    }
    
    [generator generateCGImagesAsynchronouslyForTimes:self.imageArr completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        NSLog(@" image :%@",image);
    }];
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
