//
//  Home.swift
//  fitFun
//
//  Created by Araad Shams on 2021-01-16.
//

import UIKit

class Home : UIViewController {
    @IBOutlet weak var containerView: UIView!
    var circularView: CircularProgressView!

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var pushups: UILabel!
    @IBOutlet weak var situps: UILabel!
    @IBOutlet weak var squats: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circularView = CircularProgressView(frame: containerView.frame)
        circularView.center = containerView.center
        containerView.addSubview(circularView)
        let duration = 1    //Play with whatever value you want :]
        circularView.progressAnimation(duration: TimeInterval(duration))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    

}
