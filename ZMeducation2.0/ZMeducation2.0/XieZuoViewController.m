//
//  XieZuoViewController.m
//  ZMeducation2.0
//
//  Created by Queen on 2017/6/13.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "XieZuoViewController.h"
#import "CustomLine.h"
#import <iflyMSC/iflyMSC.h>
@interface XieZuoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UINavigationControllerDelegate,IFlySpeechRecognizerDelegate>

@property (nonatomic, strong)UIButton *btn1;

@property (nonatomic, strong)UIButton *btn2;

@property (nonatomic, strong)UIButton *btn3;

@property (nonatomic, strong)UIView *gousiBackView;

@property (nonatomic, strong)UIView *wendangBackView;

@property (nonatomic, strong)UIView *ketangBackView;

@property (nonatomic, strong)UIScrollView *gousiScro;
@property (nonatomic, strong)NSMutableDictionary *userInfo;

@property (nonatomic,strong) NSMutableArray *M2009Arr;

@property (nonatomic, weak) UIScrollView *scro;

@property (nonatomic, strong) NSMutableDictionary *M301Dic;

@property (nonatomic, strong) NSMutableArray *tempM301Arr;

@property (nonatomic, strong) NSMutableDictionary *M2067Dic;
@property (nonatomic, strong) NSMutableDictionary *M2064Dic;

@property (nonatomic, weak) UITextField *tf;

@property (nonatomic, strong) UITableView *tabv;

@property (nonatomic, strong) UIScrollView *wendangscro;

@property (nonatomic, strong) NSMutableArray *M2064Arr;
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;

@property (nonatomic, strong) UIButton *luyinBtn;

@property (nonatomic, weak)UITextView *content;

@property (nonatomic, strong)NSMutableArray *tempM2061Arr;

@property (nonatomic, strong) NSMutableDictionary *m2009Dic;

@end

@implementation XieZuoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建语音识别对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance]; //设置识别参数
    _iFlySpeechRecognizer.delegate = self;
    //设置为听写模式
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];

    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path 是录音文件名，设置 value 为 nil 或者为空取消保存，默认保存目录在 Library/cache 下。
    [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];

    
    self.userInfo = [DEF_UserDefaults objectForKey:SAVE_USERINFO];

    self.M2009Arr = [[NSMutableArray alloc]init];
    
    self.tempM301Arr = [[NSMutableArray alloc]init];
    
    UIImageView *imagvBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 95)];
    imagvBg.image = DEF_IMAGENAME(@"xiezuo_bg");
    imagvBg.userInteractionEnabled = YES;
    [self.view addSubview:imagvBg];
    
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(40, 23, DEF_DEVICE_WIDTH - 80, 30)];
    [self.view addSubview:scro];
    self.scro = scro;
    
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(335, 23, 115, 30)];
//    btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
//    btn1.layer.cornerRadius = 15;
//    btn1.layer.borderWidth = 2;
//    btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
//    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn1 setTitle:@"我的构思" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(action1) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn1];
//    self.btn1 = btn1;
//    
//    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.right + 5, 23, 115, 30)];
//    btn2.backgroundColor = [UIColor clearColor];
//    btn2.layer.cornerRadius = 15;
//    btn2.layer.borderWidth = 2;
//    btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn2 setTitle:@"我的文档" forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(action2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
//    self.btn2 = btn2;
//    
//    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btn2.right + 5, 23, 115, 30)];
//    btn3.backgroundColor = [UIColor clearColor];
//    btn3.layer.cornerRadius = 15;
//    btn3.layer.borderWidth = 2;
//    btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
//    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn3 setTitle:@"我的课堂" forState:UIControlStateNormal];
//    [btn3 addTarget:self action:@selector(action3) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn3];
//    self.btn3 = btn3;
    
    self.gousiBackView = [[UIView alloc]initWithFrame:CGRectMake(0, scro.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - scro.bottom)];
    self.gousiBackView.hidden = YES;
    [self.view addSubview:self.gousiBackView];
    
    self.wendangBackView = [[UIView alloc]initWithFrame:CGRectMake(0, scro.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - scro.bottom)];
    self.wendangBackView.hidden = YES;
    [self.view addSubview:self.wendangBackView];
    
    self.ketangBackView = [[UIView alloc]initWithFrame:CGRectMake(0, scro.bottom, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - scro.bottom)];
    self.ketangBackView.hidden = YES;
    [self.view addSubview:self.ketangBackView];
    
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2009",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"typeId"           :@"2",
                            @"sign"             :[CACUtility getSignWithMethod:@"M2009"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        for (NSMutableDictionary *dic in result[@"modules"]) {
            for (NSMutableDictionary *dic1 in dic[@"units"]) {
                [self.M2009Arr addObject:dic1];
            }
        }
        
        int x = 0;
        for (int i = 0; i< self.M2009Arr.count; i++) {
            NSMutableDictionary *dic = self.M2009Arr[i];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, 115, 30)];
            btn.layer.cornerRadius = 15;
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
            [btn setTitle:dic[@"unitName"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            btn.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = -100 + i;
            [self.scro addSubview:btn];
            
            x += 120;
            
            self.scro.contentSize = CGSizeMake(x, 30);
        }
    } failture:^(id result) {
        
    }];
    
    
}
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [self stringFromJson:resultString];

    self.content.text = [NSString stringWithFormat:@"%@%@",self.content.text,resultFromJson];
    NSLog(@"jjjjjjj======%@",resultFromJson);
    
} //识别会话结束返回代理
- (void)onError: (IFlySpeechError *) error{
    
}
//停止录音回调
- (void) onEndOfSpeech{
    [self.luyinBtn setTitle:@"开始录音" forState:0];
    self.luyinBtn.enabled = YES;
}
//开始录音回调
- (void) onBeginOfSpeech{
    
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{
    
}
//会话取消回调
- (void) onCancel{
    
}
-(void)action:(UIButton *)sender
{
    for (UIView *view in [self.scro subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.backgroundColor = [UIColor clearColor];
            btn.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    sender.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    sender.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    int tag = (int)sender.tag + 100;
    self.m2009Dic = self.M2009Arr[tag];
    if([self.M2009Arr[tag][@"unitName"] rangeOfString:@"构思"].location !=NSNotFound)//_roaldSearchText
    {
        
        self.gousiBackView.hidden = NO;
        self.wendangBackView.hidden = YES;
        self.ketangBackView.hidden = YES;
        [self loadGousi];
        return;
    }
    if ([self.M2009Arr[tag][@"unitName"] isEqualToString:@"我的构思"]) {
        self.gousiBackView.hidden = NO;
        self.wendangBackView.hidden = YES;
        self.ketangBackView.hidden = YES;
        [self loadGousi];
    }else if ([self.M2009Arr[tag][@"unitName"] rangeOfString:@"文稿"].location !=NSNotFound) {
        self.gousiBackView.hidden = YES;
        self.wendangBackView.hidden = NO;
        self.ketangBackView.hidden = YES;
        [self wodewendang];
    }else{
        self.gousiBackView.hidden = YES;
        self.wendangBackView.hidden = YES;
        self.ketangBackView.hidden = NO;
        [self wodeketang];
    }

}

-(void)wodewendang
{
    for (UIView *view in [self.wendangBackView subviews]) {
        [view removeFromSuperview];
    }
    
    UIImageView *imagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 200, 60)];
    imagv1.image = DEF_IMAGE(@"wodewengao_title");
    [self.wendangBackView addSubview:imagv1];
    
    UIImageView *imagv2 = [[UIImageView alloc]initWithFrame:CGRectMake(imagv1.right + 15, imagv1.y + 10, 650, 35)];
    imagv2.image = DEF_IMAGE(@"wodewengao_shurukuang");
    imagv2.userInteractionEnabled = YES;
    [self.wendangBackView addSubview:imagv2];
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, imagv2.width - 40, 35)];
    tf.placeholder = @"    (请在这里输入标题)";
    [imagv2 addSubview:tf];
    self.tf = tf;
    
    self.luyinBtn = [[UIButton alloc]initWithFrame:CGRectMake(imagv2.right + 20, imagv2.y, 80, 35)];
    [self.luyinBtn setTitle:@"开始录音" forState:0];
    [self.luyinBtn addTarget:self action:@selector(luyin) forControlEvents:UIControlEventTouchUpInside];
    [self.wendangBackView addSubview:self.luyinBtn];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(40, 90, self.ketangBackView.width - 80, 450)];
    imagv.userInteractionEnabled = YES;
    imagv.image = DEF_IMAGE(@"hezuo_beijing");
    imagv.userInteractionEnabled = YES;
    [self.wendangBackView addSubview:imagv];

    UITextView *content = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, imagv.width - 20, 300)];
    content.font = DEF_MyFont(16);

    [imagv addSubview:content];
    self.content = content;
    
    UIButton *tijiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, imagv.bottom + 10, 180, 30)];
    tijiaoBtn.centerX = self.wendangBackView.centerX;
    [tijiaoBtn setImage:DEF_IMAGE(@"tiankongti_tijiao") forState:UIControlStateNormal];
    [tijiaoBtn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.wendangBackView addSubview:tijiaoBtn];
    
    self.wendangscro = [[UIScrollView alloc]initWithFrame:CGRectMake(10, imagv.bottom - 220, imagv.width - 20,100)];
    [imagv addSubview:self.wendangscro];
    
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2064",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2064"],
                            @"unitId"                 :self.m2009Dic[@"unitId"],
                            @"unitTypeId"                 :self.m2009Dic[@"unitTypeId"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2064Dic = result;
        
        self.M2064Arr = [[NSMutableArray alloc]initWithArray:result[@"files"]];
        
        [self.M2064Arr addObject:@""];
        
        content.text = result[@"content"];
        [self LoadwendangImgv];
        
    } failture:^(id result) {
        
    }];
}

