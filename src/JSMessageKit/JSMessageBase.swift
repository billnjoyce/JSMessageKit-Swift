//
//  JSMessageBase.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

public enum JSMessageType
{
    case typeText
    case typeImage
    case typeImoticon
}

public enum JSMessageStatus
{
    case statusFail
    case statusSuccess
    case statusSending
}

public class JSMessageBase : JSBase
{
    public var id: String
    public var dates:Date

    var isRead:Bool
    var type:JSMessageType
    var status:JSMessageStatus
    var sender:JSSender
    
    public init(type:JSMessageType, sender:JSSender)
    {
        self.dates = Date()
        self.id = String.init(format: "message-id-%.0f", NSDate().timeIntervalSince1970);
        
        self.type = type
        self.sender = sender
        
        status = JSMessageStatus.statusSending
        isRead = false
    }
    
    public init(id:String, type:JSMessageType, sender:JSSender)
    {
        self.id = id
        self.dates = Date()
        
        self.type = type
        self.sender = sender
        
        status = JSMessageStatus.statusSending
        isRead = false
    }
}
