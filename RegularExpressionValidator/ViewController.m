//
//  ViewController.m
//  RegularExpressionValidator
//
//  Created by zer0 on 2016/10/20.
//  Copyright © 2016年 zer0. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *sourceTextView;
@property (unsafe_unretained) IBOutlet NSTextView *expressionTextView;
@property (unsafe_unretained) IBOutlet NSTextView *resultTextView;
- (IBAction)matchButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)matchButton:(id)sender {
    NSString *sourceString = self.sourceTextView.string;
    NSString *expressionString = self.expressionTextView.string;
    NSRange matchRange = [sourceString rangeOfString:expressionString options:NSRegularExpressionSearch];
    if (NSNotFound != matchRange.location) {
        NSString *resultString = [sourceString substringWithRange:matchRange];
        if (resultString) {
            self.resultTextView.string = resultString;
        }
        else {
            self.resultTextView.string = @"(没有匹配)";
        }
    }
    else {
        self.resultTextView.string = @"(没有匹配)";
    }
}
@end
