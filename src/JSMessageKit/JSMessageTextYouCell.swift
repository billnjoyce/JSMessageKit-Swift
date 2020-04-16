//
//  JSMessageTextYouCell.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

internal class JSMessageTextYouCell : JSMessageTextMeCell
{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var constraintForName: NSLayoutConstraint!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        self.profileImage.layer.cornerRadius = 21.5
        self.profileImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    override open func setData(message:JSMessageText)
    {
        super.setData(message: message)
        
        if(message.sender.photoUrl!.count > 0)
        {
            // Stub...
            // self.profileImage =
        }
        
        self.name.text = message.sender.name
    }
    
    override open func setData(message:JSMessageText, prev:JSMessageText)
    {
        super.setData(message: message)
        
        if(message.sender.photoUrl!.count > 0)
        {
            // Stub...
            // self.profileImage =
        }

        self.name.isHidden = (prev.sender.id == message.sender.id)
        self.profileImage.isHidden = (prev.sender.id == message.sender.id)
        
        if(prev.sender.id == message.sender.id)
        {
            constraintForName.constant = 0
        }
        else
        {
            constraintForName.constant = 30
        }
        
        self.name.text = message.sender.name
    }
}

