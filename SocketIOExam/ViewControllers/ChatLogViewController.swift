//
//  ChatLogViewController.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/29/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
import CoreData


class ChatLogViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    private let reuseIdentifier = "MessageCollectionViewCell"
    var conversationID : NSManagedObjectID?
    private let chatLogViewModel = ChatLogViewModel()
    
    private var viewInputContainer : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private var tfMessageInput : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your message ..."
        return tf
    }()
    
    private var btnSend : UIButton = {
        let btn = UIButton()
        btn.setTitle("Send", for: .normal)
        let color = UIColor(red: 0, green: 137 / 255, blue: 249 / 255, alpha: 1)
        btn.setTitleColor(color, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(ChatLogViewController.didTouchBtnSend), for: .touchUpInside)
        return btn
    }()
    
    private var viewInputSeparator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 1)
        return view
    }()
    
    @objc private func didTouchBtnSend() {
        if let text = tfMessageInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if text.characters.count > 0 {
                chatLogViewModel.insertData(message: text,  finished: { [weak self] in
                    DispatchQueue.main.async { [weak self] in
                        
                        guard let weakSelf = self else {
                            return
                        }
                        
                        weakSelf.tfMessageInput.text = ""
                        weakSelf.tfMessageInput.becomeFirstResponder()
                        let itemIndex = weakSelf.collectionView(weakSelf.collectionView!, numberOfItemsInSection: 0) - 1
                        if  itemIndex > -1 {
                            let insertionIndex = IndexPath(row: itemIndex, section: 0)
                            weakSelf.collectionView?.insertItems(at: [insertionIndex])
                            weakSelf.collectionView?.scrollToItem(at: insertionIndex, at: UICollectionViewScrollPosition.bottom, animated: true)
                        }
                        
                    }
                })
            }
        }
        
    }
    
    //MARK: -ViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 48, right: 0)
        
        guard let conversationID = conversationID else {
            return
        }
        chatLogViewModel.conversationID = conversationID
        chatLogViewModel.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView?.reloadData()
                self?.navigationItem.title = self?.chatLogViewModel.getConversationTitle()
            }
        }
        
        setupViewComponents()
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: -Keyboard
    
    private var csInputContainerBottom : NSLayoutConstraint!
    private var keyboardSpeed : Double?
    private var keyboardCurve : UInt?
    
    private func setupViewComponents() {
        view.addSubview(viewInputSeparator)
        view.addSubview(viewInputContainer)
        _ = view.addConstraints(withVisualFormat: "H:|[v0]|", views: viewInputSeparator)
        _ = view.addConstraints(withVisualFormat: "H:|[v0]|", views: viewInputContainer)
        _ = view.addConstraints(withVisualFormat: "V:[v0(0.5)][v1(48)]", views:viewInputSeparator, viewInputContainer)

        csInputContainerBottom = NSLayoutConstraint(item: viewInputContainer,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 0)
        view.addConstraint(csInputContainerBottom)
        viewInputContainer.addSubview(tfMessageInput)
        viewInputContainer.addSubview(btnSend)
        _ = viewInputContainer.addConstraints(withVisualFormat: "H:|-8-[v0][v1(40)]-8-|",
                                              views: tfMessageInput,btnSend)
        _ = viewInputContainer.addConstraints(withVisualFormat: "V:|[v0]|",
                                              views: tfMessageInput)
        _ = viewInputContainer.addConstraints(withVisualFormat: "V:|[v0]|",
                                              views: btnSend)
        
        //notification register
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardNotification(notification:)),
                                               name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardNotification(notification:)),
                                               name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardNotification(notification : Notification) {
        if let userInfo = notification.userInfo {
            keyboardSpeed = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double
            keyboardCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let keyboardShowing = (notification.name == Notification.Name.UIKeyboardWillShow)
            let distance = keyboardShowing ? (-(keyboardFrame!.height)) : 0
            
            self.csInputContainerBottom.constant = distance
            UIView.animate(withDuration: TimeInterval(keyboardSpeed ?? 0), delay: 0,
                           options: [UIViewAnimationOptions(rawValue : UInt(keyboardCurve ?? 0))],
                           animations: { [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: { [weak self] (completed) in
                guard let weakSelf = self else {
                    return
                }
                if keyboardShowing {
                    let itemIndex = weakSelf.collectionView(weakSelf.collectionView!, numberOfItemsInSection: 0) - 1
                    if  itemIndex > -1 {
                        let lastItemIndex = IndexPath(row: itemIndex, section: 0)
                        weakSelf.collectionView?.scrollToItem(at: lastItemIndex, at: UICollectionViewScrollPosition.bottom, animated: true)
                    }
                }
            })
        }
    }
    
    //MARK: -CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tfMessageInput.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCollectionViewCell
        if let item = chatLogViewModel.item(at: indexPath) {
            chatLogViewModel.configureCellFor(cell: cell, message: item)
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatLogViewModel.numberOfItems(inSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return chatLogViewModel.sizeForItemAt(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 38, right: 0)
    }
    
}
