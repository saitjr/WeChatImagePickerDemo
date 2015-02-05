//
//  PictureGestureView.m
//  图片手势
//
//  Created by zz on 15/1/12.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "PictureGestureView.h"

static BOOL isTap = NO;

@interface PictureGestureView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation PictureGestureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeAppearance];
    }
    return self;
}

- (void)initializeAppearance
{
    self.scrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.minimumZoomScale = 1;
        scrollView.maximumZoomScale = 2;
        scrollView.bouncesZoom = YES;
        scrollView.clipsToBounds = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView;
    });
    [self addSubview:self.scrollView];
    
    self.imageView = ({
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        imageView;
    });
    [self.scrollView addSubview:self.imageView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.numberOfTouchesRequired = 1;
    
    [self.imageView addGestureRecognizer:tapGesture];
    
    
    
    
}

- (void)respondsToTapGesture:(UITapGestureRecognizer *)gesture
{
    if (isTap) {
        [self.scrollView setZoomScale:1 animated:YES];
    } else {
        CGPoint point = [gesture locationInView:gesture.view];
        CGFloat width = CGRectGetWidth(gesture.view.bounds);
        CGFloat height = CGRectGetHeight(gesture.view.bounds);
        CGFloat newX = point.x - width / 4;
        CGFloat newY = point.y - height / 4;
        CGRect rect = CGRectMake(newX, newY, width / 2, height / 2);
        [self.scrollView zoomToRect:rect animated:YES];
    }
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that you want to zoom
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (scale == 1) {
        isTap = NO;
    } else {
        isTap = YES;
    }
}


@end
