//
//  FirebaseTest.swift
//  SwiftUIStarterKitApp
//
//  Created by Matthew Lu on 10/14/23.
//  Copyright © 2023 NexThings. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class FirebaseTest: ObservableObject{
    
    private let ref = Database.database().reference()
    
    func checkExist(usaname: String){
        //self.ref.child("user").setValue(value)
        self.ref.child("UserProfiles").observeSingleEvent(of: .value, with: {snapshot in
            guard let value = snapshot.value as? [String: Any] else{
                return
            }
            var found: String = "ACCOUNT DOESN'T EXIST"
            for (username, attributes) in value {
                if (usaname == username) {
                    found = "ACCOUNT EXISTS!!!"
                    break
                }
                
            }
            print(found)
    
        })
        
        
    }
    
}
