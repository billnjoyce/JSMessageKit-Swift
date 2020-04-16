//
//  JSSender.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

public class JSSender : JSBase
{
    public var id: String
    public var dates:Date
    
    var name:String?
    var photoUrl:String?
    
    public init(id:String, name:String, photoUrl:String)
    {
        self.id = id
        self.name = name
        
        self.photoUrl = photoUrl
        self.dates = Date()
    }
}