-(void)luyin
{
    BOOL ret = [_iFlySpeechRecognizer startListening];
    if (ret) {
        [self.luyinBtn setTitle:@"正在录音" forState:0];
        self.luyinBtn.enabled = NO;
    }else{
        
        
    }
}

-(void)tijiao
{
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2065",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2065"],
                            @"title"            :self.tf.text,
                            @"content"          :self.content.text};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"提交成功"];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            if (result[@"responseMessage"] != nil) {
                [CACUtility showTips:result[@"responseMessage"]];
            }
        }else{
            [CACUtility showTips:@"提交失败"];
        }

    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];

    }];

}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag ==255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        __weak typeof(self) weakSelf = self;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }];
        
    }
}

- (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //返回的格式必须为utf8的,否则发生未知错误
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    NSData *fileData = UIImageJPEGRepresentation(image, 0.05);
    
    [self dismissViewControllerAnimated:YES completion:nil];

    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2066",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2066"],
                            @"file"             :fileData,
                            @"filename"         :@"123.png",
                            @"unitId"                 :self.m2009Dic[@"unitId"],
                            @"unitTypeId"                 :self.m2009Dic[@"unitTypeId"]};
    [RequestOperationManager getParametersDic1:dic4 success:^(NSMutableDictionary *result) {
        
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"图片上传成功"];
            [self wodewendang];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            if (result[@"responseMessage"] != nil) {
                [CACUtility showTips:result[@"responseMessage"]];
            }
        }else{
            [CACUtility showTips:@"图片上传失败"];
        }
        
    } failture:^(id result) {
        [CACUtility showTips:@"图片上传失败"];
        
    }];

}

-(void)tianjia
{
    UIActionSheet *sheet;
    // 判断是否支持相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择"delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消"otherButtonTitles:@"拍照",@"从相册选择",nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择"delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消"otherButtonTitles:@"从相册选择",nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
}

-(void)LoadwendangImgv
{
    for (UIView *view in [self.wendangscro subviews]) {
        [view removeFromSuperview];
    }
    
    int x = 0;
    for (int i = 0; i < self.M2064Arr.count; i++) {
        if (i < self.M2064Arr.count - 1) {
            UIImageView *imav = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, 60, 100)];
            [imav sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",DEF_IPA,self.M2064Arr[i][@"fileUrl"]]]];
            [self.wendangscro addSubview:imav];
        }
        
        if (i == self.M2064Arr.count - 1) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, 60, 100)];
            [btn setTitle:@"添加" forState:0];
            [btn addTarget:self action:@selector(tianjia) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor grayColor];
            [self.wendangscro addSubview:btn];
        }
        x += 80;

        self.wendangscro.contentSize = CGSizeMake(self.M2064Arr.count * 80, 100);
    }
}

-(void)wodeketang
{
    for (UIView *view in [self.ketangBackView subviews]) {
        [view removeFromSuperview];
    }
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(40, 20, self.ketangBackView.width - 80, 550)];
    imagv.userInteractionEnabled = YES;
    imagv.image = DEF_IMAGE(@"hezuo_beijing");
    [self.ketangBackView addSubview:imagv];
    
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2067",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2067"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        
        self.M2067Dic = result;
        
    } failture:^(id result) {
        
    }];
}

