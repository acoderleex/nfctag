//
//  ViewController.m
//  NFCDemo
//
//  Created by Tony on 2022/6/24.
//

#import "ViewController.h"
#import <CoreNFC/CoreNFC.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface ViewController ()<NFCNDEFReaderSessionDelegate>
@property (strong, nonatomic) NFCNDEFReaderSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)scanAction:(id)sender {
    
    [self.session invalidateSession];//关闭以前的Session
      self.session = [[NFCNDEFReaderSession alloc] initWithDelegate:self
                                                              queue:nil
                                           invalidateAfterFirstRead:NO];
      if (NFCNDEFReaderSession.readingAvailable) {
          self.session.alertMessage = @"把卡放到手机背面";
          [self.session beginSession];//启动 Session
      } else {
          NSLog(@"此设备不支持NFC");
      }

}


- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(watchos, macos, tvos){
    
    // 读取失败
       NSLog(@"%@",error);
       if (error.code == 201) {
           NSLog(@"扫描超时");
       }
       if (error.code == 200) {
           NSLog(@"取消扫描");
       }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(watchos, macos, tvos){
    
    for (NFCNDEFMessage *message in messages) {
           for (NFCNDEFPayload *record in message.records) {
               NSString *dataStr = [[NSString alloc] initWithData:record.payload
                                                         encoding:NSUTF8StringEncoding];
               NSLog(@"扫描结果 ：%@", dataStr);
               
               if ([dataStr isEqual:@"fenghuoxing.cn"]) {
                   
                   WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
                   launchMiniProgramReq.userName = @"gh_e3b81975fe3c";
                   launchMiniProgramReq.path = @"";
                   launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest;
                   [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
                     
                       NSLog(@"WeChatSDK: launchMiniProgramReq %@",success);
            
                   }];
               }
               
           }
       }
       
}
@end
