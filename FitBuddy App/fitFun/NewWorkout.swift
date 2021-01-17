//
//  NewWorkout.swift
//  fitFun
//
//  Created by Araad Shams on 2021-01-16.
//

import UIKit

class NewWorkout : UIViewController {
    
    
    @IBOutlet weak var btnPushups: RoundedButton!
    @IBOutlet weak var btnSitups: RoundedButton!
    @IBOutlet weak var btnSquats: RoundedButton!
    @IBOutlet weak var btnBurpees: RoundedButton!
    @IBOutlet weak var btnPlank: RoundedButton!
    @IBOutlet weak var btnJJacks: RoundedButton!
    
    var exersizeType = "Pushup"
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if going to signin screen, make sure it knows to do all necessary changes
        if segue.identifier == "chooseFriend" {
            if let nextViewController = segue.destination as? chooseFriend {
                    nextViewController.otherVC = self
            }
        }
        
        if segue.identifier == "waitingForOpponent" {
            if let nextViewController = segue.destination as? WaitingForOpponent {
                    nextViewController.exersize = exersizeType
                    nextViewController.friendName = friendName
            }
        }
        
    }
    
    
    var friendName : String = ""
    @IBOutlet weak var btnAddFriend: RoundedButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func friendChosen() {
        if(friendName == "") {
            btnAddFriend.setTitle("Tap to Choose A Friend", for: .normal)
        }
        else {
            btnAddFriend.setTitle("Friend: " + friendName, for: .normal)
        }
    }
    
    
    @IBAction func btnChooseFriendPressed(_ sender: Any) {
        performSegue(withIdentifier: "chooseFriend", sender: self)
    }
    
    
    
    @IBAction func situpsPressed(_ sender: Any) {
        btnSitups.backgroundColor = UIColor.systemGreen
        btnPlank.backgroundColor = UIColor.link
        btnPushups.backgroundColor = UIColor.link
        btnBurpees.backgroundColor = UIColor.link
        btnSquats.backgroundColor = UIColor.link
        btnJJacks.backgroundColor = UIColor.link
        exersizeType = "Situp"
    }
    
    @IBAction func squatsPressed(_ sender: Any) {
        btnSitups.backgroundColor = UIColor.link
        btnPlank.backgroundColor = UIColor.link
        btnPushups.backgroundColor = UIColor.link
        btnBurpees.backgroundColor = UIColor.link
        btnSquats.backgroundColor = UIColor.systemGreen
        btnJJacks.backgroundColor = UIColor.link
        exersizeType = "Squat"
    }
    @IBAction func pushupPressed(_ sender: Any) {
        btnSitups.backgroundColor = UIColor.link
        btnPlank.backgroundColor = UIColor.link
        btnPushups.backgroundColor = UIColor.systemGreen
        btnBurpees.backgroundColor = UIColor.link
        btnSquats.backgroundColor = UIColor.link
        btnJJacks.backgroundColor = UIColor.link
        exersizeType = "Pushup"
    }
    @IBAction func burpeesPressed(_ sender: Any) {
        btnSitups.backgroundColor = UIColor.link
        btnPlank.backgroundColor = UIColor.link
        btnPushups.backgroundColor = UIColor.link
        btnBurpees.backgroundColor = UIColor.systemGreen
        btnSquats.backgroundColor = UIColor.link
        btnJJacks.backgroundColor = UIColor.link
        exersizeType = "Burpee"
    }
    @IBAction func plankPressed(_ sender: Any) {
        btnSitups.backgroundColor = UIColor.link
        btnPlank.backgroundColor = UIColor.systemGreen
        btnPushups.backgroundColor = UIColor.link
        btnBurpees.backgroundColor = UIColor.link
        btnSquats.backgroundColor = UIColor.link
        btnJJacks.backgroundColor = UIColor.link
        exersizeType = "Plank"
    }
    
    @IBAction func jjackPressed(_ sender: Any) {
        btnSitups.backgroundColor = UIColor.link
        btnPlank.backgroundColor = UIColor.link
        btnPushups.backgroundColor = UIColor.link
        btnBurpees.backgroundColor = UIColor.link
        btnSquats.backgroundColor = UIColor.link
        btnJJacks.backgroundColor = UIColor.systemGreen
        exersizeType = "JJack"
    }
    @IBAction func startPressed(_ sender: Any) {
            performSegue(withIdentifier: "waitingForOpponent", sender: self)
    }
}

