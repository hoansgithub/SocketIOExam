//
//  ConversationCollectionViewCell.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/26/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit


class ConversationCollectionViewCell: UICollectionViewCell {
    
    let containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    let imgAvatar : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "zuckprofile")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 34.0
        return img
    }()
    
    let viewSeparator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let lblName : UILabel = {
        let label = UILabel()
        label.text = "Mark Juggernaut"
        return label
    }()
    
    let lblTime : UILabel = {
        let label = UILabel()
        label.text = "12:00pm"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let lblMessage : UILabel = {
        let label = UILabel()
        label.text = "This message is a message from someone"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let imgHasReadMessage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "zuckprofile")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8.0
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.white
        addSubview(imgAvatar)
        addSubview(viewSeparator)
        
        _ = addConstraints(withVisualFormat: "V:[v0(68)]", views: imgAvatar)
        addConstraint(NSLayoutConstraint(item: imgAvatar, attribute: .centerY, relatedBy: .equal, toItem: self,
                                         attribute: .centerY, multiplier: 1.0, constant: 0.0))
        _ = addConstraints(withVisualFormat: "H:|-12-[v0(68)]-[v1]|", views: imgAvatar, viewSeparator)
        _ = addConstraints(withVisualFormat: "V:[v0(1)]|", views: viewSeparator)
        
    }
    
    func  setupContainerView() {
        addSubview(containerView)
        _ = addConstraints(withVisualFormat: "H:[v1]-12-[v0]|", views: containerView, imgAvatar)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        _ = addConstraints(withVisualFormat: "V:[v0(60)]", views: containerView)
        
        containerView.addSubview(lblName)
        containerView.addSubview(lblTime)
        containerView.addSubview(lblMessage)
        containerView.addSubview(imgHasReadMessage)
        _ = containerView.addConstraints(withVisualFormat: "H:|[v0]-12-[v1(80)]-12-|", views: lblName, lblTime)
        _ = containerView.addConstraints(withVisualFormat: "V:|[v0][v1(26)]|", views: lblName, lblMessage)
        _ = containerView.addConstraints(withVisualFormat: "V:|[v0(28)]-12-[v1(16)]", views: lblTime,imgHasReadMessage)
        _ = containerView.addConstraints(withVisualFormat: "H:|[v0]-8-[v1(16)]-12-|", views: lblMessage,imgHasReadMessage)
    }
}
