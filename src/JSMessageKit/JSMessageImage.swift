//
//  JSMessageImage.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

class JSMessageImage : JSMessageBase
{
    public var image: UIImage?
    
    public init(type:JSMessageType, imageNamed:String, sender:JSSender)
    {
        self.image = UIImage.init(named: imageNamed)
        super.init(type: type, sender: sender)
    }
    
    public init(type:JSMessageType, imageUrl:String, sender:JSSender)
    {
        // stub
        
        super.init(type: type, sender: sender)
    }
}
