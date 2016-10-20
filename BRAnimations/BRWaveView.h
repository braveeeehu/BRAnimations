//
//  BRWaveView.h
//  BRAnimations
//
//  Created by brave_hu on 2016/10/16.
//  Copyright © 2016年 brave_hu. All rights reserved.
// github地址 https://github.com/braveeeehu/BRAnimations

#import <UIKit/UIKit.h>
typedef void(^waveBlock)(CGPoint point);

@interface BRWaveView : UIView

@property (nonatomic, copy)waveBlock block;

- (void)startWaveAnimation ;
- (void)stopWaveAnimation;

@end