//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    int tag = (int)textView.tag;
//   
//    NSLog(@"tag=========%d",tag);
//    if (tag == 100000) {
//        
//        NSMutableDictionary *dic = (NSMutableDictionary *)self.M301Dic[@"list"][0];
//
//        
//        for (int i = 0; i < self.tempM301Arr.count ; i++) {
//            NSMutableDictionary *dicv = self.tempM301Arr[i];
//            if ([dicv[@"id"] isEqualToString:dic[@"id"]]) {
//                [self.tempM301Arr removeObjectAtIndex:i];
//            }
//        }
//        NSMutableDictionary *dddd = [[NSMutableDictionary alloc]init];
//        [dddd setObject:dic[@"id"] forKey:@"id"];
//        [dddd setObject:textView.text forKey:@"content"];
//        [self.tempM301Arr addObject:dddd];
//        
//    }else if (tag < 100000 && tag >= 10000){
//        int i = tag - 10000;
//        
//        NSMutableArray *arr2 = self.M301Dic[@"list"][0][@"list"];
//        NSMutableDictionary *dic = arr2[i];
//        
//        for (int i = 0; i < self.tempM301Arr.count ; i++) {
//            NSMutableDictionary *dicv = self.tempM301Arr[i];
//            if ([dicv[@"id"] isEqualToString:dic[@"id"]]) {
//                [self.tempM301Arr removeObjectAtIndex:i];
//            }
//        }
//        NSMutableDictionary *dddd = [[NSMutableDictionary alloc]init];
//        [dddd setObject:dic[@"id"] forKey:@"id"];
//        [dddd setObject:textView.text forKey:@"content"];
//        [self.tempM301Arr addObject:dddd];
//
//    }else if (tag < 10000 && tag >= 1000){
//    
//    }
//    
//    NSLog(@"nnnnnnnnnnnnnnn%@",self.tempM301Arr);
//    
//}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 2001) {
        NSMutableDictionary *dic = self.tempM2061Arr[0];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2002){
        NSMutableDictionary *dic = self.tempM2061Arr[1];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2003){
        NSMutableDictionary *dic = self.tempM2061Arr[2];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2004){
        NSMutableDictionary *dic = self.tempM2061Arr[3];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2005){
        NSMutableDictionary *dic = self.tempM2061Arr[4];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2006){
        NSMutableDictionary *dic = self.tempM2061Arr[5];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2007){
        NSMutableDictionary *dic = self.tempM2061Arr[6];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2008){
        NSMutableDictionary *dic = self.tempM2061Arr[7];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2009){
        NSMutableDictionary *dic = self.tempM2061Arr[8];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2010){
        NSMutableDictionary *dic = self.tempM2061Arr[9];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2011){
        NSMutableDictionary *dic = self.tempM2061Arr[10];
        [dic setObject:textView.text forKey:@"advice"];
    }else if (textView.tag == 2012){
        NSMutableDictionary *dic = self.tempM2061Arr[11];
        [dic setObject:textView.text forKey:@"advice"];
    }
    
    NSLog(@"hahahahahahaha%@",self.tempM2061Arr);
}


+ (NSString *)arrayToJSONString:(NSArray *)array
{
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return jsonString;
}

+ (NSString *)dictionaryToJSONString:(NSArray *)dictionary
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonString;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

-(void)gousicommit
{
    
    NSString *str = [XieZuoViewController arrayToJSONString:self.tempM2061Arr];
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2062",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2062"],
                            @"unitTypeId"       :self.m2009Dic[@"unitTypeId"],
                            @"unitId"           :self.m2009Dic[@"unitId"],
                            @"content"          :str};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {
        if ([result[@"responseCode"] isEqualToString:@"00"]) {
            [CACUtility showTips:@"提交成功"];
        }else if ([result[@"responseCode"] isEqualToString:@"96"]){
            if (result[@"responseMessage"] != nil) {
                [CACUtility showTips:result[@"responseMessage"]];
            }
        }else{
            [CACUtility showTips:@"提交失败"];
        }

    } failture:^(id result) {
        [CACUtility showTips:@"提交失败"];
    }];
}

