//
//  ActionModelData.swift
//  Sabotage
//
//  Created by 김하람 on 10/22/24.
//

import Foundation
import UIKit
import RealmSwift

class ActionData: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var category: String = ""
    @objc dynamic var content: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

