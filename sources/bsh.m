#import <Foundation/Foundation.h>

@interface ChromiaBourneShell : NSObject

- (void)runCommand:(NSString *)command;
- (void)startShell;
- (void)executeExternalCommand:(NSString *)command withArguments:(NSArray *)args;

@end

@implementation ChromiaBourneShell

- (void)runCommand:(NSString *)command {
    // Handle exit command
    if ([command isEqualToString:@"exit"]) {
        NSLog(@"Exiting the Chromia Bourne Shell...");
        exit(0);
    
    // Handle status command
    } else if ([command isEqualToString:@"status"]) {
        // Simulate checking the status of the Chromia runtime
        NSLog(@"Chromia Runtime is running.");
    
    // Handle deploy command
    } else if ([command hasPrefix:@"deploy"]) {
        NSArray *components = [command componentsSeparatedByString:@" "];
        if (components.count == 2) {
            NSString *contractName = components[1];
            NSLog(@"Deploying contract '%@' to Chromia...", contractName);
            // Here you can call actual Chromia deploy functionality
        } else {
            NSLog(@"Usage: deploy <contractName>");
        }
    
    // Handle run command
    } else if ([command hasPrefix:@"run"]) {
        NSArray *components = [command componentsSeparatedByString:@" "];
        if (components.count == 2) {
            NSString *scriptName = components[1];
            NSLog(@"Running script '%@' in Chromia...", scriptName);
            // Here you can call actual script running functionality
        } else {
            NSLog(@"Usage: run <scriptName>");
        }
    
    // Handle logs command
    } else if ([command isEqualToString:@"logs"]) {
        NSLog(@"Fetching Chromia logs...");
        // Simulate fetching logs
        NSLog(@"[LOGS] Chromia node is healthy, no issues found.");
    
    // External command or unknown command
    } else {
        [self executeExternalCommand:command withArguments:nil];
    }
}

- (void)executeExternalCommand:(NSString *)command withArguments:(NSArray *)args {
    // Handle execution of external commands (like invoking Chromia CLI or other system commands)
    
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/bin/sh"; // Use bash to execute commands (can be customized based on environment)
    task.arguments = [@[command] arrayByAddingObjectsFromArray:args];
    
    // Create a pipe to capture output
    NSPipe *pipe = [NSPipe pipe];
    task.standardOutput = pipe;
    
    // Launch the task and wait for completion
    [task launch];
    [task waitUntilExit];
    
    // Capture the output
    NSData *data = [pipe fileHandleForReading].availableData;
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (output.length > 0) {
        NSLog(@"%@", output);
    } else {
        NSLog(@"No output or command execution failed.");
    }
}

- (void)startShell {
    char input[256];
    NSLog(@"Welcome to the Chromia Re-Bourne Shell (bsh)!");
    NSLog(@"Type 'exit' to quit.");
    
    while (1) {
        NSLog(@"\n$ ");
        fgets(input, sizeof(input), stdin);  // Read user input
        NSString *command = [NSString stringWithUTF8String:input];
        
        // Remove the newline character at the end of the input
        command = [command stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        if (command.length > 0) {
            [self runCommand:command];
        }
    }
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ChromiaBourneShell *shell = [[ChromiaBourneShell alloc] init];
        [shell startShell];
    }
    return 0;
}

