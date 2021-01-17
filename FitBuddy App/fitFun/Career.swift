//
//  File.swift
//  fitFun
//
//  Created by Araad Shams on 2021-01-16.
//

import UIKit

class Career : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Career: UITableView!
    
    var names = ["Abed Nadir", "Merryl Cherry", "Nathan Peng", "Promethius Hornet", "Sarah Simons", "Jason Xiao"]
    var scores = ["34-24", "11-17", "9-14", "21-4", "31-19", "23-34"]
    var types = ["Situps", "Pushups", "Pushups", "Squats", "Situps", "Squats"]
    var times = ["2:43", "1:02", "0:37", "1:25", "1:43", "3:21"]
    var dates = ["Jan. 17 2021", "Jan. 17 2021", "Jan. 16 2021","Jan. 16 2021","Jan. 16 2021","Jan. 16 2021"]
    var victory = [true, false, false, true, true, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Career.dataSource = self
        Career.delegate = self
        Career.register(UINib(nibName: "CareerCell", bundle: nil), forCellReuseIdentifier: "CareerCell")

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerCell", for: indexPath) as! CareerCell
        
        cell.Name.text! = names[indexPath.row]
        cell.Score.text! = scores[indexPath.row]
        cell.ExType.text! = types[indexPath.row]
        cell.Time.text! = times[indexPath.row]
        cell.Date.text! = dates[indexPath.row]
        if(victory[indexPath.row]) {
//            cell.Score.textColor = UIColor(red: 0.65098, green: 0.90588, blue: 0.69803, alpha: 1)
            cell.Score.textColor = UIColor.systemGreen
        }
        else {
//            cell.Score.textColor = UIColor(red: 0.85490, green: 0.49020, blue: 0.45098, alpha: 1)
            cell.Score.textColor = UIColor.systemRed

        }

        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    
}
