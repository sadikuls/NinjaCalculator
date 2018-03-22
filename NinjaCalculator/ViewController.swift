//
//  ViewController.swift
//  NinjaCalculator
//
//  Created by Sadikul Bari on 21/3/18.
//  Copyright © 2018 Sadikul Bari. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var lblOutputTxgt: UILabel!
    
    enum  Operation: String {
        case Divide = "/"
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Equal = "="
        case Empty = "Empty"
    }
    var btnSound: AVAudioPlayer!
    var currentOperation = Operation.Empty
    
    var runningNumebr = ""
    var leftValueStar = ""
    var rightValStar = ""
    var resultValStar = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumebr += "\(sender.tag)"
        lblOutputTxgt.text = runningNumebr
        
        
    }
    
    @IBAction func devideButtonPressed(sender: UIButton){
        processOperation(operation: .Divide)
    }
    
    @IBAction func addButtonPressed(sender: UIButton){
    
        processOperation(operation: .Add)
    }
    
    @IBAction func subButtonPressed(sender: UIButton){
        
        processOperation(operation: .Subtract)
        
    }
    
    @IBAction func multiplyButtonPressed(sender: UIButton){
        
        processOperation(operation: .Multiply)
    }
    
    
    
    @IBAction func equalButtonPressed(sender: UIButton){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty{
            if runningNumebr != ""{
                rightValStar = runningNumebr;
                runningNumebr = ""
                if currentOperation == Operation.Divide{
                    resultValStar = "\(Double(leftValueStar)! / Double(rightValStar)!)"
                }else if currentOperation == Operation.Multiply{
                    resultValStar = "\(Double(leftValueStar)! * Double(rightValStar)!)"
                }else if currentOperation == Operation.Add{
                    resultValStar = "\(Double(leftValueStar)! + Double(rightValStar)!)"
                }else if currentOperation == Operation.Subtract{
                    resultValStar = "\(Double(leftValueStar)! - Double(rightValStar)!)"
                }
                
                leftValueStar = resultValStar
                lblOutputTxgt.text = resultValStar
            }
            currentOperation = operation
        }else{
            leftValueStar = runningNumebr
            runningNumebr = ""
            currentOperation = operation
        }
    }
}

