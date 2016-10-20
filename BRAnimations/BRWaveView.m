//
//  BRWaveView.m
//  BRAnimations
//
//  Created by brave_hu on 2016/10/16.
//  Copyright © 2016年 brave_hu. All rights reserved.
// github地址 https://github.com/braveeeehu/BRAnimations

#import "BRWaveView.h"
@interface BRWaveView ()

@property (nonatomic, strong)CAShapeLayer *waveLayer;
@property (nonatomic, strong)CAShapeLayer *backWaveLayer;
@property (nonatomic, strong)CADisplayLink  *timer;
@property (nonatomic, assign)CGFloat waveOffSet;
@property (nonatomic, assign)CGFloat waveHeight;

@end

@implementation BRWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.waveHeight = 5;
        self.waveOffSet = 0;
        [self.layer addSublayer:self.backWaveLayer];
        [self.layer addSublayer:self.waveLayer];
        [self drawWave];
    }
    return self;
}
- (void)drawWave {
    self.waveOffSet ++;
    CGSize viewSize = self.frame.size;
    CGMutablePathRef frontWavePath = CGPathCreateMutable();
    CGMutablePathRef backWavePath = CGPathCreateMutable();
    CGPathMoveToPoint(frontWavePath, nil, 0,self.waveHeight );
    CGPathMoveToPoint(backWavePath, nil, 0, self.waveHeight);
    for (int i = 0; i < viewSize.width; i ++ ) {
        CGFloat x = (i + self.waveOffSet) / 50.0;
        CGFloat y = self.waveHeight * sin(x);
        CGPathAddLineToPoint(frontWavePath, nil, i, y);
        CGPathAddLineToPoint(backWavePath, nil, i, -y);
    }
    //计算中间的值   也就是头像的
    CGPoint imagePoint = CGPointMake(self.frame.size.width / 2, self.waveHeight * sin((self.frame.size.width / 2 + self.waveOffSet) / 50.0));
    CGPoint realPoint = CGPointMake(imagePoint.x, viewSize.height - self.waveLayer.frame.size.height + imagePoint.y);
    if (self.block) {
        self.block(realPoint);
    }
    CGPathAddLineToPoint(frontWavePath, nil, viewSize.width, self.waveHeight);
    CGPathAddLineToPoint(backWavePath, nil, viewSize.width, self.waveHeight);
    CGPathCloseSubpath(frontWavePath);
    CGPathCloseSubpath(backWavePath);
    self.waveLayer.path = frontWavePath;
    self.backWaveLayer.path = backWavePath;
    CFRelease(backWavePath);
    CFRelease(frontWavePath);
}

- (void)startWaveAnimation {
    [self.timer invalidate];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWave)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)stopWaveAnimation {
    [self.timer invalidate];
}

- (CAShapeLayer *)waveLayer {
    if (!_waveLayer) {
        _waveLayer = [CAShapeLayer layer];
        CGRect frame = self.bounds;
        frame.origin.y = self.bounds.size.height - self.waveHeight ;
        frame.size.height = self.waveHeight;
        _waveLayer.frame = frame;
        [_waveLayer setStrokeColor:[UIColor whiteColor].CGColor];
        [_waveLayer setFillColor:[UIColor whiteColor].CGColor];
    }
    return _waveLayer;
}

- (CAShapeLayer *)backWaveLayer {
    if (!_backWaveLayer) {
        _backWaveLayer = [CAShapeLayer layer];
        CGRect frame = self.bounds;
        frame.origin.y = self.bounds.size.height - self.waveHeight ;
        frame.size.height = self.waveHeight;
        _backWaveLayer.frame = frame;
        [_backWaveLayer setFillColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4].CGColor];
    }
    return _backWaveLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
