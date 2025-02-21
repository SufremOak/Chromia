#import <Foundation/Foundation.h>
#import <iostream>
#import <map>
#import <functional>
#import <cstdlib>

@interface ChromiaShell : NSObject
- (void)startShell;
@end

@implementation ChromiaShell {
    std::map<std::string, std::function<void()>> commands;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerCommands];
    }
    return self;
}

- (void)registerCommands {
    commands["exit"] = [this]() { exit(0); };
    commands["help"] = [this]() { [self printHelp]; };
    commands["edit"] = [this]() { system("nano"); };
    commands["openproject"] = [this]() { system("cd $(projctName)"); };
}

- (void)printHelp {
    std::cout << "Available commands:" << std::endl;
    for (const auto& command : commands) {
        std::cout << " - " << command.first << std::endl;
    }
}

- (void)startShell {
    std::string input;
    while (true) {
        std::cout << "Chromia> ";
        std::getline(std::cin, input);
        auto it = commands.find(input);
        if (it != commands.end()) {
            it->second();
        } else {
            std::cout << "Unknown command: " << input << std::endl;
        }
    }
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ChromiaShell *shell = [[ChromiaShell alloc] init];
        [shell startShell];
    }
    return 0;
}