-(void)loadGousi
{
    for (UIView *view in [self.gousiBackView subviews]) {
        [view removeFromSuperview];
    }
    
    NSDictionary * dic4 = @{@"version"          :@"2.0.0",
                            @"clientType"       :@"1001",
                            @"signType"         :@"md5",
                            @"timestamp"        :[CACUtility getNowTime],
                            @"method"           :@"M2061",
                            @"userId"           :self.userInfo[@"userId"],
                            @"gradeId"          :self.userInfo[@"gradeId"],
                            @"classId"          :self.userInfo[@"classId"],
                            @"courseId"         :self.userInfo[@"courseId"],
                            @"sign"             :[CACUtility getSignWithMethod:@"M2061"],
                            @"unitTypeId"       :self.m2009Dic[@"unitTypeId"],
                            @"unitId"           :self.m2009Dic[@"unitId"]};
    [RequestOperationManager getParametersDic:dic4 success:^(NSMutableDictionary *result) {

        NSString *str = result[@"unitTypeId"];
        if ([str intValue] == 62) {
            
            self.tempM2061Arr = [[NSMutableArray alloc]init];
            if (result[@"content"] == nil || [result[@"content"] isEqualToString:@""]) {
                self.tempM2061Arr = [[NSMutableArray alloc]init];
                for (int i = 0; i < 11; i++) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    [dic setObject:@"" forKey:@"advice"];
                    [self.tempM2061Arr addObject:dic];
                }
            }else{
                
                NSData *jsonData = [result[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:nil];
                self.tempM2061Arr = [[NSMutableArray alloc]initWithArray:arr];
            }

            UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.gousiBackView.width, self.gousiBackView.height - 100)];
            imagv.image = DEF_IMAGE(@"article_1");
            imagv.userInteractionEnabled = YES;
            imagv.contentMode = UIViewContentModeScaleAspectFit;
            [self.gousiBackView addSubview:imagv];
            
            UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(120, 50, 190, 50)];
            tv1.text = self.tempM2061Arr[0][@"advice"];
            tv1.tag = 2001;
            tv1.delegate = self;
            tv1.font = DEF_MyFont(16);
            [imagv addSubview:tv1];
            
            UITextView *tv2 = [[UITextView alloc]initWithFrame:CGRectMake(120, tv1.bottom + 30, 190, 450)];
            tv2.text = self.tempM2061Arr[1][@"advice"];
            tv2.tag = 2002;
            tv2.delegate = self;
            tv2.font = DEF_MyFont(16);

            [imagv addSubview:tv2];
            
            UITextView *tv3 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv1.y + 20, 190, 50)];
            tv3.text = self.tempM2061Arr[2][@"advice"];
            tv3.tag = 2003;
            tv3.delegate = self;
            tv3.font = DEF_MyFont(16);

            [imagv addSubview:tv3];
            
            UITextView *tv4 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv3.bottom + 40, 190, 50)];
            tv4.text = self.tempM2061Arr[3][@"advice"];
            tv4.tag = 2004;
            tv4.delegate = self;
            tv4.font = DEF_MyFont(16);

            [imagv addSubview:tv4];
            
            UITextView *tv5 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv4.bottom + 40, 190, 50)];
            tv5.text = self.tempM2061Arr[4][@"advice"];
            tv5.tag = 2005;
            tv5.delegate = self;
            tv5.font = DEF_MyFont(16);

            [imagv addSubview:tv5];
            
            UITextView *tv6 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv5.bottom + 45, 190, 50)];
            tv6.text = self.tempM2061Arr[5][@"advice"];
            tv6.tag = 2006;
            tv6.delegate = self;
            tv6.font = DEF_MyFont(16);

            [imagv addSubview:tv6];
            
            UITextView *tv7 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv6.bottom + 45, 190, 50)];
            tv7.text = self.tempM2061Arr[6][@"advice"];
            tv7.tag = 2007;
            tv7.delegate = self;
            tv7.font = DEF_MyFont(16);

            [imagv addSubview:tv7];
            
            UITextView *tv8 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 100, tv7.bottom + 45, 190, 50)];
            tv8.text = self.tempM2061Arr[7][@"advice"];
            tv8.tag = 2008;
            tv8.delegate = self;
            tv8.font = DEF_MyFont(16);

            [imagv addSubview:tv8];
            
            UITextView *tv9 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 130, tv1.y + 20, 160, 110)];
            tv9.text = self.tempM2061Arr[8][@"advice"];
            tv9.tag = 2009;
            tv9.delegate = self;
            tv9.font = DEF_MyFont(16);

            [imagv addSubview:tv9];
            
            UITextView *tv10 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 130, tv9.bottom + 60, 160, 110)];
            tv10.text = self.tempM2061Arr[9][@"advice"];
            tv10.tag = 2010;
            tv10.delegate = self;
            tv10.font = DEF_MyFont(16);

            [imagv addSubview:tv10];
            
            UITextView *tv11 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 130, tv10.bottom + 60, 160, 110)];
            tv11.text = self.tempM2061Arr[10][@"advice"];
            tv11.tag = 2011;
            tv11.delegate = self;
            tv11.font = DEF_MyFont(16);

            [imagv addSubview:tv11];
            
            UIButton *commit = [[UIButton alloc]initWithFrame:CGRectMake(tv11.right - 80, tv11.bottom + 20, 80, 80)];
            [commit addTarget:self action:@selector(gousicommit) forControlEvents:UIControlEventTouchUpInside];
            [imagv addSubview:commit];
            
            
        }else if ([str intValue] == 63) {
            self.tempM2061Arr = [[NSMutableArray alloc]init];
            if (result[@"content"] == nil || [result[@"content"] isEqualToString:@""]) {
                self.tempM2061Arr = [[NSMutableArray alloc]init];
                for (int i = 0; i < 12; i++) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    [dic setObject:@"" forKey:@"advice"];
                    [self.tempM2061Arr addObject:dic];
                }
            }else{
                NSData *jsonData = [result[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:nil];
                self.tempM2061Arr = [[NSMutableArray alloc]initWithArray:arr];
            }

            UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.gousiBackView.width, self.gousiBackView.height - 100)];
            imagv.image = DEF_IMAGE(@"article_2");
            imagv.userInteractionEnabled = YES;
            imagv.userInteractionEnabled = YES;
            imagv.contentMode = UIViewContentModeScaleAspectFit;
            [self.gousiBackView addSubview:imagv];

            UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(120, 50, 190, 50)];
            tv1.text = self.tempM2061Arr[0][@"advice"];
            tv1.tag = 2001;
            tv1.delegate = self;
            tv1.font = DEF_MyFont(16);

            [imagv addSubview:tv1];
            
            UITextView *tv2 = [[UITextView alloc]initWithFrame:CGRectMake(120, tv1.bottom + 30, 190, 450)];
            tv2.text = self.tempM2061Arr[1][@"advice"];
            tv2.tag = 2002;
            tv2.delegate = self;
            tv2.font = DEF_MyFont(16);

            [imagv addSubview:tv2];

            UITextView *tv4 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 70, tv1.y + 10, 220, 70)];
            tv4.text = self.tempM2061Arr[2][@"advice"];
            tv4.tag = 2003;
            tv4.delegate = self;
            tv4.font = DEF_MyFont(16);

            [imagv addSubview:tv4];
            
            UITextView *tv5 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 40, tv4.bottom + 50, 120, 90)];
            tv5.text = self.tempM2061Arr[3][@"advice"];
            tv5.tag = 2004;
            tv5.delegate = self;
            tv5.font = DEF_MyFont(16);

            [imagv addSubview:tv5];
            
            UITextView *tv6 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 40, tv5.bottom + 60, 120, 90)];
            tv6.text = self.tempM2061Arr[4][@"advice"];
            tv6.tag = 2005;
            tv6.delegate = self;
            tv6.font = DEF_MyFont(16);

            [imagv addSubview:tv6];
            
            UITextView *tv7 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 40, tv6.bottom + 60, 120, 90)];
            tv7.text = self.tempM2061Arr[5][@"advice"];
            tv7.tag = 2006;
            tv7.delegate = self;
            tv7.font = DEF_MyFont(16);

            [imagv addSubview:tv7];
            
            UITextView *tv8 = [[UITextView alloc]initWithFrame:CGRectMake(tv7.right + 65, tv4.bottom + 50, 120, 90)];
            tv8.text = self.tempM2061Arr[6][@"advice"];
            tv8.tag = 2007;
            tv8.delegate = self;
            tv8.font = DEF_MyFont(16);

            [imagv addSubview:tv8];
            
            UITextView *tv9 = [[UITextView alloc]initWithFrame:CGRectMake(tv7.right + 65, tv8.bottom + 70, 120, 90)];
            tv9.text = self.tempM2061Arr[7][@"advice"];
            tv9.tag = 2008;
            tv9.delegate = self;
            tv9.font = DEF_MyFont(16);

            [imagv addSubview:tv9];
            
            UITextView *tv10 = [[UITextView alloc]initWithFrame:CGRectMake(tv7.right + 65, tv9.bottom + 70, 120, 90)];
            tv10.text = self.tempM2061Arr[8][@"advice"];
            tv10.tag = 2009;
            tv10.delegate = self;
            tv10.font = DEF_MyFont(16);

            [imagv addSubview:tv10];
            
            UITextView *tv11 = [[UITextView alloc]initWithFrame:CGRectMake(tv4.right + 140, tv1.y + 20, 150, 110)];
            tv11.text = self.tempM2061Arr[9][@"advice"];
            tv11.tag = 2010;
            tv11.delegate = self;
            tv11.font = DEF_MyFont(16);

            [imagv addSubview:tv11];
            
            UITextView *tv12 = [[UITextView alloc]initWithFrame:CGRectMake(tv4.right + 140, tv11.bottom + 60, 150, 110)];
            tv12.text = self.tempM2061Arr[10][@"advice"];
            tv12.tag = 2011;
            tv12.delegate = self;
            [imagv addSubview:tv12];
            
            UITextView *tv13 = [[UITextView alloc]initWithFrame:CGRectMake(tv4.right + 140, tv12.bottom + 60, 150, 110)];
            tv13.text = self.tempM2061Arr[11][@"advice"];
            tv13.tag = 2012;
            tv13.delegate = self;
            tv13.font = DEF_MyFont(16);

            [imagv addSubview:tv13];
            
            UIButton *commit = [[UIButton alloc]initWithFrame:CGRectMake(tv13.right - 80, tv13.bottom + 20, 80, 80)];
            [commit addTarget:self action:@selector(gousicommit) forControlEvents:UIControlEventTouchUpInside];
            [imagv addSubview:commit];

            
        }else if ([str intValue] == 64) {
            self.tempM2061Arr = [[NSMutableArray alloc]init];
            if (result[@"content"] == nil || [result[@"content"] isEqualToString:@""]) {
                self.tempM2061Arr = [[NSMutableArray alloc]init];
                for (int i = 0; i < 10; i++) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                    [dic setObject:@"" forKey:@"advice"];
                    [self.tempM2061Arr addObject:dic];
                }
            }else{
                
                NSData *jsonData = [result[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
                NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:nil];
                self.tempM2061Arr = [[NSMutableArray alloc]initWithArray:arr];
            }

            UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.gousiBackView.width, self.gousiBackView.height - 100)];
            imagv.image = DEF_IMAGE(@"article_4");
            imagv.userInteractionEnabled = YES;
            imagv.userInteractionEnabled = YES;
            imagv.contentMode = UIViewContentModeScaleAspectFit;
            [self.gousiBackView addSubview:imagv];

            UITextView *tv1 = [[UITextView alloc]initWithFrame:CGRectMake(120, 50, 190, 50)];
            tv1.text = self.tempM2061Arr[0][@"advice"];
            tv1.tag = 2001;
            tv1.delegate = self;
            tv1.font = DEF_MyFont(16);

            tv1.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv1];
            
            UITextView *tv2 = [[UITextView alloc]initWithFrame:CGRectMake(120, tv1.bottom + 30, 190, 450)];
            tv2.text = self.tempM2061Arr[1][@"advice"];
            tv2.tag = 2002;
            tv2.delegate = self;
            tv2.font = DEF_MyFont(16);
            tv2.backgroundColor = [UIColor clearColor];

            [imagv addSubview:tv2];

            UITextView *tv3 = [[UITextView alloc]initWithFrame:CGRectMake(tv1.right + 200, tv1.bottom + 180, 120, 120)];
            tv3.text = self.tempM2061Arr[2][@"advice"];
            tv3.tag = 2003;
            tv3.delegate = self;
            tv3.font = DEF_MyFont(16);
            tv3.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv3];
            
            UITextView *tv4 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x, tv3.y - 160, 120, 120)];
            tv4.text = self.tempM2061Arr[3][@"advice"];
            tv4.tag = 2004;
            tv4.delegate = self;
            tv4.font = DEF_MyFont(16);
            tv4.backgroundColor = [UIColor clearColor];

            [imagv addSubview:tv4];
            
            UITextView *tv5 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x - 70, tv3.bottom + 40, 100, 100)];
            tv5.text = self.tempM2061Arr[4][@"advice"];
            tv5.tag = 2005;
            tv5.delegate = self;
            tv5.font = DEF_MyFont(16);
            tv5.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv5];
            
            UITextView *tv6 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x + 80, tv3.bottom + 40, 100, 100)];
            tv6.text = self.tempM2061Arr[5][@"advice"];
            tv6.tag = 2006;
            tv6.delegate = self;
            tv6.font = DEF_MyFont(16);
            tv6.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv6];
            
            UITextView *tv7 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.x - 130, tv3.y - 10, 100, 100)];
            tv7.text = self.tempM2061Arr[6][@"advice"];
            tv7.tag = 2007;
            tv7.delegate = self;
            tv7.font = DEF_MyFont(16);
            tv7.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv7];
            
            UITextView *tv8 = [[UITextView alloc]initWithFrame:CGRectMake(tv3.right + 30, tv3.y - 10, 100, 100)];
            tv8.text = self.tempM2061Arr[7][@"advice"];
            tv8.tag = 2008;
            tv8.delegate = self;
            tv8.font = DEF_MyFont(16);
            tv8.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv8];

            UITextView *tv9 = [[UITextView alloc]initWithFrame:CGRectMake(tv8.right - 20, tv1.y + 20, 150, 110)];
            tv9.text = self.tempM2061Arr[8][@"advice"];
            tv9.tag = 2009;
            tv9.delegate = self;
            tv9.font = DEF_MyFont(16);
            tv9.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv9];
            
            UITextView *tv10 = [[UITextView alloc]initWithFrame:CGRectMake(tv8.right - 20, tv8.bottom + 30, 150, 110)];
            tv10.text = self.tempM2061Arr[9][@"advice"];
            tv10.tag = 2010;
            tv10.delegate = self;
            tv10.font = DEF_MyFont(16);
            tv10.backgroundColor = [UIColor clearColor];
            [imagv addSubview:tv10];
            
            UIButton *commit = [[UIButton alloc]initWithFrame:CGRectMake(tv10.right - 80, tv10.bottom + 20, 80, 80)];
            [commit addTarget:self action:@selector(gousicommit) forControlEvents:UIControlEventTouchUpInside];
            [imagv addSubview:commit];
        }
        
    } failture:^(id result) {
        
    }];
    
