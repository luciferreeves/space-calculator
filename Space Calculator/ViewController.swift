//
//  ViewController.swift
//  Space Calculator
//
//  Created by Lucifer Conrad Reeves on 07/07/18.
//  Copyright © 2018 Lucifer Reeves. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    enum Operation:String {
        case Divide = "/"
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Empty = "Empty"
    }
    var runningNumber = ""
    var left = ""
    var right = ""
    var currentOperation = Operation.Empty;
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
    }
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: Any) {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: Any) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onAddPressed(sender: Any) {
        processOperation(operation: .Add)
    }
    @IBAction func onSubractPressed(sender: Any) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onEqualPressed(sender: Any){
        processOperation(operation: currentOperation)
    }
    @IBAction func onClearPressed(sender: Any) {
        playSound()
        result = ""
        left = ""
        right = ""
        runningNumber = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation:Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                right = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Divide {
                    result = "\(Double(left)! / Double(right)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(left)! - Double(right)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(left)! * Double(right)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(left)! + Double(right)!)"
                }
                left = result
                outputLbl.text = result
            }
            currentOperation = operation
        } else {
            left = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

