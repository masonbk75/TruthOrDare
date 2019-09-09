//
//  ViewController.swift
//  truthOrDare
//
//  Created by Mason Kelly on 8/26/19.
//  Copyright © 2019 Mason Kelly. All rights reserved.
//

import UIKit
import Firebase

var buttonValue: String = "localChange"
var currentPlayer: String = ""

class ViewController: UIViewController {
    
    var gradientLayer = CAGradientLayer()
    var ref: DatabaseReference!
    @IBOutlet weak var truthButton: UIButton!
    @IBOutlet weak var dareButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var addTruthButton: UIButton!
    @IBOutlet weak var addDareButton: UIButton!
    @IBOutlet weak var restartGameButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var usedPlayers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if usedPlayers.count != 0 {
            mainLabel.text = "\(usedPlayers[0])'s turn!"
            currentPlayer = usedPlayers[0]
            usedPlayers.remove(at: 0)
        }
        else {
            setMainText()
        }
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        createGradientLayer()
        navigationController?.isNavigationBarHidden = true
        ref = Database.database().reference()
        truthButton.layer.cornerRadius = 14
        dareButton.layer.cornerRadius = 14
        addDareButton.layer.cornerRadius = 14
        addTruthButton.layer.cornerRadius = 14
        restartGameButton.layer.cornerRadius = 14
        addDareButton.layer.borderColor = UIColor.black.cgColor
        addDareButton.layer.borderWidth = 1.0
        addTruthButton.layer.borderWidth = 1.0
        restartGameButton.layer.borderWidth = 1.0
        addTruthButton.layer.borderColor = UIColor.black.cgColor
        restartGameButton.layer.borderColor = UIColor.black.cgColor
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 10
        tableView.backgroundColor = UIColor.clear

        restartGameButton.addTarget(self, action: #selector(restartGameTapped), for: .touchUpInside)
        addTruthButton.addTarget(self, action: #selector(addTruthTapped), for: .touchUpInside)
        addDareButton.addTarget(self, action: #selector(addDareTapped), for: .touchUpInside)
    }
    
    func createGradientLayer() {
        let color = UIColor(rgb: 0x00305b)
        let color2 = UIColor(rgb: 0x007dbc)
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color2.cgColor, color.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    func setMainText() {
        for key in scores.keys {
            usedPlayers.append(key)
        }        
        mainLabel.text = "\(usedPlayers[0])'s turn!"
        currentPlayer = usedPlayers[0]
        usedPlayers.remove(at: 0)
    }
    
    
    
    @IBAction func truthPreddes(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        buttonValue = "truths"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    @IBAction func darePressed(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        buttonValue = "dares"

        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func addTruthTapped() {
        createAlert(category: "truth")
    }
    
    
    @objc func addDareTapped() {
        createAlert(category: "dare")
    }
    
    
    func createAlert(category: String) {
        let alert = UIAlertController(title: "Add a \(category)!", message: "Please enter your custom \(category).", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add a \(category)"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print(textField!.text!)
            guard let newEntry = textField?.text else { return }
            if category == "truth" {
                DBService.saveTruth(value: newEntry)
            } else  {
                DBService.saveDare(value: newEntry)
            }
        }))
        alert.addAction((UIAlertAction(title: "Cancel", style: .cancel, handler: nil)))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func restartGameTapped() {
        buttonValue = ""
        scores = [String:Int]()
        players = [""]
        navigationController?.popViewController(animated: true)
    }

}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreBoardCell", for: indexPath) as! ScoreBoardCell
        let name = players[indexPath.row]
        let score = scores[name]
        cell.nameLabel.text = name
        cell.scoreLabel.text = String(score!)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
}


class ScoreBoardCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
