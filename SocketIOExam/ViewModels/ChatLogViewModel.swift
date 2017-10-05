//
//  ChatLogViewModel.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/29/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
import CoreData
class ChatLogViewModel: BaseViewModel {
    var conversationID : NSManagedObjectID?
    private var messages : [Message]?
    private var conversation : Conversation?
    func fetchData(finished : ()->()) {
        messages = []
        guard let objID = conversationID else {
            return
        }
        self.coreData.fetch(Conversation.self, query: "SELF = %@", params: [objID], sortDesc: nil) { [weak self] (error, results) in
            guard let weakSelf = self else {
                return
            }
            weakSelf.conversation = results.first
            weakSelf.messages = results.first?.messages?.array as? [Message]
           
            finished()
        }
    }
    
    func insertData(message : String, finished : ()->() ) {
        let newMessage = NSEntityDescription.insertNewObject(forEntityName: Message.getEntityName(), into: context) as! Message
        newMessage.text = message
        newMessage.conversation = conversation
        newMessage.time = Date().timeIntervalSinceNow
        newMessage.owner = AppInfo.shared.currentUser
        self.coreData.saveContext()
        messages?.append(newMessage)
        finished()
    }
    
    func getConversationTitle() -> String {
        guard let conversation = conversation else {
            return ""
        }
        let friendName = (conversation.paticipants?.allObjects as! [Friend]).filter({ (friend : Friend) -> Bool in
            return friend.name != AppInfo.shared.currentUser?.name
        }).first?.name
        return friendName ?? ""
    }
    
    func numberOfItems(inSection section : Int ) -> Int {
        let count = messages?.count ?? 0
        
        return count
    }
    
    func item(at indexPath : IndexPath) -> Message? {
        if indexPath.row < messages?.count ?? -1 {
            return messages![indexPath.row]
        }
        return nil
    }

    
    func configureCellFor(cell : MessageCollectionViewCell, message : Message) {
      //  cell.lblMessage.text = message.text
        
        // calculate cell height
        let messageSize = sizeForMessageText(message)
        if message.owner?.objectID != AppInfo.shared.currentUser?.objectID {
            cell.lblMessage.frame = CGRect(x: 0, y: 0, width: messageSize.width, height: messageSize.height)
            cell.lblMessage.textColor = UIColor.black
            cell.viewBubble.frame = CGRect(x: 43, y: 0, width: messageSize.width + 34, height: messageSize.height + 16)
            cell.imgViewBubble.image = MessageCollectionViewCell.imgBubbleGray
            cell.imgViewBubble.tintColor = UIColor(white: 0.95, alpha: 1)
            cell.imgViewProfile.isHidden = false
        }
        else {
            cell.lblMessage.frame = CGRect(x: 0, y: 0, width: messageSize.width, height: messageSize.height)
            cell.lblMessage.textColor = UIColor.white
            cell.viewBubble.frame = CGRect(x: windowSize.width - messageSize.width - 42, y: 0, width: messageSize.width + 34, height: messageSize.height + 16)
            cell.imgViewBubble.image = MessageCollectionViewCell.imgBubbleBlue
            cell.imgViewBubble.tintColor =  UIColor(red: 0, green: 137 / 255, blue: 249 / 255, alpha: 1)
            cell.imgViewProfile.isHidden = true
        }
        cell.lblMessage.text = message.text
        cell.lblMessage.center = cell.viewBubble.center
        
    }
    
    func sizeForItemAt(_ indexPath : IndexPath) -> CGSize {
        if let message = item(at: indexPath) {
            let messageSize = sizeForMessageText(message)
            return CGSize(width: windowSize.width, height: messageSize.height + 20)
        }
        return CGSize.zero
    }
    
    func sizeForMessageText(_ message : Message) -> CGSize {
        
        if let string = message.text {
            
            let size = CGSize(width : MessageCollectionViewCell.maxMessageBubbleWidth, height  : CGFloat.greatestFiniteMagnitude)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: string).boundingRect(with: size, options: options, attributes: [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
                ], context: nil)
            
            return CGSize(width: estimatedFrame.width,height: estimatedFrame.height)
        }
        return CGSize.zero
    }
    
    
}
