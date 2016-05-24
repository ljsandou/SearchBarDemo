//
//  public_Func.swift
//  SearchBarDemo
//
//  Created by 三斗 on 5/24/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

struct Constants {
  static let netIp = "192.168.1.130"
  static let IP = "http://\(netIp)/douban/"
  static let imageIp = "http://\(netIp)/douban/thumb/"
}

struct Public_Func {
  static let instance = Public_Func()
  func getInfoList(url:String,parameter:[String:String]?,handle:([[String:String]]?,error:String?) -> Void){
    var errorMessage :String?
    AFHTTPSessionManager().POST(Constants.IP + url, parameters: parameter, progress: { (progress) in
      print(progress)
      }, success: { (request, json) in
        guard let data = json! as? [String:AnyObject] else{
          errorMessage = "服务器问题"
          return
        }
        
        guard let status = data["status"] as? String where status == "success" else{
          errorMessage = "数据格式问题"
          return
        }
        errorMessage = nil
        handle(data["result"] as? [[String:String]], error: errorMessage)
    }) { (request, error) in
      errorMessage = "404错误"
      handle(nil, error: errorMessage)
    }
  }
}

extension UIAlertController{
  struct Common {
    struct Setting {
      static let GoToSetting = UIApplicationOpenSettingsURLString
    }
    struct Alert {
      static let SettingTitle = "前往设置页面"
      static let CancelTitle = "取消"
      static let SetTitle = "设置"
      static let ErrorHint = "错误信息"
      static let OkTitle = "确定"
    }
  }
  
  func getCurrentViewController() -> UIViewController?{
    var result:UIViewController?
    var window = UIApplication.sharedApplication().keyWindow
    if window?.windowLevel != UIWindowLevelNormal{
      let windows = UIApplication.sharedApplication().windows
      for tmpWin in windows{
        if tmpWin.windowLevel == UIWindowLevelNormal{
          window = tmpWin
          break
        }
      }
    }
    
    let fromView = window?.subviews[0]
    if let nextRespnder = fromView?.nextResponder(){
      if nextRespnder.isKindOfClass(UIViewController){
        result = nextRespnder as? UIViewController
      }else{
        result = window?.rootViewController
      }
    }
    return result
  }
  
  func pendingDevice() -> UIAlertControllerStyle{
    switch UIDevice.currentDevice().userInterfaceIdiom{
    case .Pad:
      return UIAlertControllerStyle.ActionSheet
    default: return  UIAlertControllerStyle.Alert
    }
  }
  
  func goToSettingAlert(){
    if let  currentVc = getCurrentViewController() {
      let alertController = UIAlertController(title: Common.Alert.SettingTitle, message: nil, preferredStyle:pendingDevice())
      
      let settingAction = UIAlertAction(title:  Common.Alert.SetTitle, style: .Default) { (_) in
        UIApplication.sharedApplication().openURL(NSURL(string: Common.Setting.GoToSetting)!)
      }
      
      let cancelAction =  UIAlertAction(title: Common.Alert.CancelTitle, style: .Cancel, handler: nil)
      alertController.addAction(settingAction)
      alertController.addAction(cancelAction)
      currentVc.presentViewController(alertController, animated: true, completion: nil)
    }
  }
  
  func justHint(title:String){
    if let  currentVc = getCurrentViewController() {
      let alertController = UIAlertController(title: Common.Alert.ErrorHint, message: title, preferredStyle:pendingDevice())
      let okAction = UIAlertAction(title: Common.Alert.OkTitle, style: .Default, handler: nil)
     // let cancelAction =  UIAlertAction(title: Common.Alert.CancelTitle, style: .Cancel, handler: nil)
      alertController.addAction(okAction)
      currentVc.presentViewController(alertController, animated: true, completion: nil)
    }
  }
}

