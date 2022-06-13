//
//  ResultViewController.swift
//  iTips
//
//  Created by Илья Валито on 03.10.2021.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var total: Float?
    var persons: Int?
    var tips: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = String(format: "%.2f", total!)
        infoLabel.text = "Split between \(persons!) with \(tips!) % tips."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
