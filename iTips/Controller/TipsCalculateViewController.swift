//
//  ViewController.swift
//  iTips
//
//  Created by Илья Валито on 03.10.2021.
//

import UIKit

class TipsCalculateViewController: UIViewController {
    
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var tipsSlider: UISlider!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var personsLabel: UILabel!
    @IBOutlet weak var personsStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the keyboard, when touched anywhere else.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        billField.attributedPlaceholder = NSAttributedString(string: "e.g. 123.45", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6549019608, green: 0.6745098039, blue: 0.8235294118, alpha: 1)])
        
    }
    

    @IBAction func billFieldChanging(_ sender: UITextField) {
     
        billField.text = ""
    }
    
    @IBAction func tipsChanged(_ sender: UISlider) {
        
        // Hide the keyboard when tipsSlider is active.
        billField.endEditing(true)
        tipsLabel.text = "\(String(Int(tipsSlider.value))) %"
    }
    
    @IBAction func personsChanged(_ sender: UIStepper) {
        
        // Hide the keyboard when persoonsStepper is active.
        billField.endEditing(true)
        personsLabel.text = String(Int(personsStepper.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Set the ResultViewController as a destination for segue to transfer some data to it.
        let destinationVC = segue.destination as! ResultViewController
        
        // Replacing
        if let bill = Float((billField.text?.replacingOccurrences(of: ",", with: "."))!) {
            destinationVC.total = (bill * (1 + tipsSlider.value / 100)) / Float(Int(personsStepper.value))
            destinationVC.persons = Int(personsStepper.value)
            destinationVC.tips = Int(tipsSlider.value)
        } else {
            // Create the allert window.
            let alertController = UIAlertController(
                title: "You should enter a correct bill!",
                message: "e.g. 123.45",
                preferredStyle: .alert
            )
            // Create the "Ok" button.
            let actionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            // Add buttons to the alert controller window.
            alertController.addAction(actionOK)
         
            // Show alert window.
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

