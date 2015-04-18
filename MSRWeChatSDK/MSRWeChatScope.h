//
//  MSRWeChatScope.h
//  MSRWeChatSDK
//
//  Created by Darren Liu on 15/4/18.
//  Copyright (c) 2015年 MsrLab. All rights reserved.
//

@import Foundation;

typedef NS_OPTIONS(NSUInteger, MSRWeChatScope) {
    MSRWeChatScopeBase = 1 << 0,
    MSRWeChatScopeContacts = 1 << 1,
    MSRWeChatScopeFriends = 1 << 2,
    MSRWeChatScopeMessage = 1 << 3,
    MSRWeChatScopeSNS = 1 << 4,
    MSRWeChatScopeTimeLine = 1 << 5,
    MSRWeChatScopeUserInfo = 1 << 6
};
