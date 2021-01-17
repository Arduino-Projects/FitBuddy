//
//  MainGame.swift
//  fitFun
//
//  Created by Araad Shams on 2021-01-16.
//

import UIKit
import CoreBluetooth

class MainGame : UIViewController, CBPeripheralDelegate {
    
    var exersize = ""
    var friendName =  ""
    
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblScoreOpp: UILabel!
    @IBOutlet weak var lblOppName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblBPM: UILabel!
    @IBOutlet weak var lblNiceMessage: UILabel!
    
    
    @IBOutlet weak var btnForfeitButton: RoundedButton!
    
    @IBOutlet weak var lblExcersizeType: UILabel!

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if going to signin screen, make sure it knows to do all necessary changes
        if segue.identifier == "results" {
            if let nextViewController = segue.destination as? Results {
                    nextViewController.friendName = friendName
                    nextViewController.score = score
                    nextViewController.scoreOpp = scoreOpp
            }
        }
    }
    
    
    var scoreOpp = 0
    var score = 0
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ViewController.peripheral.delegate = self
        lblTime.text = "0:00"
        var data = Data("C".utf8)

        if(exersize == "Pushup") {
            lblExcersizeType.text = "Push Ups"
            data = Data("P".utf8)
        }
        else if(exersize == "Situp") {
            lblExcersizeType.text = "Sit Ups"
            data = Data("S".utf8)
        }
        lblNiceMessage.text = ""
        lblOppName.text = friendName
        
        ViewController.peripheral.writeValue(data, for: ViewController.characteristic, type: .withoutResponse)
        
        _ = Timer.scheduledTimer(timeInterval: 2.7, target: self, selector: #selector(updateBPM), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 2.1, target: self, selector: #selector(updateOpp), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        score += 1
        lblScore.text = String(score)
    }
//
//    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
//        print(descriptor.value ?? ":(")
//    }
//
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    @IBAction func forfeitPressed(_ sender: Any) {
        var data = Data("F".utf8)
        ViewController.peripheral.writeValue(data, for: ViewController.characteristic, type: .withoutResponse)
        performSegue(withIdentifier: "results", sender: self)
    }
    
    
    @objc func updateTime() {
        seconds += 1
        
        let numSecs = seconds%60
        let numMins = (seconds - numSecs)/60
        
        lblTime.text = String(numMins) + ":" + (numSecs < 10 ? "0":"") + String(numSecs)
    }
    
    @objc func updateBPM() {
        lblBPM.text = String(Int.random(in: 86...94)) + " BPM"
    }
    
    @objc func updateOpp() {
        scoreOpp += 1
        lblScoreOpp.text = String(scoreOpp)
    }
    
}
