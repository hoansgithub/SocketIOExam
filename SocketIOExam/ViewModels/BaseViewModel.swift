//
//  BaseViewModel.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/28/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import UIKit
import CoreData
class BaseViewModel: NSObject {
    lazy var coreData : CoreDataStack = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataStack
    }()
    lazy var context : NSManagedObjectContext = {
        return self.coreData.context
    }()
}

