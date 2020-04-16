//
//  JSChatViewController.swift
//  JSMessageKit
//
//  Created by Bill Kim on 4/15/20.
//  Copyright © 2020 Bill Kim. All rights reserved.
//

import UIKit

class JSChatViewController: UIViewController
{
    open var nameTextColor: UIColor = UIColor.white
    open var messageTextColor: UIColor = UIColor.white
    
    private var inputControl: JSInputController!
    private let tableView: UITableView = UITableView()
    
    private var me:JSSender?
    private var messages:[JSMessageBase] = []
    
    open var delegate: JSChatViewControllerDelegate?
    
    //fileprivate var heightAtIndexPath = [IndexPath:CGFloat]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        initView()
        
        guard #available(iOS 11.0, *) else { setupConstraints(); return }
        
        //updateData()
    }
    
    private func initView()
    {
        print("[JSChatViewController] init")
        
        self.view.backgroundColor = UIColor.black
        
        initTableView()
        initInputControl()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.view.addGestureRecognizer(gesture)
    }
    
    private func initTableView()
    {
        self.tableView.dataSource = self
        self.tableView.delegate = self
                
        self.view.addSubview(self.tableView)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
        
        tableView.allowsSelection = false
        //tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        
        registerCells()
    }
    
    private func initInputControl()
    {
        inputControl = JSInputController()
        inputControl.delegate = self;
        self.view.addSubview(inputControl)
        
        //inputControl.backgroundColor = UIColor.red
        inputControl.backgroundColor = UIColor.clear
    }
    
    private func registerCells()
    {
        self.tableView.register(JSMessageBaseCell.self, forCellReuseIdentifier: "cellBase")
        //self.tableView.register(JSMessageTextCell.self, forCellReuseIdentifier: "cellText")
        
        self.tableView.register(UINib(nibName: "JSMessageTextMeCell", bundle: nil), forCellReuseIdentifier: "JSMessageTextMeCell")
        self.tableView.register(UINib(nibName: "JSMessageTextYouCell", bundle: nil), forCellReuseIdentifier: "JSMessageTextYouCell")
    }
    
    override func viewSafeAreaInsetsDidChange()
    {
        setupConstraints()
    }
    
    private func setupConstraints()
    {
        var bottomPadding:CGFloat = 0
        
        if #available(iOS 11.0, *) {
            bottomPadding = CGFloat(self.view.safeAreaInsets.bottom)
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -50-bottomPadding))
        self.view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0))
     
        inputControl.translatesAutoresizingMaskIntoConstraints = false
        inputControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        inputControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        inputControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding).isActive = true
        inputControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer)
    {
        /*if (inputControl != nil)
        {
            inputControl?.finish()
        }*/
        
        inputControl.cancel()
    }
}

//MARK: JSChatViewController Public Interface

extension JSChatViewController
{
    open func setMe(sender:JSSender)
    {
        me = sender;
    }
    
    open func clear()
    {
        if(messages.count > 0)
        {
            messages.removeAll()
        }
        
        tableView.reloadData()
    }
    
    open func removeMessage(at: Int)
    {
        if(messages.count <= 0) { return }
        else if(messages.count <= at) { return }
        
        messages.remove(at: at)
        
        tableView.reloadData()
    }
    
    open func addMessage(type:JSMessageType, message:String, sender:JSSender)
    {
        if(type == JSMessageType.typeText)
        {
            let msg:JSMessageText = JSMessageText.init(type:type, message:message, sender:sender)
            
            messages.append(msg)
        }
        else
        {
            
        }
        
        tableView.reloadData()
        
        if(self.messages.count <= 0) { return }
        
        DispatchQueue.main.async {
            let endIndex = IndexPath(row: self.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
        }
    }
}

extension JSChatViewController: JSInputControllerDelegate
{
    func startInputController()
    {
        var bottomPadding:CGFloat = 0
        
        if #available(iOS 11.0, *) {
            //let window = UIApplication.shared.keyWindow
            //let topPadding = window?.safeAreaInsets.top
            bottomPadding = CGFloat(self.view.safeAreaInsets.bottom)
        }
     
        DispatchQueue.main.async {
            let endIndex = IndexPath(row: self.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
        }
        
        self.view.transform = CGAffineTransform(translationX: 0, y: -inputControl.getHeight()+bottomPadding)
    }
    
    func updateInputController(text:String)
    {
        if(text.count > 0)
        {
            addMessage(type: JSMessageType.typeText, message: text, sender:me!)
        }
    }
    
    func endInputController(text:String)
    {
        if(text.count > 0)
        {
            addMessage(type: JSMessageType.typeText, message: text, sender:me!)
        }
        
        self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        //self.inputControl.transform = CGAffineTransform(translationX: 0, y: 0)
    }
}

extension JSChatViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print(items[indexPath.row])
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        inputControl.cancel()
    }
}

extension JSChatViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return self.items.count
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(messages[indexPath.row].type == JSMessageType.typeText)
        {
            let message:JSMessageText = messages[indexPath.row] as! JSMessageText
         
            if(me!.id == message.sender.id)
            {
                let cell:JSMessageTextMeCell = tableView.dequeueReusableCell(withIdentifier: "JSMessageTextMeCell", for: indexPath) as! JSMessageTextMeCell
                
                if(messages.count > 1 && indexPath.row > 0)
                {
                    cell.setData(message: message, prev:messages[indexPath.row-1] as! JSMessageText)
                }
                else
                {
                    cell.setData(message: message)
                }
                
                return cell
            }
            else
            {
                let cell:JSMessageTextYouCell = tableView.dequeueReusableCell(withIdentifier: "JSMessageTextYouCell", for: indexPath) as! JSMessageTextYouCell
                
                if(messages.count > 1 && indexPath.row > 0)
                {
                    cell.setData(message: message, prev:messages[indexPath.row-1] as! JSMessageText)
                }
                else
                {
                    cell.setData(message: message)
                }
                
                return cell
            }
        }
        else if(messages[indexPath.row].type == JSMessageType.typeImage)
        {
            
        }

        return tableView.dequeueReusableCell(withIdentifier: "cellBase")!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /*if let height = self.heightAtIndexPath[indexPath]
        {
            return height + 100
        }
        else
        {
            return UITableView.automaticDimension
        }*/
        
        return UITableView.automaticDimension
    }
    
    @objc(tableView:estimatedHeightForRowAtIndexPath:)
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        /*if let height = self.heightAtIndexPath[indexPath]
        {
            return height
        }
        else
        {
            return UITableView.automaticDimension
        }*/
        
        return UITableView.automaticDimension
    }
}

public protocol JSChatViewControllerDelegate : class
{
    // Set delegate mothod here.
}
