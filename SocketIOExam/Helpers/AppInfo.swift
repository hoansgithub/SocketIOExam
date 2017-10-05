//
//  AppInfo.swift
//  SocketIOExam
//
//  Created by Hoan Nguyen on 9/29/17.
//  Copyright © 2017 Hoan Nguyen. All rights reserved.
//

import Foundation
import CoreData
import UIKit
let windowSize : CGSize = {
    return UIScreen.main.bounds.size
}()
class AppInfo {
    static let shared = AppInfo()
    private init() {}
    var currentUser : Friend?

}
