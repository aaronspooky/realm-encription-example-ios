//
//  Dog.swift
//  RealmEncryptedData
//
//  Created by Aaron on 4/1/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import Foundation
import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}
