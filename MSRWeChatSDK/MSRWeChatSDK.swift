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

@objc public class MSRWeChatManager: NSObject {
    
    public static let defaultManager = MSRWeChatManager()
    
    public func sendText(text: String, toScene scene: MSRWeChatScene, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let request = SendMessageToWXReq()
        request.text = text
        request.bText = true
        request.scene = Int32(scene.rawValue)
        let result = WXApi.sendReq(request)
        if result {
            success?()
        } else {
            failure?()
        }
        return result
    }
    
    public func sendImage(image: UIImage, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXImageObject()
        object.imageData = UIImageJPEGRepresentation(image, 1)
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendImageWithData(data: NSData, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXImageObject()
        object.imageData = data
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendLink(link: NSURL, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXWebpageObject()
        object.webpageUrl = link.absoluteString
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendMusicWithDataURL(dataURL: NSURL, toScene scene: MSRWeChatScene, lowBandDataURL: NSURL?, webpageURL: NSURL?, lowBandWebPageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXMusicObject()
        object.musicUrl = webpageURL?.absoluteString
        object.musicDataUrl = dataURL.absoluteString
        object.musicLowBandDataUrl = lowBandDataURL?.absoluteString
        object.musicLowBandUrl = lowBandWebPageURL?.absoluteString
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendVideoWithURL(url: NSURL, toScene scene: MSRWeChatScene, lowBandVideoURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXVideoObject()
        object.videoUrl = url.absoluteString
        object.videoLowBandUrl = lowBandVideoURL?.absoluteString
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendWebpageWithURL(url: NSURL, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXWebpageObject()
        object.webpageUrl = url.absoluteString
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendApplicationDefinedInformations(informations: String, toScene scene: MSRWeChatScene, appURL: NSURL?, fileData: NSData?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXAppExtendObject()
        object.url = appURL?.absoluteString
        object.extInfo = informations
        object.fileData = fileData
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendFileWithData(data: NSData, toScene scene: MSRWeChatScene, extensionName: String, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXFileObject()
        object.fileData = data
        object.fileExtension = extensionName
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func sendEmoticonWithData(data: NSData, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
        let object = WXEmoticonObject()
        object.emoticonData = data
        return _sendObject(object, toScene: scene, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, success: success, failure: failure)
    }
    
    public func handleOpenURL(url: NSURL, withDelegate delegate: MSRWeChatManagerDelegate) -> Bool {
        _MSRWeChatManager.defaultManager.delegate = delegate
        return WXApi.handleOpenURL(url, delegate: _MSRWeChatManager.defaultManager)
    }
    
    public func weChatIsInstalled() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    public func weChatSupportsOpenAPI() -> Bool {
        return WXApi.isWXAppSupportApi()
    }
    
    public func weChatInstallURL() -> String? {
        return WXApi.getWXAppInstallUrl()
    }
    
    public func weChatAPIVersion() -> String? {
        return WXApi.getApiVersion()
    }
    
    public func launchWeChat() -> Bool {
        return WXApi.openWXApp()
    }
    
    public func registerAppWithID(ID: String) -> Bool {
        return WXApi.registerApp(ID)
    }
    
    public func registerAppWithID(ID: String, description: String) -> Bool {
        return WXApi.registerApp(ID, withDescription: description)
    }
    
    private func _sendObject(object: AnyObject, toScene scene: MSRWeChatScene, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, success: (() -> Void)?, failure: (() -> Void)?) -> Bool {
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
        let result = WXApi.sendReq(request)
        if result {
            success?()
        } else {
            failure?()
        }
        return result
    }

}

@objc public protocol MSRWeChatManagerDelegate {
    optional func msr_didReceiveMessageSendingResponseFromWeChat(errorCode: MSRWeChatErrorCode, errorString: String?)
    optional func msr_didReceiveAuthorizationResponseFromWeChat(errorCode: MSRWeChatErrorCode, errorString: String?, token: String?, mark: String?)
    optional func msr_didReceiveCardsAddingResponseFromWeChat(errorCode: MSRWeChatErrorCode, errorStrong: String?, cards: [MSRWeChatCard]?)
}

@objc public class MSRWeChatCard: NSObject {
    var identifier: String = ""
    var extraMessage: String = ""
    var added: Bool = false
}

@objc class _MSRWeChatManager: NSObject, WXApiDelegate {
    
    static var defaultManager = _MSRWeChatManager()
    
    var delegate: MSRWeChatManagerDelegate?
    
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
        let errorCode = MSRWeChatErrorCode(rawValue: Int(response.errCode))!
        let errorString = response.errStr
        switch response {
        case let response as SendMessageToWXResp:
            delegate?.msr_didReceiveMessageSendingResponseFromWeChat?(errorCode, errorString: errorString)
            break
        case let response as SendAuthResp:
            delegate?.msr_didReceiveAuthorizationResponseFromWeChat?(errorCode, errorString: errorString, token: response.code, mark: response.state)
            break
        case let response as AddCardToWXCardPackageResp:
            var cards: [MSRWeChatCard]?
            if errorCode == .Success {
                cards = []
                for item in response.cardAry as! [WXCardItem] {
                    let c = MSRWeChatCard()
                    c.identifier = item.cardId
                    c.extraMessage = item.extMsg
                    c.added = item.cardState == 1
                    cards!.append(c)
                }
            }
            delegate?.msr_didReceiveCardsAddingResponseFromWeChat?(errorCode, errorStrong: errorString, cards: cards)
            break
        default:
            break
        }
    }
    
}
