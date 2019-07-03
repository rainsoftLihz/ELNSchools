platform :ios, '9.0'

#去掉pod警告
inhibit_all_warnings!
#use_frameworks!

target 'ELNSchool' do
    # 自动布局
    pod 'Masonry', '~> 1.1.0'
    #网络框架
    pod 'AFNetworking', '~> 3.2.1'
    #YYKit
    #pod 'YYKit'
    # 刷新控件
    pod 'MJRefresh', '~> 3.1.12'
    #HUD
    pod 'SVProgressHUD'
    # 分栏控制器
    pod 'HMSegmentedControl'
    #回调块
    pod 'BlocksKit'
    #键盘
    pod 'IQKeyboardManager'
    #图片加载
    pod 'SDWebImage', '~> 4.3.2'
    # 数据库
    #pod 'BGFMDB'
    #UI基础框架
    pod 'QMUIKit', '~> 2.9.0'
    #RAC
    pod 'ReactiveCocoa', '~> 2.5'
    #网页JavaScript控制
    #pod 'WebViewJavascriptBridge', '~> 6.0.3'
    #页面滑动控制
    #pod 'SGPagingView'
    
    #轮播框架
     pod 'SDCycleScrollView', '~> 1.75'
    #视频播放
    pod 'ZFPlayer', '~> 3.2.3'
    pod 'ZFPlayer/ControlView', '~> 3.2.3'
    pod 'ZFPlayer/AVPlayer', '~> 3.2.3'
    
    #微信登录
    pod 'UMCShare/Social/ReducedWeChat'
    #微信
    pod 'WechatOpenSDK'
end





post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
    end
end
