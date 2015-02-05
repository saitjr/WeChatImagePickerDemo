//
//  BrowseImagesViewController.h
//  2015-02-04-WeChatImagePickerDemo
//
//  Created by TangJR on 15/2/5.
//  Copyright (c) 2015年 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseImagesViewController : UIViewController

@property (copy, nonatomic) void(^deleteBlock)(NSInteger index);

- (instancetype)initWithIndex:(NSInteger)index selectImages:(NSMutableArray *)selectImages;

@end