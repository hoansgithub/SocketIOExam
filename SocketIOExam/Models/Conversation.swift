//
//  Conversation.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/28/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
@objc(Conversation)
public class Conversation: HManagedObject {
    override static func getEntityName() -> String {
        return "Conversation"
    }
}

extension Conversation {
    @NSManaged public var lastUpdate : TimeInterval
    @NSManaged public var messages : NSOrderedSet?
    @NSManaged public var paticipants : NSSet?
}
