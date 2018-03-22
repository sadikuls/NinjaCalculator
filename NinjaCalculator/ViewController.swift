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

    //clicked on any number button
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumebr += "\(sender.tag)"
        lblOutputTxgt.text = runningNumebr
    }
    
    //clicked on devide button
    @IBAction func devideButtonPressed(sender: UIButton){
        processOperation(operation: .Divide)
    }
    //clicked on add button
    @IBAction func addButtonPressed(sender: UIButton){
    
        processOperation(operation: .Add)
    }
    //clicked on substract button
    @IBAction func subButtonPressed(sender: UIButton){
        
        processOperation(operation: .Subtract)
        
    }
    //clicked on multiply button
    @IBAction func multiplyButtonPressed(sender: UIButton){
        
        processOperation(operation: .Multiply)
    }
    
    
    
    //handle click on equal button
    @IBAction func equalButtonPressed(sender: UIButton){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        //check if music is playing then stop it first
        if btnSound.isPlaying{
            btnSound.stop()
        }
        //play the music on button pressed
        btnSound.play()
    }
    
    
    //function that handle all operation in operational button pressed
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty{
            if runningNumebr != ""{
                //if running number not null then assign it to right value
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
            //if first time button pressed then if assigned to left hand and running number set to null
            leftValueStar = runningNumebr
            runningNumebr = ""
            
            //setting current operation if it pressed for the first time
            currentOperation = operation
        }
    }
}

