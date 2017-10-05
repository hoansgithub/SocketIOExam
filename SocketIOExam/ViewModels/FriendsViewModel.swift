//
//  ConversationsViewModel.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/26/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit

class ConversationsViewModel: BaseViewModel {
    private(set) var conversations : [Conversation]?
    private(set) var friends : [Friend]?
    
    func fetchData(finished : ()->()) {
        friends = []
        conversations = []
        self.coreData.fetch( Friend.self ,
                             query: "",
                             params: [],
                             sortDesc: nil) { [weak self] (error, results) in
            guard let weakSelf = self else {
                return
            }
            
            if results.count == 0 {
                if let entityFriend = Friend.getEntity(weakSelf.context),
                    let entityConversation = Conversation.getEntity(weakSelf.context){
                    let friend1 = Friend(entity: entityFriend, insertInto: weakSelf.context)
                    friend1.name = "CODY"
                    friend1.profilePicture = "zuckprofile"
                    friend1.portID = SocketIOManager.shared.userID
                    
                    let friend2 = Friend(entity: entityFriend, insertInto: weakSelf.context)
                    friend2.name = "MARK SUCKS"
                    friend2.profilePicture = "steveprofile"
                    friend2.portID = 23845729
                    
                    let friend3 = Friend(entity: entityFriend, insertInto: weakSelf.context)
                    friend3.name = "Hillary"
                    friend3.profilePicture = "hillaryprofile"
                    friend3.portID = 24890234
                    
                    let friend4 = Friend(entity: entityFriend, insertInto: weakSelf.context)
                    friend4.name = "MARK @"
                    friend4.profilePicture = "zuckprofile"
                    friend4.portID = 37562830
                    //temp conversations
                    let conversation1 = Conversation(entity: entityConversation, insertInto: weakSelf.context)
                    conversation1.lastUpdate = Date().timeIntervalSince1970
                    conversation1.paticipants = [friend1, friend2]
                    let conversation2 = Conversation(entity: entityConversation, insertInto: weakSelf.context)
                    conversation2.lastUpdate = Date().timeIntervalSince1970
                    conversation2.paticipants = [friend1, friend3]
                    let conversation3 = Conversation(entity: entityConversation, insertInto: weakSelf.context)
                    conversation3.lastUpdate = Date().timeIntervalSince1970
                    conversation3.paticipants = [friend1, friend4]
                    
                    self?.friends = [friend1 , friend2,friend3, friend4]
                    self?.coreData.saveContext()
                }
            }
            else {
                self?.friends = results
            }
            
            
            // get temp profile
           if let temp = self?.friends?.first(where: {$0.name == "CODY"}) {
            AppInfo.shared.currentUser = temp
            self?.conversations = AppInfo.shared.currentUser?.paticipatedConversations?.allObjects as? [Conversation]
            }
                                
            self?.conversations?.sort(by: {$0.lastUpdate > $1.lastUpdate})
           
            
            finished()
        }
        
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
        
        if let friend = conversation.paticipants?.first(where: {($0 as! Friend).name != "CODY"}) as? Friend {
            
            cell.imgAvatar.image = UIImage(named : friend.profilePicture ?? "")
            cell.imgHasReadMessage.image = UIImage(named : "zuckprofile")
            
            //message
            if let message = conversation.messages?.lastObject as? Message {
                cell.lblMessage.text = message.text
            }
            else {
                cell.lblMessage.text = ""
            }
            
            let date = Date(timeIntervalSinceReferenceDate: conversation.lastUpdate)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a";
            cell.lblTime.text = dateFormatter.string(from: date)
            cell.lblName.text = friend.name ?? "Unknown"
        }
        
        
    }
    
}
