//
//  MSRWeChatSDK.swift
//  MSRWeChatSDK
//
//  Created by Darren Liu on 15/4/14.
//  Copyright (c) 2015年 MsrLab. All rights reserved.
//

import UIKit
import WeChatSDK

@objc public enum MSRWeChatErrorCode: Int {
    case Success = 0
    case Common = -1
    case UserCancel = -2
    case SentFail = -3
    case AuthDeny = -4
    case Unsupport = -5
}

@objc public enum MSRWeChatScene: Int {
    case Session = 0
    case Timeline = 1
    case Favorite = 2
}

@objc public enum MSRWeChatAPISupport: Int {
    case Session = 0
}

@objc public enum MSRWeChatProfileType: Int {
    case Normal = 0
    case Device = 1
}

@objc public enum MSRWeChatWebviewType: Int {
    case Ad = 0
}

@objc public class MSRWeChatManager: NSObject, WXApiDelegate {
    
    public static let defaultManager = MSRWeChatManager()
    
    public func shareText(text: String, toScene scene: MSRWeChatScene) -> Bool {
        let request = SendMessageToWXReq()
        request.text = text
        request.bText = true
        request.scene = Int32(scene.rawValue)
        return WXApi.sendReq(request)
    }
    
    public func shareImage(image: UIImage, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXImageObject()
        object.imageData = UIImageJPEGRepresentation(image, 1)
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareImageWithData(data: NSData, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXImageObject()
        object.imageData = data
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareLink(link: NSURL, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXWebpageObject()
        object.webpageUrl = link.absoluteString
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareMusicWithDataURL(dataURL: NSURL, toScene scene: MSRWeChatScene, lowBandDataURL: NSURL?, webpageURL: NSURL?, lowBandWebPageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXMusicObject()
        object.musicUrl = webpageURL?.absoluteString
        object.musicDataUrl = dataURL.absoluteString
        object.musicLowBandDataUrl = lowBandDataURL?.absoluteString
        object.musicLowBandUrl = lowBandWebPageURL?.absoluteString
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareVideoWithURL(URL: NSURL, toScene scene: MSRWeChatScene, lowBandVideoURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXVideoObject()
        object.videoUrl = URL.absoluteString
        object.videoLowBandUrl = lowBandVideoURL?.absoluteString
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareWebpageWithURL(URL: NSURL, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXWebpageObject()
        object.webpageUrl = URL.absoluteString
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareApplicationDefinedInformations(informations: String, toScene scene: MSRWeChatScene, appURL: NSURL?, fileData: NSData?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXAppExtendObject()
        object.url = appURL?.absoluteString
        object.extInfo = informations
        object.fileData = fileData
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareFileWithData(data: NSData, toScene scene: MSRWeChatScene, extensionName: String, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXFileObject()
        object.fileData = data
        object.fileExtension = extensionName
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func shareEmoticonWithData(data: NSData, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let object = WXEmoticonObject()
        object.emoticonData = data
        return _shareObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action)
    }
    
    public func handleOpenURL(URL: NSURL) -> Bool {
        return WXApi.handleOpenURL(URL, delegate: _MSRWeChatManager.defaultManager)
    }
    
    private func _shareObject(object: AnyObject, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?) -> Bool {
        let message = WXMediaMessage()
        message.title = title
        message.description = description
        message.setThumbImage(thumbnailImage)
        message.mediaObject = object
        message.mediaTagName = tagName
        let request = SendMessageToWXReq()
        request.bText = false
        request.message = message
        request.scene = Int32(scene.rawValue)
       return WXApi.sendReq(request)
    }
    
    public func registerAppWithID(ID: String) -> Bool {
        return WXApi.registerApp(ID)
    }
    
    public func registerAppWithID(ID: String, description: String) -> Bool {
        return WXApi.registerApp(ID, withDescription: description)
    }
    
}

@objc class _MSRWeChatManager: NSObject, WXApiDelegate {
    
    static let defaultManager = _MSRWeChatManager()
    
    func onReq(request: BaseReq!) {
        print("ON REQUEST ")
        println(request)
        switch request {
        case let request as GetMessageFromWXReq:
            // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
            break
        case let request as ShowMessageFromWXReq:
            // 显示微信传过来的内容
            break
        case let request as LaunchFromWXReq:
            // 从微信启动App
            break
        default:
            break
        }
    }
    
    func onResp(response: BaseResp!) {
        print("ON RESPONSE ")
        println(response)
        switch response {
        case let response as SendMessageToWXResp:
            // 发送媒体消息结果
            break
        case let response as SendAuthResp:
            // Auth结果
            break
        case let response as AddCardToWXCardPackageResp:
            break
        default:
            break
        }
    }

    
}