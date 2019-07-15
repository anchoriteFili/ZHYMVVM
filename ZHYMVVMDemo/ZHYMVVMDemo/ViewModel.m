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
        
        // 对 changeName属性进行监控
        [self addObserver:self forKeyPath:@"changeName" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

// 加载数据
- (void)loadData {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 时间延迟，模拟后台请求数据
        [NSThread sleepForTimeInterval:0.5];
        Model *model = [Model new];
        model.names = [NSMutableArray arrayWithObjects:@"张三",@"李四",@"王五",@"三丰", nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.vmBlock(model);
        });
    });

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    Model *model = [Model new];
    model.names = [NSMutableArray arrayWithObjects:@"张三",@"李四",@"王五",@"三丰", nil];
    
    NSString *name = change[NSKeyValueChangeNewKey];
    [model.names removeObject:name];
    self.vmBlock(model);    
}


- (void)dealloc {
    [self removeObserver:self forKeyPath:@"changeName"];
}

@end
