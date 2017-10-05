//
//  NSManagedObjectExt.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/27/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import Foundation
import CoreData
protocol HManagedObjectProtocol:class {
    static func getEntityName() -> String
}

extension HManagedObjectProtocol where Self:HManagedObject {
    static func getFetchRequest<T:HManagedObject>() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: self.getEntityName())
    }
    
    static func getEntity(_ context : NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.getEntityName(), in: context)
    }
}

public class HManagedObject : NSManagedObject, HManagedObjectProtocol {
    class func getEntityName() -> String {
        return ""
    }
}
