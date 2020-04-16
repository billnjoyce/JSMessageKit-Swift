//
//  JSMessageTextMeCell.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

internal class JSMessageTextMeCell : JSMessageBaseCell
{
    @IBOutlet weak var message: UILabel?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        let longPressed = UILongPressGestureRecognizer(target: self, action: #selector(longTap(sender:)))
        longPressed.delegate = self
        //self.message?.addGestureRecognizer(longPressed)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func longTap(sender : UIGestureRecognizer)
    {
        /*
        if(sender.state == .began)
        {
            print("UIGestureRecognizerStateBegan.")
            self.gestureTarget?.textLongPressed(cell: self)
        }
        else if(sender.state == .ended)
        {
            print("UIGestureRecognizerStateEnded")
        }*/
    }
    
    open func setData(message:JSMessageText)
    {
        self.message!.text = message.message
        self.messageTime.text = message.dates.dateFormatFromString("a h:mm")
    }
    
    open func setData(message:JSMessageText, prev:JSMessageText)
    {
        setData(message: message)
    }
}

