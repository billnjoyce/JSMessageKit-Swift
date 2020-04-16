//
//  JSExtensions.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

extension Date {
    
    func dateFormatFromString(_ format: String) -> String
    {
        let formatter = DateFormatter()
        let language = Bundle.main.preferredLocalizations.first! as String
        formatter.locale = Locale(identifier: language)
        formatter.dateFormat = format;
        return formatter.string(from: self)
    }
}
