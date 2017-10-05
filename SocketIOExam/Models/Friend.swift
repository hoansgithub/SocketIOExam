//
//  Friend.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/28/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

@objc(Friend)
public class Friend: HManagedObject {
    override static func getEntityName() -> String {
        return "Friend"
    }
}

extension Friend {
    @NSManaged public var name : String?
    @NSManaged public var profilePicture : String?
    @NSManaged public var ownedMessages : NSSet?
    @NSManaged public var paticipatedConversations : NSSet?
    @NSManaged public var portID : Int32
}
