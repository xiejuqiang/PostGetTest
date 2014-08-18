//
//  ViewController.m
//  PostGetTest
//
//  Created by apple on 14-8-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ViewController.h"
#import "JsonParser.h"
#import "NSData+Base64.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)postClick:(id)sender {
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://hht.medp.cn/dwmobile/index.php?m=User&a=dologin"];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET

//    NSString *str = @"type=focus-c";//设置参数
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
    NSString *str = @"PFJlcXVlc3RCb2R5PjxMaWNlbnNlSUQ+dDU0PC9MaWNlbnNlSUQ+PENQSUQ+MjRyNTMyPC9DUElEPjwvUmVxdWVzdEJvZHk+";
    NSMutableDictionary *dlist = [[NSMutableDictionary alloc] init];
    [dlist setObject:@"18350230344" forKey:@"username"];
    [dlist setObject:@"111111" forKey:@"password"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dlist options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:postData];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//    NSString *str1 = [received base64DecodeString];
    
    self.myTextView.text = str1 ;
    
    
}
- (IBAction)getClick:(id)sender {
    JsonParser *json = [[JsonParser alloc] init];
    NSString *url = @"http://medp.cn/app/index.php?m=Mmenu&a=index&app_id=538";
    [json parse:url withDelegate:self onComplete:@selector(connectionSuccess:) onErrorComplete:@selector(connectionError) onNullComplete:@selector(connectionNull)];
    
}

- (void)connectionSuccess:(JsonParser *)jsonP
{
    NSLog(@"%@",[jsonP getItems]);
    NSArray *array = [jsonP getItems];
    self.myTextView.text = array.description;
}

- (void)connectionError
{
    NSLog(@"Get Error");
}

- (void)connectionNull
{
    NSLog(@"Get Null");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
