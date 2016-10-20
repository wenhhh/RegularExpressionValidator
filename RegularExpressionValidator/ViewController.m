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
    
    NSArray *matchArray = [NSArray array];
    NSMutableArray *resultArr = [NSMutableArray array];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expressionString options:NSRegularExpressionCaseInsensitive error:&error];
    matchArray = [regex matchesInString:sourceString options:(NSMatchingReportProgress) range:NSMakeRange(0, sourceString.length)];
    NSUInteger lastIdx = 0;
    for (NSTextCheckingResult *result in matchArray) {
        NSRange currentRange = result.range;
        if (currentRange.location >= lastIdx) {
            NSString *tempStr = [sourceString substringWithRange:currentRange];
            [resultArr addObject:tempStr];
        }
        lastIdx = currentRange.location + currentRange.length;
    }
    
    if (resultArr.count <= 0) {
        [self insertTextToResult:@"(No match!)"];
    }
    else {
        __block NSMutableString *resultMutableText=[NSMutableString string];
        [resultArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [resultMutableText appendFormat:@"%@\n",obj];
        }];
        [self insertTextToResult:resultMutableText];
    }
}

- (void)insertTextToResult:(NSString *)text {
    [self.resultTextView insertText:@"" replacementRange:NSMakeRange(0, self.resultTextView.string.length)];
    self.resultTextView.string = text;
}
@end
