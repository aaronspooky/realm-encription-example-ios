//
//  ViewController.swift
//  RealmEncryptedData
//
//  Created by Aaron on 4/1/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import UIKit
import RealmSwift
import KeychainAccess

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let keychain = Keychain()
//        keychain["keyBase64"] = nil
        self.setupRealmEncryption()
    }

    private func setupRealmEncryption() {
        let keychain = Keychain()
        
        if try! keychain.getData("keyBase64") == nil  {
            var key = Data(count: 64)
            _ = key.withUnsafeMutableBytes({ (bytes) in
                SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
            })
            
            do {
                try keychain.set(key, key: "keyBase64")
            } catch let error {
                print(error)
            }
        }
        
        let token = try? keychain.getData("keyBase64")
        /// It's neccesary the key if we need to open the realm file
        print("Token in keychain \(token?.base64EncodedString() ?? "Empty")")
        
        guard let realm = try? Realm(configuration: Realm.Configuration(encryptionKey: token)) else {
            print("Realm has not been implemented")
            return
        }
        
        print("Realm has been implemented correclty")
        try! realm.write {
            realm.add(createDogObject(name: "Firulais", age: 10))
        }
        
        let results = realm.objects(Dog.self)
        print(results)
    }
    
    private func createDogObject(name: String, age: Int) -> Dog {
        let newDog = Dog()
        newDog.name = name
        newDog.age = age
        return newDog
    }
}

