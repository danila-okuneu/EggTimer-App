//
//  ViewController.swift
//  EggTimer
//
//  Created by Danila Okuneu on 26.07.23.
// Swift Marathon 8.0 x iOS & Swift - The Complete iOS App Development Bootcamp


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func harndessSelected(_ sender: UIButton) {
        timer.invalidate()
        secondsPassed = 0
        
        let hardness = sender.titleLabel!.text
        totalTime = eggTimes[hardness!]!
        
        mainLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsPassed <= totalTime {
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
            secondsPassed += 1
            if progressBar.progress == 1 {
                playSound("alarm_sound")
                mainLabel.text = "Your Egg is DONE!"
                progressBar.progress = 0
            }
        }
    }
    
    func playSound(_ name: String) {
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
