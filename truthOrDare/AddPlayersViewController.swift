//
//  AddPlayersViewController.swift
//  truthOrDare
//
//  Created by Mason Kelly on 9/5/19.
//  Copyright © 2019 Mason Kelly. All rights reserved.
//

import UIKit

var scores = [String: Int]()
var players = [String]()

class AddPlayersViewController: UIViewController {
    
    var gradientLayer = CAGradientLayer()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    func setupView() {
        navigationController?.isNavigationBarHidden = true
        createGradientLayer()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        playButton.layer.cornerRadius = 14
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
    
    
    @IBAction func addPlayerPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add a player!", message: "Please enter the new player's name.", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.textContentType = .name
            textField.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            guard let newEntry = textField?.text else { return }
            scores[newEntry] = 0
            players.append(newEntry)
            self.tableView.reloadData()
        }))
        alert.addAction((UIAlertAction(title: "Cancel", style: .cancel, handler: nil)))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    

}






extension AddPlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddPlayerCell", for: indexPath) as! AddPlayerCell
        cell.nameLabel.text = players[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
}



class AddPlayerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}




