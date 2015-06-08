//
//  MSRWeChatSDK.swift
//  MSRWeChatSDK
//
//  Created by Darren Liu on 15/4/14.
//  Copyright (c) 2015年 MsrLab. All rights reserved.
//

import UIKit
import WeChatSDK
import MSRWeChatScope

extension MSRWeChatScope: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

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

@objc public class MSRWeChatAPI: NSObject {
    
    public class func sendRequestToScene(scene: MSRWeChatScene, text: String, completion: ((Bool) -> Void)?) {
        let request = SendMessageToWXReq()
        request.text = text
        request.bText = true
        request.scene = Int32(scene.rawValue)
        completion?(WXApi.sendReq(request))
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, image: UIImage, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, image: image, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, image: UIImage, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, image: image, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, image: UIImage, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXImageObject()
        object.imageData = UIImageJPEGRepresentation(image, 1)
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, imageData: NSData, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, imageData: imageData, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, imageData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, imageData: imageData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, imageData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXImageObject()
        object.imageData = imageData
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, webpageURL: NSURL, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, webpageURL: webpageURL, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, webpageURL: NSURL, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, webpageURL: webpageURL, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, webpageURL: NSURL, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXWebpageObject()
        object.webpageUrl = webpageURL.absoluteString
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, musicDataURL: NSURL, lowBandMusicDataURL: NSURL?, musicWebpageURL: NSURL?, lowBandMusicWebPageURL: NSURL?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, musicDataURL: musicDataURL, lowBandMusicDataURL: lowBandMusicDataURL, musicWebpageURL: musicWebpageURL, lowBandMusicWebPageURL: lowBandMusicWebPageURL, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, musicDataURL: NSURL, lowBandMusicDataURL: NSURL?, musicWebpageURL: NSURL?, lowBandMusicWebPageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, musicDataURL: musicDataURL, lowBandMusicDataURL: lowBandMusicDataURL, musicWebpageURL: musicWebpageURL, lowBandMusicWebPageURL: lowBandMusicWebPageURL, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, musicDataURL: NSURL, lowBandMusicDataURL: NSURL?, musicWebpageURL: NSURL?, lowBandMusicWebPageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXMusicObject()
        object.musicUrl = musicWebpageURL?.absoluteString
        object.musicDataUrl = musicDataURL.absoluteString
        object.musicLowBandDataUrl = lowBandMusicDataURL?.absoluteString
        object.musicLowBandUrl = lowBandMusicWebPageURL?.absoluteString
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, videoURL: NSURL, lowBandVideoURL: NSURL?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, videoURL: videoURL, lowBandVideoURL: lowBandVideoURL, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, videoURL: NSURL, lowBandVideoURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, videoURL: videoURL, lowBandVideoURL: lowBandVideoURL, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, videoURL: NSURL, lowBandVideoURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXVideoObject()
        object.videoUrl = videoURL.absoluteString
        object.videoLowBandUrl = lowBandVideoURL?.absoluteString
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, applicationDefinedInformations: String, applicationDownloadURL: NSURL?, fileData: NSData?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, applicationDefinedInformations: applicationDefinedInformations, applicationDownloadURL: applicationDownloadURL, fileData: fileData, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, applicationDefinedInformations: String, applicationDownloadURL: NSURL?, fileData: NSData?, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, applicationDefinedInformations: applicationDefinedInformations, applicationDownloadURL: applicationDownloadURL, fileData: fileData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, applicationDefinedInformations: String, applicationDownloadURL: NSURL?, fileData: NSData?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXAppExtendObject()
        object.url = applicationDownloadURL?.absoluteString
        object.extInfo = applicationDefinedInformations
        object.fileData = fileData
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, fileData: NSData, fileExtensionName: String, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, fileData: fileData, fileExtensionName: fileExtensionName, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, fileData: NSData, fileExtensionName: String, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, fileData: fileData, fileExtensionName: fileExtensionName, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, fileData: NSData, fileExtensionName: String, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXFileObject()
        object.fileData = fileData
        object.fileExtension = fileExtensionName
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, emoticonData: NSData, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, emoticonData: emoticonData, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, emoticonData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendRequestToScene(scene, emoticonData: emoticonData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendRequestToScene(scene: MSRWeChatScene, emoticonData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXEmoticonObject()
        object.emoticonData = emoticonData
        _sendRequestToScene(scene, object: object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    private static var scopeStrings: [MSRWeChatScope: String] = [
        .Base: "snsapi_base",
        .Contacts: "snsapi_contact",
        .Friends: "snsapi_friend",
        .Message: "snsapi_message",
        .SNS: "sns",
        .TimeLine: "post_timeline",
        .UserInfo: "snsapi_userinfo"]
    
    public class func sendAuthorizationRequestWithScope(scope: MSRWeChatScope, openID: String, mark: String?, currentViewController: UIViewController, delegate: MSRWeChatAPIDelegate, completion: ((Bool) -> Void)?) {
        let request = SendAuthReq()
        var first = true
        var scopeString = ""
        for (k, v) in scopeStrings {
            if scope & k != nil {
                if !first {
                    scopeString += ","
                }
                first = false
                scopeString += v
            }
        }
        request.scope = scopeString
        request.state = mark
        request.openID = openID
        let manager = _MSRWeChatManager()
        manager.delegate = delegate
        completion?(WXApi.sendAuthReq(request, viewController: currentViewController, delegate: manager))
    }
    
    public class func sendCardsAddingRequestWithCards(cards: [MSRWeChatCard],  completion: ((Bool) -> Void)?) {
        let request = AddCardToWXCardPackageReq()
        var items = [WXCardItem]()
        for card in cards {
            let item = WXCardItem()
            item.cardId = card.identifier
            item.cardState = card.added ? 1 : 0
            item.extMsg = card.extraMessage
            items.append(item)
        }
        request.cardAry = items
        completion?(WXApi.sendReq(request))
    }

    public class func sendBusinessProfilePresentingRequestWithProfileType(profileType: MSRWeChatProfileType, username: String, extraMessage: String?, completion: ((Bool) -> Void)?) {
        let request = JumpToBizProfileReq()
        request.profileType = Int32(profileType.rawValue)
        request.username = username
        request.extMsg = extraMessage
        completion?(WXApi.sendReq(request))
    }
    
    public class func sendBusinessWebviewPresentingRequestWithWebviewType(webviewType: MSRWeChatWebviewType, username: String, extraMessage: String?, completion: ((Bool) -> Void)?) {
        let request = JumpToBizWebviewReq()
        request.webType = Int32(webviewType.rawValue)
        request.tousrname = username
        request.extMsg = extraMessage
        completion?(WXApi.sendReq(request))
    }

    public class func sendResponseWithText(text: String, completion: ((Bool) -> Void)?) {
        let response = GetMessageFromWXResp()
        response.text = text
        response.bText = true
        completion?(WXApi.sendResp(response))
    }
    
    public class func sendResponseWithImage(image: UIImage, completion: ((Bool) -> Void)?) {
        sendResponseWithImage(image, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithImage(image: UIImage, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithImage(image, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithImage(image: UIImage, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXImageObject()
        object.imageData = UIImageJPEGRepresentation(image, 1)
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendRequestToWithImageData(imageData: NSData, completion: ((Bool) -> Void)?) {
        sendResponseWithImageData(imageData, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithImageData(imageData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithImageData(imageData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithImageData(imageData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXImageObject()
        object.imageData = imageData
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendResponseWithWebpageURL(webpageURL: NSURL, completion: ((Bool) -> Void)?) {
        sendResponseWithWebpageURL(webpageURL, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithWebpageURL(webpageURL: NSURL, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithWebpageURL(webpageURL, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithWebpageURL(webpageURL: NSURL, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXWebpageObject()
        object.webpageUrl = webpageURL.absoluteString
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendResponseWithMusicDataURL(musicDataURL: NSURL, lowBandMusicDataURL: NSURL?, musicWebpageURL: NSURL?, lowBandMusicWebPageURL: NSURL?, completion: ((Bool) -> Void)?) {
        sendResponseWithMusicDataURL(musicDataURL, lowBandMusicDataURL: lowBandMusicDataURL, musicWebpageURL: musicWebpageURL, lowBandMusicWebPageURL: lowBandMusicWebPageURL, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithMusicDataURL(musicDataURL: NSURL, lowBandMusicDataURL: NSURL?, musicWebpageURL: NSURL?, lowBandMusicWebPageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithMusicDataURL(musicDataURL, lowBandMusicDataURL: lowBandMusicDataURL, musicWebpageURL: musicWebpageURL, lowBandMusicWebPageURL: lowBandMusicWebPageURL, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithMusicDataURL(musicDataURL: NSURL, lowBandMusicDataURL: NSURL?, musicWebpageURL: NSURL?, lowBandMusicWebPageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXMusicObject()
        object.musicUrl = musicWebpageURL?.absoluteString
        object.musicDataUrl = musicDataURL.absoluteString
        object.musicLowBandDataUrl = lowBandMusicDataURL?.absoluteString
        object.musicLowBandUrl = lowBandMusicWebPageURL?.absoluteString
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendResponseWithVideoURL(videoURL: NSURL, lowBandVideoURL: NSURL?, completion: ((Bool) -> Void)?) {
        sendResponseWithVideoURL(videoURL, lowBandVideoURL: lowBandVideoURL, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithVideoURL(videoURL: NSURL, lowBandVideoURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithVideoURL(videoURL, lowBandVideoURL: lowBandVideoURL, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithVideoURL(videoURL: NSURL, lowBandVideoURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXVideoObject()
        object.videoUrl = videoURL.absoluteString
        object.videoLowBandUrl = lowBandVideoURL?.absoluteString
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendResponseWithApplicationDefinedInformations(applicationDefinedInformations: String, applicationDownloadURL: NSURL?, fileData: NSData?, completion: ((Bool) -> Void)?) {
        sendResponseWithApplicationDefinedInformations(applicationDefinedInformations, applicationDownloadURL: applicationDownloadURL, fileData: fileData, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithApplicationDefinedInformations(applicationDefinedInformations: String, applicationDownloadURL: NSURL?, fileData: NSData?, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithApplicationDeginedInformations(applicationDefinedInformations, applicationDownloadURL: applicationDownloadURL, fileData: fileData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithApplicationDeginedInformations(applicationDefinedInformations: String, applicationDownloadURL: NSURL?, fileData: NSData?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXAppExtendObject()
        object.url = applicationDownloadURL?.absoluteString
        object.extInfo = applicationDefinedInformations
        object.fileData = fileData
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendResponseWithFileData(fileData: NSData, fileExtensionName: String, completion: ((Bool) -> Void)?) {
        sendResponseWithFileData(fileData, fileExtensionName: fileExtensionName, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithFileData(fileData: NSData, fileExtensionName: String, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithFileData(fileData, fileExtensionName: fileExtensionName, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithFileData(fileData: NSData, fileExtensionName: String, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXFileObject()
        object.fileData = fileData
        object.fileExtension = fileExtensionName
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func sendResponseWithEmoticonData(emoticonData: NSData, completion: ((Bool) -> Void)?) {
        sendResponseWithEmoticonData(emoticonData, title: nil, description: nil, thumbnailImage: nil, completion: completion)
    }
    
    public class func sendResponseWithEmoticonData(emoticonData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, completion: ((Bool) -> Void)?) {
        sendResponseWithEmoticonData(emoticonData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: nil, extraMessage: nil, action: nil, completion: completion)
    }
    
    public class func sendResponseWithEmoticonData(emoticonData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let object = WXEmoticonObject()
        object.emoticonData = emoticonData
        _sendResponseWithObject(object, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, completion: completion)
    }
    
    public class func handleOpenURL(url: NSURL, withDelegate delegate: MSRWeChatAPIDelegate) -> Bool {
        let manager = _MSRWeChatManager()
        manager.delegate = delegate
        return WXApi.handleOpenURL(url, delegate: manager)
    }
    
    public class func weChatIsInstalled() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
    public class func weChatSupportsOpenAPI() -> Bool {
        return WXApi.isWXAppSupportApi()
    }
    
    public class func weChatInstallURL() -> String? {
        return WXApi.getWXAppInstallUrl()
    }
    
    public class func weChatAPIVersion() -> String? {
        return WXApi.getApiVersion()
    }
    
    public class func launchWeChat() -> Bool {
        return WXApi.openWXApp()
    }
    
    public class func registerAppWithID(ID: String) -> Bool {
        return WXApi.registerApp(ID)
    }
    
    public class func registerAppWithID(ID: String, description: String) -> Bool {
        return WXApi.registerApp(ID, withDescription: description)
    }
    
    private class func _sendRequestToScene(scene: MSRWeChatScene, object: AnyObject, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
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
        completion?(WXApi.sendReq(request))
    }
    
    private class func _sendResponseWithObject(object: AnyObject, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, completion: ((Bool) -> Void)?) {
        let message = WXMediaMessage()
        message.title = title
        message.description = description
        message.setThumbImage(thumbnailImage)
        message.mediaObject = object
        message.mediaTagName = tagName
        let response = GetMessageFromWXResp()
        response.bText = false
        response.message = message
        completion?(WXApi.sendResp(response))
    }

}

@objc public protocol MSRWeChatAPIDelegate {
    optional func msr_didReceiveMessageSendingRequestFromWeChat(openID: String)
    optional func msr_didReceiveImageMessagePresentingRequestFromWeChat(imageData: NSData?, imageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, openID: String, needsResponding: Bool)
    optional func msr_didReceiveMusicMessagePresentingRequestFromWeChat(musicDataURL: NSURL, lowBandMusicDataURL: NSURL?, musicWebpageURL: NSURL?, lowBandMusicWebPageURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, openID: String, needsResponding: Bool)
    optional func msr_didReceiveVideoMessagePresentingRequestFromWeChat(videoURL: NSURL, lowBandVideoURL: NSURL?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, openID: String, needsResponding: Bool)
    optional func msr_didReceiveWebpageMessagePresentingRequestFromWeChat(webpageURL: NSURL, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, openID: String, needsResponding: Bool)
    optional func msr_didReceiveApplicationDefinedMessagePresentingRequestFromWeChat(applicationDefinedInformations: String, applicationDownloadURL: NSURL?, fileData: NSData?, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, openID: String, needsResponding: Bool)
    optional func msr_didReceiveEmoticonMessagePresentingRequestFromWeChat(emoticonData: NSData, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, openID: String, needsResponding: Bool)
    optional func msr_didReceiveFileMessagePresentingRequestFromWeChat(fileData: NSData, fileExtensionName: String, title: String?, description: String?, thumbnailImage: UIImage?, tagName: String?, extraMessage: String?, action: String?, openID: String, needsResponding: Bool)
    optional func msr_didReceiveMessageSendingResponseFromWeChat(errorCode: MSRWeChatErrorCode, errorString: String?)
    optional func msr_didReceiveAuthorizationResponseFromWeChat(errorCode: MSRWeChatErrorCode, errorString: String?, token: String?, mark: String?)
    optional func msr_didReceiveCardsAddingResponseFromWeChat(errorCode: MSRWeChatErrorCode, errorStrong: String?, cards: [MSRWeChatCard]?)
}

@objc public class MSRWeChatCard: NSObject {
    public var identifier: String = ""
    public var extraMessage: String = ""
    public var added: Bool = false
}

@objc class _MSRWeChatManager: NSObject, WXApiDelegate {
    
    weak var delegate: MSRWeChatAPIDelegate?
    
    func onReq(request: BaseReq!) {
        let openID = request.openID
        switch request {
        case is GetMessageFromWXReq:
            delegate?.msr_didReceiveMessageSendingRequestFromWeChat?(openID)
            break
        case let x where x is ShowMessageFromWXReq || x is LaunchFromWXReq:
            var message: WXMediaMessage!
            if let s = x as? ShowMessageFromWXReq {
                message = s.message
            } else {
                let l = x as! LaunchFromWXReq
                message = l.message
            }
            let title = message.title
            let description = message.description
            let thumbnailImage = UIImage(data: message.thumbData)
            let tagName = message.mediaTagName
            let extraMessage = message.messageExt
            let action = message.messageAction
            let object: AnyObject! = message.mediaObject
            let needsResponding = x is ShowMessageFromWXReq
            switch object {
            case let object as WXImageObject:
                delegate?.msr_didReceiveImageMessagePresentingRequestFromWeChat?(object.imageData, imageURL: object.imageUrl == nil ? nil : NSURL(string: object.imageUrl), title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, openID: openID, needsResponding: needsResponding)
                break
            case let object as WXMusicObject:
                delegate?.msr_didReceiveMusicMessagePresentingRequestFromWeChat?(NSURL(string: object.musicDataUrl)!, lowBandMusicDataURL: object.musicLowBandDataUrl == nil ? nil : NSURL(string: object.musicLowBandDataUrl), musicWebpageURL: object.musicUrl == nil ? nil : NSURL(string: object.musicUrl), lowBandMusicWebPageURL: object.musicLowBandUrl == nil ? nil : NSURL(string: object.musicLowBandUrl), title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, openID: openID, needsResponding: needsResponding)
                break
            case let object as WXVideoObject:
                delegate?.msr_didReceiveVideoMessagePresentingRequestFromWeChat?(NSURL(string: object.videoUrl)!, lowBandVideoURL: object.videoLowBandUrl == nil ? nil : NSURL(string: object.videoLowBandUrl), title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, openID: openID, needsResponding: needsResponding)
                break
            case let object as WXWebpageObject:
                delegate?.msr_didReceiveWebpageMessagePresentingRequestFromWeChat?(NSURL(string: object.webpageUrl)!, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, openID: openID, needsResponding: needsResponding)
                break
            case let object as WXAppExtendObject:
                delegate?.msr_didReceiveApplicationDefinedMessagePresentingRequestFromWeChat?(object.extInfo, applicationDownloadURL: object.url == nil ? nil : NSURL(string: object.url), fileData: object.fileData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, openID: openID, needsResponding: needsResponding)
                break
            case let object as WXEmoticonObject:
                delegate?.msr_didReceiveEmoticonMessagePresentingRequestFromWeChat?(object.emoticonData, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, openID: openID, needsResponding: needsResponding)
                break
            case let object as WXFileObject:
                delegate?.msr_didReceiveFileMessagePresentingRequestFromWeChat?(object.fileData, fileExtensionName: object.fileExtension, title: title, description: description, thumbnailImage: thumbnailImage, tagName: tagName, extraMessage: extraMessage, action: action, openID: openID, needsResponding: needsResponding)
                break
            default:
                break
            }
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
