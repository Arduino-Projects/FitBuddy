//
//  Results.swift
//  fitFun
//
//  Created by Araad Shams on 2021-01-16.
//

import UIKit

class Results : UIViewController {
    var score = 0
    var scoreOpp = 0
    
    var friendName = ""
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblScoreOpp: UILabel!
    @IBOutlet weak var lblFriendName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblScore.text = String(score)
        lblScoreOpp.text = String(scoreOpp)
        lblFriendName.text = friendName
        lblMessage.text = (score >= scoreOpp ? "Great Job!" : "Nice Try!")
    }
    
    @IBAction func goHomePressed(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: self)
    }
    
}
