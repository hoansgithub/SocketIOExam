//
//  MessageCollectionViewCell.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/29/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    static let maxMessageBubbleWidth : CGFloat = {
        return windowSize.width - 100
    }()
    
    let lblMessage : UILabel = {
        let label = UILabel()
        label.text = "This message is a message from someone"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let viewBubble : UIView = {
        let view = UIView()
        return view
    }()
    
    let imgViewProfile : UIImageView = {
        let imgView = UIImageView(image: UIImage(named : "zuckprofile"))
        imgView.layer.cornerRadius = 17
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    static let imgBubbleGray : UIImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let imgBubbleBlue = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    let imgViewBubble : UIImageView = {
        let imgView = UIImageView()
        imgView.image = MessageCollectionViewCell.imgBubbleGray
        imgView.tintColor = UIColor(white: 0.95, alpha: 1)
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        addSubview(viewBubble)
        addSubview(lblMessage)
        addSubview(imgViewProfile)
        _ = addConstraints(withVisualFormat: "H:|-8-[v0(34)]", views: imgViewProfile)
        _ = addConstraints(withVisualFormat: "V:[v0(34)]-8-|", views: imgViewProfile)
        
        viewBubble.addSubview(imgViewBubble)
        _ = viewBubble.addConstraints(withVisualFormat: "H:|[v0]|", views: imgViewBubble)
        _ = viewBubble.addConstraints(withVisualFormat: "V:|[v0]|", views: imgViewBubble)
    }
    

}
