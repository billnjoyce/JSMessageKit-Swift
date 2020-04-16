//
//  ViewController.swift
//  JSMessageKit
//
//  Created by billkim on 16/04/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import UIKit

class ViewController: JSChatViewController {

    var senders:[JSSender] = [JSSender.init(id: "sender1", name: "Bill Kim", photoUrl: ""),
                              JSSender.init(id: "sender2", name: "Joyce Cai", photoUrl: "")]
    
    var message_template:[String] = ["This is a JSMessageKit sample.",
                                    "Nice to meet you",
                                    "This app is prototype version.",
                                    "blah... blah... blah... blah... blah... blah... blah... blah... blah... blah... blah... blah... blah... blah...",
                                    "What's your name?",
                                    "My name is Joyce Cai.",
                                    "I'm from Korea.",
                                    "Good Bye...",
                                    "See you again"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initControls()
        initMessageScheduler()
    }

    private func initControls()
    {
        self.delegate = self;
        
        nameTextColor = UIColor.white
        messageTextColor = UIColor.black
        
        setMe(sender: senders[0])
        
        addMessage(type: JSMessageType.typeText, message: "Hi", sender:senders[0])
        addMessage(type: JSMessageType.typeText, message: "My name is Bill Kim.", sender:senders[0])
        addMessage(type: JSMessageType.typeText, message: "Hello", sender:senders[1])
    }
    
    private func initMessageScheduler()
    {
        if #available(iOS 10.0, *)
        {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                let n = Int.random(in: 0...self.message_template.count)
                if(self.message_template.count <= n) { return }
                
                self.addMessage(type: JSMessageType.typeText, message: self.message_template[n], sender:self.senders[1])
            }
        }
    }
}

extension ViewController: JSChatViewControllerDelegate
{
    
}
