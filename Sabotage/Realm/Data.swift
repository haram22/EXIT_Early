//
//  Data.swift
//  Sabotage
//
//  Created by 김하람 on 10/22/24.
//

import Foundation
import UIKit
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var part: String = ""
}
