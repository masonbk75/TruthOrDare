//
//  ViewController.swift
//  truthOrDare
//
//  Created by Mason Kelly on 8/26/19.
//  Copyright © 2019 Mason Kelly. All rights reserved.
//

import UIKit
import Firebase

var buttonValue: String = "value"

class ViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var truthButton: UIButton!
    @IBOutlet weak var dareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        ref = Database.database().reference()
        truthButton.layer.cornerRadius = 14
        dareButton.layer.cornerRadius = 14
        
        let addTruthButton = UIBarButtonItem(title: "Add Truth", style: .plain, target: self, action: #selector(addTruthTapped))
        let addDareButton = UIBarButtonItem(title: "Add Dare", style: .plain, target: self, action: #selector(addDareTapped))
        navigationItem.rightBarButtonItem = addTruthButton
        navigationItem.leftBarButtonItem = addDareButton
    }
    
    
    @IBAction func truthPreddes(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        buttonValue = "truths"
        print(buttonValue)

        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    @IBAction func darePressed(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        buttonValue = "dares"
        print(buttonValue)

        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func addTruthTapped() {
        let alert = UIAlertController(title: "Add a Truth!", message: "Please enter your custom truth.", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add a truth"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print(textField!.text!)
            let newEntry = textField?.text!


        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func addDareTapped() {
        let alert = UIAlertController(title: "Add a Dare!", message: "Please enter your custom dare.", preferredStyle: .alert)
        alert.addTextField {  (textField) in
            textField.placeholder = "Add a dare"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {[weak alert] (_) in
            let  textField = alert?.textFields![0]
            print (textField!.text!)
            guard let newEntry = textField?.text else { return }
            DBService.saveDare(value: newEntry)
        }))
        alert.addAction((UIAlertAction(title: "Cancel", style: .cancel, handler: nil)))
        self.present(alert, animated: true, completion: nil)

    }
    
    
    func addData(category: String, data: String) {
        ref.child(category).childByAutoId().setValue(data)
    }

}

