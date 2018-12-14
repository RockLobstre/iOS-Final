//
//  ProfileViewController.swift
//  BMIapp
//
//  Created by Matin Salehi on 2018-12-13.
//  Copyright © 2018 Matin Salehi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    
    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
    
    @IBOutlet weak var metric: UISwitch!
    
    @IBOutlet weak var bmiShowText: UILabel!
    
    @IBAction func calculateBMI(_ sender: Any) {
        var result: Double = Double(weight.text!)! / Double(pow(Double(height.text!)!,2))
        bmiShowText.text = String(result)
    }
    
    @IBAction func savePageBMI(_ sender: Any) {
        UserDefaults.standard.setValue(name.text, forKey: "savedName")
        UserDefaults.standard.setValue(age.text, forKey: "savedAge")
        UserDefaults.standard.setValue(gender.text, forKey: "savedGender")
        UserDefaults.standard.setValue(weight.text, forKey: "savedWeight")
        UserDefaults.standard.setValue(height.text, forKey: "savedHeight")
        UserDefaults.standard.setValue(bmiShowText.text, forKey: "savedBMI")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let text1 = UserDefaults.standard.string(forKey: "savedName") {
            name.text = text1
        }
        if let text2 = UserDefaults.standard.string(forKey: "savedAge") {
            age.text = text2
        }
        if let text3 = UserDefaults.standard.string(forKey: "savedGender") {
            gender.text = text3
        }
        if let text4 = UserDefaults.standard.string(forKey: "savedWeight") {
            weight.text = text4
        }
        if let text5 = UserDefaults.standard.string(forKey: "savedHeight") {
            height.text = text5
        }
        if let text5 = UserDefaults.standard.string(forKey: "savedBMI") {
            bmiShowText.text = text5
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
