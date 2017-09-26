//
//  ChatViewController.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/20/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var txtMessage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMessage.delegate  = self
        // Do any additional setup after loading the view.
    }


}

extension ChatViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            SocketIOManager.shared.sendMessage(message: text)
        }
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
