//
//  ViewController.swift
//  Catch the Fosu
//
//  Created by Fizza Hagverdizade on 07.01.22.
//

import UIKit

class ViewController: UIViewController {

    //variables
    
    var timer = Timer() //Our variable for the timer
    var hideTimer = Timer()
    var counter = 0 //This is the variable for the counter
    var score = 0
    var highscore = 0
    var PictureTimer = Timer()
    var fosuArray = [UIImageView]()
   
    
    //views
    @IBOutlet weak var timeLabel: UILabel! //All below comes from Main Storyboard
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighScorelabel: UILabel!
    @IBOutlet weak var Fosu1: UIImageView!
    @IBOutlet weak var Fosu2: UIImageView!
    @IBOutlet weak var Fosu3: UIImageView!
    @IBOutlet weak var Fosu4: UIImageView!
    @IBOutlet weak var Fosu5: UIImageView!
    @IBOutlet weak var Fosu6: UIImageView!
    @IBOutlet weak var Fosu7: UIImageView!
    @IBOutlet weak var Fosu8: UIImageView!
    @IBOutlet weak var Fosu9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let registeredScore = UserDefaults.standard.object(forKey: "highscore")
        
        if registeredScore == nil {
            highscore = 0
            HighScorelabel.text = "Highscore :\(highscore)"
            
        }
        
        if let newScore = registeredScore as? Int {
            highscore = newScore
            HighScorelabel.text = "Highscore: \(highscore)"
        }
        
        counter = 30 //Here we state that our timer is equal to 30
        timeLabel.text = String(counter) //We write it for the person who plays the game
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true) //This will make the timer work
        
        PictureTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFosu), userInfo: nil, repeats: true)
       
        
        //pictures
        
        Fosu1.isUserInteractionEnabled = true
        Fosu2.isUserInteractionEnabled = true
        Fosu3.isUserInteractionEnabled = true
        Fosu4.isUserInteractionEnabled = true
        Fosu5.isUserInteractionEnabled = true
        Fosu6.isUserInteractionEnabled = true
        Fosu7.isUserInteractionEnabled = true
        Fosu8.isUserInteractionEnabled = true
        Fosu9.isUserInteractionEnabled = true //These are photos that will have interaction. If we do not write it, it won't interact.
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        Fosu1.addGestureRecognizer(recognizer1)
        Fosu2.addGestureRecognizer(recognizer2)
        Fosu3.addGestureRecognizer(recognizer3)
        Fosu4.addGestureRecognizer(recognizer4)
        Fosu5.addGestureRecognizer(recognizer5)
        Fosu6.addGestureRecognizer(recognizer6)
        Fosu7.addGestureRecognizer(recognizer7)
        Fosu8.addGestureRecognizer(recognizer8)
        Fosu9.addGestureRecognizer(recognizer9)
        
        fosuArray = [Fosu1, Fosu2, Fosu3, Fosu4, Fosu5, Fosu6, Fosu7, Fosu8, Fosu9]
        hideFosu()
        
    }
    
    @objc func hideFosu () {
        
        for Fosu in fosuArray {
            Fosu.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(fosuArray.count) - 1))//Random
        fosuArray[random].isHidden = false
        
    }
    
    @objc func increaseScore () {
        score += 1
        ScoreLabel.text = "Score: \(score)"
        
        print("You catched FOSU!")
    }

    @objc func countDown () { //We must add Objective C (@objc)
        counter -= 1 //With this we command that the counter must go always -1
        timeLabel.text = String(counter) //This will show seconds as decreasing
        
        if counter == 0 {
            print("Time is over!") //Here we command that if our counter is equal to 0, will be written - Time is over!
            timer.invalidate() //If we do not write this here, then timer will go eternal.
            hideTimer.invalidate()
            
            for Fosu in fosuArray {
                Fosu.isHidden = true
            }
            
            if self.score > self.highscore {
                self.highscore = self.score
                HighScorelabel.text = "High Score: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "Highscore")
            }
            
            let alert = UIAlertController(title: "Time is up!", message: "Wanna play again?", preferredStyle: .alert)
            
            let buttonok = UIAlertAction(title: "OK!", style: .cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
                
                self.score = 0
                self.ScoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true) //This will make the timer work
                
                self.PictureTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFosu), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(buttonok)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}

