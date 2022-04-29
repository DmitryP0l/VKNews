//
//  AuthService.swift
//  VKNews
//
//  Created by lion on 29.04.22.
//

import Foundation
import VK_ios_sdk

class AuthService: NSObject {
    
    private let appId = "8151944"
    private var vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
}

//MARK: -  VKSdkDelegate, VKSdkUIDelegate
extension AuthService:  VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    
}
