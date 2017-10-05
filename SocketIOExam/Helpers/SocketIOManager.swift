//
//  SocketIOManager.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/21/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
import SocketIO
class SocketIOManager: NSObject {
    static let shared  = SocketIOManager()
    let userID : Int32 = 37562834
    private var socket : SocketIOClient?
    private override init() {
        if let url = URL(string: "http://10.10.253.105:3000") {
            let config = SocketIOClientConfiguration(arrayLiteral: .connectParams(["userID" : userID]))
            self.socket =  SocketIOClient(socketURL: url, config: config)
        }
    }
    
    func establishConnection() {
        socket?.on("messageTo" + String(userID), callback: { (data, ack) in
            if let dic = data.first as? [String : Any] {
                if let msg = dic["message"] {
                    print(msg)
                }
            }
        })
        socket?.connect()
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
    
    func sendMessage(message : String) {
       socket?.emitWithAck("messageToServer", with: [[
            "userID" : userID,
            "message" : message,
            "toUserID" : 37562830
        ]]).timingOut(after: 5, callback: { (data) in
                print(data)
        })
    }
}
