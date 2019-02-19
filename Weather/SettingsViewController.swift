//
//  SettingsViewController.swift
//  Weather
//
//  Created by BALAJI ABHISHEK on 2/17/19.
//  Copyright © 2019 BALAJI ABHISHEK. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    func changeColor(color : UIColor)
    func updateUIWithWeatherDataInFahrenheit()
    func updateUIWithWeatherDataInCentigrade()
}

/*
This class is used to select temperature in either centigrade or fahrenheit and also to select the background colour of the user interface.
*/
 
 
class SettingsViewController: UIViewController {
    

    
    var changeColourDelegate : SettingsDelegate?
    var temperatureDelegate  : SettingsDelegate?
    
    @IBOutlet weak var colourSegmentControl = UISegmentedControl()
    @IBOutlet weak var temperatureSegmentControl = UISegmentedControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    
    @IBAction func colorSegmentSelection(sender:UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
             changeColourDelegate?.changeColor(color: UIColor.orange)
        case 1:
             changeColourDelegate?.changeColor(color: UIColor.lightGray)
        default:
             changeColourDelegate?.changeColor(color: UIColor.yellow)
        }
    }
    
    @IBAction func temperatureSegmentSelection(sender:UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            temperatureDelegate?.updateUIWithWeatherDataInCentigrade()
        default:
            temperatureDelegate?.updateUIWithWeatherDataInFahrenheit()
        }
    }
   
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    
}
