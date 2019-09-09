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
    var gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    @IBOutlet weak var forfitButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var cardView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func setupView() {
        createGradientLayer()
        navigationController?.isNavigationBarHidden = true
        currentPlayerLabel.text = currentPlayer
        forfitButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
        setMainText()
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 10
    }
    
    func createGradientLayer() {
        if buttonValue == "truths" {
            let color = UIColor(rgb: 0x35ea42)
            let color2 = UIColor(rgb: 0x055400)
            gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [color2.cgColor, color.cgColor, color2.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientView.layer.addSublayer(gradientLayer)
        } else {
            let color = UIColor(rgb: 0xa00109)
            let color2 = UIColor(rgb: 0xf20800)
            gradientLayer = CAGradientLayer()
            gradientLayer.frame = view.bounds
            gradientLayer.colors = [color2.cgColor, color.cgColor, color2.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientView.layer.addSublayer(gradientLayer)
        }
    }
    
    func setMainText() {
        if buttonValue == "truths" {
            titleLabel.text = "Truth"
            titleLabel.textColor = UIColor.green
            if truths.count == 0  {
                getData()
            }
            else  {
                let randInt = Int.random(in: 0..<truths.count)
                self.mainLabel.text =  truths[randInt]
                truths.remove(at: randInt)
            }
        }
        else {
            titleLabel.text = "Dare"
            titleLabel.textColor = UIColor.red
            if dares.count == 0  {
                getData()
            }
            else  {
                let randInt = Int.random(in: 0..<dares.count)
                self.mainLabel.text =  dares[randInt]
                dares.remove(at: randInt)
            }
        }
    }
    
    func getData() {
        if buttonValue == "dares" {
            DBService.getDares { (_dares) in
                dares = _dares
                let randInt = Int.random(in: 0..<dares.count)
                self.mainLabel.text =  dares[randInt]
                dares.remove(at: randInt)
            }
        }
        else {
            DBService.getTruths { (_truths) in
                truths = _truths
                let randInt = Int.random(in: 0..<truths.count)
                self.mainLabel.text =  truths[randInt]
                truths.remove(at: randInt)
            }
        }
    }
    
    
    @objc func backTapped() {
        buttonValue = ""
        var newScore = scores[currentPlayer]
        newScore = newScore! - 1
        scores[currentPlayer] = newScore!
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completeTapped() {
        buttonValue = ""
        var newScore = scores[currentPlayer]
        newScore = newScore! + 1
        scores[currentPlayer] = newScore!
        navigationController?.popViewController(animated: true)
    }

   
}
