//
//  Data.swift
//  Sabotage
//
//  Created by 김하람 on 10/22/24.
//

import Foundation
import UIKit
import RealmSwift

import RealmSwift

class CategoryItem: Object {
    @Persisted var categoryType: String = ""
    @Persisted var content: String = ""
    @Persisted var categoryImageName: String = ""
    
    @Persisted(primaryKey: true) var id: ObjectId
}
