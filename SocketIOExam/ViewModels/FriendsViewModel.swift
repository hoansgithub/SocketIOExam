//
//  ConversationsViewModel.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/26/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class ConversationsViewModel: NSObject {
    private(set) var conversations : [Conversation]?
    
    func fetchData(finished : ()->()) {
        let friend1 = Friend()
        friend1.name = "Ding ding doong"
        friend1.profileImageName = "zuckprofile"
        let conversation1 = Conversation()
        conversation1.friend = friend1
        conversation1.text = "Dude please pick up my bae at 5 o'clock"
        conversation1.timestamp = Date().timeIntervalSince1970
        
        let friend2 = Friend()
        friend2.name = "Duddle dudling Duck"
        friend2.profileImageName = "zuckprofile"
        let conversation2 = Conversation()
        conversation2.friend = friend2
        conversation2.text = "Those craps in front of our house need to be cleaned"
        conversation2.timestamp = Date().timeIntervalSince1970
        
        finished()
        
    }
    
    func numberOfItems(inSection section : Int ) -> Int {
        return conversations?.count ?? 0
    }
    
    func item(at indexPath : IndexPath) -> Conversation? {
        if indexPath.row < conversations?.count ?? -1 {
            return conversations![indexPath.row]
        }
        return nil
    }
    
    func configureCellFor(cell : ConversationCollectionViewCell, conversation : Conversation) {
        cell.imgAvatar.image = UIImage(named : conversation.friend?.profileImageName ?? "")
        cell.imgHasReadMessage.image = UIImage(named : "zuckprofile")
        cell.lblMessage.text = conversation.text
        
        let date = Date(timeIntervalSinceReferenceDate: conversation.timestamp
            ?? Date().timeIntervalSince1970)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a";
        cell.lblTime.text = dateFormatter.string(from: date)
        cell.lblName.text = conversation.friend?.name ?? "Unknown"
    }
    
}
