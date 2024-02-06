//
//  FirebaseDatabaseManager.swift
//  FireBase_SDK
//
//  Created by TFE-002 on 06/02/24.
//

import Foundation
import Firebase

class FirebaseDatabaseManager {
    
    static let shared = FirebaseDatabaseManager()
    private let database = Database.database().reference()
    
    // Write data to the database
    func writeData(newData: [String : Any]) {
//            newData = ["name": "John", "age": 30] as [String : Any]
        database.child("users").childByAutoId().setValue(newData) { error, _ in
            if let error = error {
                print("Failed to write data to the database: \(error)")
            } else {
                print("Data written successfully")
            }
        }
    }
    
    // Read data from the database
    func readData() {
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("No data available")
                return
            }
            print("Data from the database: \(value)")
        }
    }
}
