#import <Foundation/Foundation.h>

@interface ChromiaTask : NSObject

@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, assign) NSInteger priority;  // Higher value means higher priority
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, strong) NSTimer *taskTimer;  // Timer to simulate task execution

- (instancetype)initWithName:(NSString *)name priority:(NSInteger)priority;
- (void)startTask;
- (void)interruptTask;

@end

@implementation ChromiaTask

- (instancetype)initWithName:(NSString *)name priority:(NSInteger)priority {
    if (self = [super init]) {
        _taskName = name;
        _priority = priority;
        _isRunning = NO;
    }
    return self;
}

- (void)startTask {
    if (self.isRunning) {
        NSLog(@"Task '%@' is already running.", self.taskName);
        return;
    }
    
    self.isRunning = YES;
    NSLog(@"Starting task: %@", self.taskName);
    
    // Simulate task execution with a timer (for demonstration)
    self.taskTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                     target:self
                                                   selector:@selector(completeTask)
                                                   userInfo:nil
                                                    repeats:NO];
}

- (void)interruptTask {
    if (self.isRunning) {
        NSLog(@"Interrupting task: %@", self.taskName);
        [self.taskTimer invalidate];
        self.isRunning = NO;
    }
}

- (void)completeTask {
    NSLog(@"Task '%@' completed.", self.taskName);
    self.isRunning = NO;
}

@end

@interface ChromiaSystem : NSObject

@property (nonatomic, strong) NSMutableArray<ChromiaTask *> *taskQueue; // Queue of tasks
@property (nonatomic, strong) NSOperationQueue *taskScheduler;          // Scheduler for tasks

- (void)startSystem;
- (void)addTask:(ChromiaTask *)task;
- (void)interruptTaskWithName:(NSString *)taskName;
- (void)runTaskScheduler;

@end

@implementation ChromiaSystem

- (instancetype)init {
    if (self = [super init]) {
        _taskQueue = [NSMutableArray array];
        _taskScheduler = [[NSOperationQueue alloc] init];
        _taskScheduler.maxConcurrentOperationCount = 1;  // Serial scheduling
    }
    return self;
}

- (void)startSystem {
    // Start the system and begin task scheduling
    NSLog(@"Starting Chromia System...");
    
    // Run the task scheduler to manage tasks
    [self runTaskScheduler];
}

- (void)addTask:(ChromiaTask *)task {
    // Add tasks to the queue based on priority (simulated)
    [self.taskQueue addObject:task];
    
    // Sort by priority (descending order)
    [self.taskQueue sortUsingComparator:^NSComparisonResult(ChromiaTask *task1, ChromiaTask *task2) {
        return task2.priority - task1.priority;  // Higher priority comes first
    }];
}

- (void)interruptTaskWithName:(NSString *)taskName {
    // Find and interrupt the task by name
    for (ChromiaTask *task in self.taskQueue) {
        if ([task.taskName isEqualToString:taskName] && task.isRunning) {
            [task interruptTask];
            break;
        }
    }
}

- (void)runTaskScheduler {
    // Continuously run the tasks based on priority
    for (ChromiaTask *task in self.taskQueue) {
        if (!task.isRunning) {
            [task startTask];
            // Simulate a micro-interruption by starting tasks in order
            [NSThread sleepForTimeInterval:1];  // Simulate time for interruption management
        }
    }
}

@end

@interface ChromiaMigGNU : NSObject

- (void)startMigGNU;

@end

@implementation ChromiaMigGNU

- (void)startMigGNU {
    // Create the Chromia System instance
    ChromiaSystem *chromiaSystem = [[ChromiaSystem alloc] init];
    
    // Simulate adding tasks with priorities
    ChromiaTask *task1 = [[ChromiaTask alloc] initWithName:@"Task1" priority:5];
    ChromiaTask *task2 = [[ChromiaTask alloc] initWithName:@"Task2" priority:10];
    ChromiaTask *task3 = [[ChromiaTask alloc] initWithName:@"Task3" priority:8];
    
    [chromiaSystem addTask:task1];
    [chromiaSystem addTask:task2];
    [chromiaSystem addTask:task3];
    
    // Start the Chromia system
    [chromiaSystem startSystem];
    
    // Simulate task interruptions
    [NSThread sleepForTimeInterval:3];
    [chromiaSystem interruptTaskWithName:@"Task2"];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ChromiaMigGNU *migGNU = [[ChromiaMigGNU alloc] init];
        [migGNU startMigGNU];
    }
    return 0;
}

