//
//  Message.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/28/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import Foundation
import CoreData

@objc(Message)
public class Message: HManagedObject {
    override static func getEntityName() -> String {
        return "Message"
    }

}

extension Message {
    @NSManaged public var time: TimeInterval
    @NSManaged public var text: String?
    @NSManaged public var conversation : Conversation?
    @NSManaged public var owner : Friend?
}
