//
//  ViewModel.m
//  ZHYMVVMDemo
//
//  Created by 赵宏亚 on 2019/7/15.
//  Copyright © 2019 赵宏亚. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

- (instancetype)initWithBlock:(ViewModelBlock)block {
    
    if (self == [super init]) {
        _vmBlock = block;
    }
    return self;
}

// 加载数据
- (void)loadData {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 时间延迟，模拟后台请求数据
        [NSThread sleepForTimeInterval:0.5];
        Model *model = [Model new];
        model.name = @"张三";
        dispatch_async(dispatch_get_main_queue(), ^{
            self.vmBlock(model);
        });
    });

    
}

@end