//    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(30, 40, 250, 70)];
//    imagv.contentMode = UIViewContentModeScaleAspectFit;
//    imagv.clipsToBounds = YES;
//    imagv.image = DEF_IMAGE(@"gousi_Bg");
//    [self.gousiBackView addSubview:imagv];
//    
//    self.gousiScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.gousiBackView.width, self.gousiBackView.height - 110)];
//    self.gousiScro.alwaysBounceVertical = YES;
//    self.gousiScro.alwaysBounceHorizontal = YES;
//    [self.gousiBackView addSubview:self.gousiScro];
//    
//    NSDictionary * dic = @{
//                           @"method"           :@"M301",
//                           @"level2"           :@"4",
//                           @"level3"           :@"2",};
//    [RequestOperationManager getParametersDic:dic success:^(NSMutableDictionary *result) {
//        
//        self.M301Dic = result;
//        
//        [self.tempM301Arr removeAllObjects];
//        
//        self.gousiScro.contentSize = CGSizeMake(2000, 3000);
//        self.gousiScro.contentOffset = CGPointMake(self.gousiScro.contentSize.width/2 - self.gousiScro.size.width/2, self.gousiScro.contentSize.height/2 - self.gousiScro.size.height/2);
//        
//        UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.gousiScro.contentSize.width/2 - 120, self.gousiScro.contentSize.height/2 - 62, 240, 125)];
//        level1.userInteractionEnabled = YES;
//        level1.image = DEF_IMAGE(@"gousi_yun");
//        level1.contentMode = UIViewContentModeScaleAspectFill;
//        level1.backgroundColor = [UIColor whiteColor];
//        level1.clipsToBounds = YES;
//        [self.gousiScro addSubview:level1];
//        
//        UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 30, level1.width - 40, level1.height - 60)];
//        tv.backgroundColor = [UIColor clearColor];
//        tv.delegate = self;
//        tv.text = result[@"list"][0][@"content"];
//        tv.tag = 100000;
//        [level1 addSubview:tv];
//        
//        
//        int count = 3;
//        
//        if (count == 2) {
//            NSMutableArray *arr2 = result[@"list"][0][@"list"];
//            NSMutableArray *pointArr = [[NSMutableArray alloc]init];
//            
//            if ([arr2 count]%2 == 0) {
//                
//                float x1 = level1.centerX - 300;
//                float x2 = level1.centerX + 300;
//                float y1 = level1.centerY - 300;
//                float y2 = level1.centerY - 300;
//                for (int i = 0; i < [arr2 count]; i ++) {
//                    NSMutableDictionary *dicf = arr2[i];
//
//                    if (i < [arr2 count]/2) {
//                        
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
//                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY],
//                                              @"content" :dicf[@"content"],
//                                              @"tag"   :@(10000 + i)}];
//                        if ([arr2 count]/2 > 1) {
//                            y1 += 600/([arr2 count]/2 - 1);
//                            
//                        }else{
//                            y1 += 600/([arr2 count]/2);
//                        }
//                    }else{
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        //[pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];
//                        
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
//                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY],
//                                              @"content" :dicf[@"content"],
//                                              @"tag"   :@(10000 + i)}];
//                        if ([arr2 count]/2 > 1) {
//                            y1 += 600/([arr2 count]/2 - 1);
//                            
//                        }else{
//                            y1 += 600/([arr2 count]/2);
//                        }
//                    }
//                }
//                
//            }else{
//                
//                float x1 = level1.centerX - 300;
//                float x2 = level1.centerX + 300;
//                float y1 = level1.centerY - 300;
//                float y2 = level1.centerY - 300;
//                
//                //                CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(level1.centerX, level1.centerY - 300)];
//                //                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                //                [self.gousiScro addSubview:line];
//                
//                [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",level1.centerX],@"y1":[NSString stringWithFormat:@"%f",level1.centerY - 300],
//                                      @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY],
//                                      @"content" :arr2[0][@"content"],
//                                      @"tag"   :@(10000 + 0)}];
//                
//                
//                NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:arr2];
//                [tempArr removeObjectAtIndex:0];
//                
//                for (int i = 0; i < [tempArr count]; i ++) {
//                    NSMutableDictionary *dicf = tempArr[i];
//
//                    if (i < [tempArr count]/2) {
//                        
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
//                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY],
//                                              @"content" :dicf[@"content"],
//                                              @"tag"   :@(10001 + i)}];
//                        
//                        if ([tempArr count]/2 > 1) {
//                            y1 += 600/([tempArr count]/2 - 1);
//
//                        }else{
//                            y1 += 600/([tempArr count]/2);
//                        }
//                    }else{
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
//                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY],
//                                              @"content" :dicf[@"content"],
//                                              @"tag"   :@(10001 + i)}];
//                        
//                        if ([tempArr count]/2 > 1) {
//                            y1 += 600/([tempArr count]/2 - 1);
//                            
//                        }else{
//                            y1 += 600/([tempArr count]/2);
//                        }
//                    }
//                }
//                
//            }
//            
//            CustomLine *line = [[CustomLine alloc]initWithPointArr:pointArr];
//            line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//            [self.gousiScro addSubview:line];
//
//            for (NSDictionary *dicc in pointArr) {
//                
//                UIImageView *level11 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
//                level11.userInteractionEnabled = YES;
//                level11.image = DEF_IMAGE(@"gousi_yun");
//                level11.contentMode = UIViewContentModeScaleAspectFill;
//                level11.backgroundColor = [UIColor whiteColor];
//                level11.clipsToBounds = YES;
//                level11.centerX = [dicc[@"x1"] floatValue];
//                level11.centerY = [dicc[@"y1"] floatValue];
//                [self.gousiScro addSubview:level11];
//                
//                UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 30, level11.width - 40, level11.height - 60)];
//                tv.backgroundColor = [UIColor clearColor];
//                tv.delegate = self;
//                tv.text = dicc[@"content"];
//                tv.tag = [dicc[@"tag"] intValue];
//                [level11 addSubview:tv];
//            }
//            
//            
//            [self.gousiScro bringSubviewToFront:level1];
//            
//        }else if (count == 3){
//            
//            NSMutableArray *arr2 = result[@"list"][0][@"list"];
//            NSMutableArray *pointArr = [[NSMutableArray alloc]init];
//            
//            if ([arr2 count]%2 == 0) {
//                
//                int count = 0;
//                
//                for (NSDictionary *dic in arr2) {
//                    NSArray *arr3 = dic[@"list"];
//                    for (NSDictionary *dic in arr3) {
//                        count += 1;
//                    }
//                }
//                
//                float x1 = level1.centerX - 300;
//                float x2 = level1.centerX + 300;
//                float y1 = level1.centerY - 300;
//                float y2 = level1.centerY - 300;
//                
//                float xx1 = x1 - 300;
//                float yy1 = level1.centerY - (150*count/4);
//                
//                float xx2 = x2 + 300;
//                float yy2 = level1.centerY - (150*count/4);
//                
//                for (int i = 0; i < [arr2 count]; i ++) {
//                    
//                    NSMutableDictionary *dicr = arr2[i];
//                    NSArray *arr3 = dicr[@"list"];
//                    
//                    if (i < [arr2 count]/2) {
//                        
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
//                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY],
//                                              @"content" :dicr[@"content"],
//                                              @"tag"     :@(1000 * i)}];
//                        int f = 0;
//                        for (NSDictionary *dic in arr3) {
//                        
//                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x1, y1) EndPoint:CGPointMake(xx1, yy1)];
//                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                            //                            [self.gousiScro addSubview:line1];
//                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx1],@"y1":[NSString stringWithFormat:@"%f",yy1],
//                                                  @"x"  :[NSString stringWithFormat:@"%f",x1],@"y" :[NSString stringWithFormat:@"%f",y1],
//                                                  @"content" :dic[@"content"],
//                                                  @"tag"     :@(1000 * i + f)}];
//                            
//                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
//                            level1.userInteractionEnabled = YES;
//                            level1.image = DEF_IMAGE(@"gousi_yun");
//                            level1.contentMode = UIViewContentModeScaleAspectFill;
//                            level1.backgroundColor = [UIColor whiteColor];
//                            level1.clipsToBounds = YES;
//                            level1.centerX = xx1;
//                            level1.centerY = yy1;
//                            [self.gousiScro addSubview:level1];
//                            
//                            UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 30, level1.width - 40, level1.height - 60)];
//                            tv.backgroundColor = [UIColor clearColor];
//                            tv.delegate = self;
//                            tv.text = dic[@"content"];
//                            tv.tag = 1000 * i + f;
//                            [level1 addSubview:tv];
//
//                            yy1 += 150;
//                            f ++;
//                        }
//                        y1 += 600/([arr2 count]/2 - 1);
//                        
//                    }else{
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
//                                              @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY],
//                                              @"content" :dicr[@"content"],
//                                              @"tag"     :@(1000 * i)}];
//                        int f = 0;
//                        for (NSDictionary *dic in arr3) {
//                            
//                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x2, y2) EndPoint:CGPointMake(xx2, yy2)];
//                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                            //                            [self.gousiScro addSubview:line1];
//                            
//                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx2],@"y1":[NSString stringWithFormat:@"%f",yy2],
//                                                  @"x"  :[NSString stringWithFormat:@"%f",x2],@"y" :[NSString stringWithFormat:@"%f",y2],
//                                                  @"content" :dic[@"content"],
//                                                  @"tag"     :@(1000 * i + f)}];
//                            
//                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
//                            level1.userInteractionEnabled = YES;
//                            level1.image = DEF_IMAGE(@"gousi_yun");
//                            level1.contentMode = UIViewContentModeScaleAspectFill;
//                            level1.backgroundColor = [UIColor whiteColor];
//                            level1.clipsToBounds = YES;
//                            level1.centerX = xx2;
//                            level1.centerY = yy2;
//                            [self.gousiScro addSubview:level1];
//                            
//                            UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 30, level1.width - 40, level1.height - 60)];
//                            tv.backgroundColor = [UIColor clearColor];
//                            tv.delegate = self;
//                            tv.text = dic[@"content"];
//                            tv.tag = 1000 * i + f;
//                            [level1 addSubview:tv];
//                            
//                            yy2 += 150;
//                            f ++;
//
//                        }
//                        
//                        y2 += 600/([arr2 count]/2 - 1);
//                    }
//                }
//                
//                CustomLine *line = [[CustomLine alloc]initWithPointArr:pointArr];
//                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                [self.gousiScro addSubview:line];
//                
//                for (UIView *view in [self.gousiScro subviews]) {
//                    if ([view isKindOfClass:[UIImageView class]]) {
//                        [self.gousiScro bringSubviewToFront:view];
//                    }
//                }
//            }else{
//                
//                int count = 0;
//                
//                for (NSDictionary *dic in arr2) {
//                    NSArray *arr3 = dic[@"list"];
//                    for (NSDictionary *dic in arr3) {
//                        count += 1;
//                    }
//                }
//                
//                float x1 = level1.centerX - 300;
//                float x2 = level1.centerX + 300;
//                float y1 = level1.centerY - 300;
//                float y2 = level1.centerY - 300;
//                
//                float xx1 = x1 - 300;
//                float yy1 = level1.centerY - (150*count/4);
//                
//                float xx2 = x2 + 300;
//                float yy2 = level1.centerY - (150*count/4);
//                
//                //                CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(level1.centerX, level1.centerY - 300)];
//                //                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                //                [self.gousiScro addSubview:line];
//                [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",level1.centerX],@"y1":[NSString stringWithFormat:@"%f",level1.centerY - 300],
//                                      @"x"  :[NSString stringWithFormat:@"%f",level1.centerX],@"y" :[NSString stringWithFormat:@"%f",level1.centerY]}];
//                
//                NSDictionary *dic = [arr2 objectAtIndex:0];
//                NSArray *arr4 = dic[@"list"];
//                
//                float xxx = level1.centerX + 200;
//                float yyy = level1.centerY - 600;
//                
//                for (int i = 0; i < [arr4 count]; i ++) {
//                    //                    CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY - 300) EndPoint:CGPointMake(xxx, yyy)];
//                    //                    line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                    //                    [self.gousiScro addSubview:line];
//                    
//                    [pointArr addObject:@{@"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY - 300],
//                                          @"x1"  :[NSString stringWithFormat:@"%f",xxx],@"y1" :[NSString stringWithFormat:@"%f",yyy]}];
//                    
//                    UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
//                    level1.userInteractionEnabled = YES;
//                    level1.image = DEF_IMAGE(@"gousi_yun");
//                    level1.contentMode = UIViewContentModeScaleAspectFill;
//                    level1.backgroundColor = [UIColor whiteColor];
//                    level1.clipsToBounds = YES;
//                    level1.centerX = xxx;
//                    level1.centerY = yyy;
//                    [self.gousiScro addSubview:level1];
//                    yyy -= 150;
//                }
//                
//                NSMutableArray *tempArr = [[NSMutableArray alloc]initWithArray:arr2];
//                [tempArr removeObjectAtIndex:0];
//                
//                for (int i = 0; i < [tempArr count]; i ++) {
//                    NSMutableDictionary *dic = tempArr[i];
//                    NSArray *arr3 = dic[@"list"];
//                    if (i < [tempArr count]/2) {
//                        
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x1, y1)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x1],@"y1":[NSString stringWithFormat:@"%f",y1],
//                                              @"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY]}];
//                        
//                        for (NSDictionary *dic in arr3) {
//                            
//                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x1, y1) EndPoint:CGPointMake(xx1, yy1)];
//                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                            //                            [self.gousiScro addSubview:line1];
//                            
//                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx1],@"y1":[NSString stringWithFormat:@"%f",yy1],
//                                                  @"x" :[NSString stringWithFormat:@"%f",x1],@"y":[NSString stringWithFormat:@"%f",y1]}];
//                            
//                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
//                            level1.userInteractionEnabled = YES;
//                            level1.image = DEF_IMAGE(@"gousi_yun");
//                            level1.contentMode = UIViewContentModeScaleAspectFill;
//                            level1.backgroundColor = [UIColor whiteColor];
//                            level1.clipsToBounds = YES;
//                            level1.centerX = xx1;
//                            level1.centerY = yy1;
//                            [self.gousiScro addSubview:level1];
//                            
//                            yy1 += 150;
//                        }
//                        
//                        y1 += 600/([tempArr count]/2 - 1);
//                    }else{
//                        //                        CustomLine *line = [[CustomLine alloc]initWithStartPoint:CGPointMake(level1.centerX, level1.centerY) EndPoint:CGPointMake(x2, y2)];
//                        //                        line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                        //                        [self.gousiScro addSubview:line];
//                        [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",x2],@"y1":[NSString stringWithFormat:@"%f",y2],
//                                              @"x" :[NSString stringWithFormat:@"%f",level1.centerX],@"y":[NSString stringWithFormat:@"%f",level1.centerY]}];
//                        
//                        for (NSDictionary *dic in arr3) {
//                            
//                            //                            CustomLine *line1 = [[CustomLine alloc]initWithStartPoint:CGPointMake(x2, y2) EndPoint:CGPointMake(xx2, yy2)];
//                            //                            line1.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                            //                            [self.gousiScro addSubview:line1];
//                            
//                            [pointArr addObject:@{@"x1" :[NSString stringWithFormat:@"%f",xx2],@"y1":[NSString stringWithFormat:@"%f",yy2],
//                                                  @"x" :[NSString stringWithFormat:@"%f",x2],@"y":[NSString stringWithFormat:@"%f",y2]}];
//                            
//                            UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
//                            level1.userInteractionEnabled = YES;
//                            level1.image = DEF_IMAGE(@"gousi_yun");
//                            level1.contentMode = UIViewContentModeScaleAspectFill;
//                            level1.backgroundColor = [UIColor whiteColor];
//                            level1.clipsToBounds = YES;
//                            level1.centerX = xx2;
//                            level1.centerY = yy2;
//                            [self.gousiScro addSubview:level1];
//                            
//                            yy2 += 150;
//                        }
//                        
//                        y2 += 600/([tempArr count]/2 - 1);
//                    }
//                }
//                
//                CustomLine *line = [[CustomLine alloc]initWithPointArr:pointArr];
//                line.frame = CGRectMake(0, 0, self.gousiScro.contentSize.width, self.gousiScro.contentSize.height);
//                [self.gousiScro addSubview:line];
//                
//                for (UIView *view in [self.gousiScro subviews]) {
//                    if ([view isKindOfClass:[UIImageView class]]) {
//                        [self.gousiScro bringSubviewToFront:view];
//                    }
//                }
//                
//            }
//            
//            for (NSDictionary *dicc in pointArr) {
//                
//                UIImageView *level1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 125)];
//                level1.userInteractionEnabled = YES;
//                level1.image = DEF_IMAGE(@"gousi_yun");
//                level1.contentMode = UIViewContentModeScaleAspectFill;
//                level1.backgroundColor = [UIColor whiteColor];
//                level1.clipsToBounds = YES;
//                level1.centerX = [dicc[@"x"] floatValue];
//                level1.centerY = [dicc[@"y"] floatValue];
//                [self.gousiScro addSubview:level1];
//                
//                UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(20, 30, level1.width - 40, level1.height - 60)];
//                tv.backgroundColor = [UIColor clearColor];
//                tv.delegate = self;
//                tv.text = dicc[@"content"];
//                tv.tag = [dicc[@"tag"] intValue];
//                [level1 addSubview:tv];
//            }
//            
//            [self.gousiScro bringSubviewToFront:level1];
//            
//        }
//        
//    } failture:^(id result) {
//        
//    }];

}

-(void)action1
{
    self.btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    self.btn1.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    self.btn2.backgroundColor = [UIColor clearColor];
    self.btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn3.backgroundColor = [UIColor clearColor];
    self.btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.gousiBackView.hidden = NO;
    self.wendangBackView.hidden = YES;
    self.ketangBackView.hidden = YES;

}

-(void)action2
{
    self.btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    self.btn2.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.btn1.backgroundColor = [UIColor clearColor];
    self.btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn3.backgroundColor = [UIColor clearColor];
    self.btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.gousiBackView.hidden = YES;
    self.wendangBackView.hidden = NO;
    self.ketangBackView.hidden = YES;
}

-(void)action3
{
    self.btn3.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    self.btn3.backgroundColor = DEF_COLOR_RGB(42, 178, 244);
    [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.btn2.backgroundColor = [UIColor clearColor];
    self.btn2.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn1.backgroundColor = [UIColor clearColor];
    self.btn1.layer.borderColor = DEF_COLOR_RGB(42, 178, 244).CGColor;
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.gousiBackView.hidden = YES;
    self.wendangBackView.hidden = YES;
    self.ketangBackView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
