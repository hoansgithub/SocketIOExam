//
//  UIViewExt.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/26/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
extension UIView {
    func addConstraints(withVisualFormat format: String, views : UIView...) -> [NSLayoutConstraint] {
        
        var mViews = [String : UIView]()
        for (key, val) in views.enumerated() {
            let key = "v\(key)";
            mViews[key] = val
            val.translatesAutoresizingMaskIntoConstraints = false
        }
        let constrants = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: mViews)
        self.addConstraints(constrants)
        
        return constrants
    }
}
