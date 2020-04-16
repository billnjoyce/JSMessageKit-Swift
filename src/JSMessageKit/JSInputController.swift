//
//  JSInputController.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

class JSInputController: UIView
{
    private var baseHeight:CGFloat = 50
    
    private var background: UIImageView!
    private var textField: UITextField!
    private var buttonSend: UIButton!
    
    open var delegate: JSInputControllerDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        print("[JSInputController] init")
        
        background = UIImageView()
        background.image = UIImage.init(named: "message_you_round")
        self.addSubview(background)

        buttonSend = UIButton()
        buttonSend.setImage(UIImage.init(named: "send"), for: UIControl.State.normal)
        buttonSend.addTarget(self, action:#selector(self.pushSend), for: .touchUpInside)
        self.addSubview(buttonSend)
        //buttonSend.isHidden = true
        
        textField = UITextField()
        textField.addTarget(self, action: #selector(textFieldDidBegin(textField:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEnd(textField:)), for: .editingDidEnd)
        
        textField.textColor = UIColor.black
        textField.keyboardAppearance = UIKeyboardAppearance.dark;
        self.addSubview(textField)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /*background.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            background.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            background.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            background.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),*/
            
            background.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -80),
            textField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            
            buttonSend.widthAnchor.constraint(equalToConstant: 38),
            buttonSend.heightAnchor.constraint(equalToConstant: 36),
            buttonSend.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            buttonSend.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        addKeyboardObservers()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        print("[JSInputController] deinit")
        
        removeKeyboardObservers()
    }
    
    func addKeyboardObservers()
    {
        print("[JSInputController] addKeyboardObservers")
        
        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillShow:")), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillHide:")), name:UIResponder.keyboardWillHideNotification, object: nil);
    }

    func removeKeyboardObservers()
    {
        print("[JSInputController] removeKeyboardObservers")
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension JSInputController
{
    @objc
    func textFieldDidBegin(textField: UITextField)
    {
        print("textFieldDidBegin")
        
        //self.delegate?.startInputController()
    }
    
    @objc
    func textFieldDidChange(textField: UITextField)
    {
        print("textFieldDidChange")
        print(textField.text!)
    }
    
    @objc
    func textFieldDidEnd(textField: UITextField)
    {
        print("textFieldDidEnd")
        print(textField.text!)
        
        //textField.text = ""
        self.delegate?.endInputController(text: "")
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification)
    {
        //self.view.transform = .identity
        print("keyboardWillHide")
    }

    @objc
    func keyboardWillShow(_ notification: Notification)
    {
        print("keyboardWillShow")
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        baseHeight = keyboardHeight;
        
        self.delegate?.startInputController()
    }
    
    @objc
    public func finish()
    {
        self.delegate?.endInputController(text: textField.text!)
        textField.text = ""
        
        self.textField.resignFirstResponder()
    }
    
    @objc
    public func cancel()
    {
        self.textField.resignFirstResponder()
    }
    
    @objc
    public func pushSend(sender: UIButton!)
    {
        //finish()
        
        self.delegate?.updateInputController(text: textField.text!)
        textField.text = ""
    }
}

extension JSInputController
{
    public func getHeight() -> CGFloat
    {
        return baseHeight
    }
}

public protocol JSInputControllerDelegate : class
{
    func startInputController()
    func updateInputController(text:String)
    func endInputController(text:String)
}
