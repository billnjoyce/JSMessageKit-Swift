//
//  JSMessageText.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

class JSMessageText : JSMessageBase
{
    public var message: String
    
    public init(type:JSMessageType, message:String, sender:JSSender)
    {
        self.message = message
        super.init(type: type, sender: sender)
    }
    
    public init(id:String, type:JSMessageType, message:String, sender:JSSender)
    {
        self.message = message
        super.init(id: id, type: type, sender: sender)
    }
}
