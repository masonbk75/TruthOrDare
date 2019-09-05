//
//  ResultViewController.swift
//  truthOrDare
//
//  Created by Mason Kelly on 8/26/19.
//  Copyright © 2019 Mason Kelly. All rights reserved.
//

import UIKit
import Firebase
// caching
// dont repeat question until empty
// connect ot firebase to get list of questions
// allow to add new questions

// pull
// push
// add
// deal conflict


// Gather the database server into 1 place -> you can change to another database if you want
// You can try firestore or backend api...
// design pattern

// Organize the db schema
// good scheams save performance and cost
// instagram or facebook colone: favrouite or dislike... // need more concern about schemas



var truths = [String]()
var dares = [String]()

class ResultViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = barButton
        
        if buttonValue == "truths" {
            titleLabel.text = "You Chose Truth!"
            if truths.count == 0  {
                getData()
            }
            else  {
                print("Truths:  \(truths)")
                let randInt = Int.random(in: 0..<truths.count)
                self.mainLabel.text =  truths[randInt]
                truths.remove(at: randInt)
            }
        }
        else {
            titleLabel.text = "You Chose Dare!"
            if dares.count == 0  {
                getData()
            }
            else  {
                print("dares:  \(dares)")
                let randInt = Int.random(in: 0..<dares.count)
                self.mainLabel.text =  dares[randInt]
                dares.remove(at: randInt)
            }
        }
    }
    
    var usedDares = [String]()
    func getData() {
        if buttonValue == "dares" {
            DBService.getDares { (_dares) in
                dares = _dares
                let randInt = Int.random(in: 0..<dares.count)
                self.mainLabel.text =  dares[randInt]
                dares.remove(at: randInt)
            }
        }
        
        
//        var questions = [String]()
//        ref = Database.database().reference()
//        ref.child(buttonValue).observeSingleEvent(of: .value, with: { (snapshot) in
//            let values = snapshot.value as! NSDictionary
//            for keys in values {
//                questions.append(keys.value as! String)
//            }
//            print(questions)
//            let randInt = Int.random(in: 0..<questions.count)
//            self.mainLabel.text =  questions[randInt]
//            questions.remove(at: randInt)
//            if buttonValue == "truths" {
//                truths = questions
//            } else {
//                dares = questions
//            }
//
//        }) { (error) in
//            print(error.localizedDescription)
//        }
    }
    
    
    
    @objc func backTapped() {
        buttonValue = ""
        navigationController?.popViewController(animated: true)
    }

   

}
