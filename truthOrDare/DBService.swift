//
//  DBService.swift
//  truthOrDare
//
//  Created by Mason Kelly on 9/5/19.
//  Copyright © 2019 Mason Kelly. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {
    enum Node: String {
        case dares
        case truths
    }
    
    static func getDares(completion: @escaping([String]) -> Void) {
        getData(node: Node.dares, completion: completion)
    }
    
    static func getTruth(completion: @escaping([String]) -> Void) {
        getData(node: .truths, completion: completion)
    }
    
    private static func getData(node: Node, completion: @escaping([String]) -> Void) {
        Database.database().reference()
            .child(node.rawValue)
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let data = snapshot.value as? [String: String] else {
                    completion([])
                    return
                }
                
                completion(Array(data.values))
        }
    }
    
    
    static func saveDare(value: String) {
        saveData(node: .dares, value: value)
    }
    
    private static func saveData(node: Node, value: String) {
        Database.database().reference()
            .child(node.rawValue)
            .childByAutoId().setValue(value)
    }
    
}


