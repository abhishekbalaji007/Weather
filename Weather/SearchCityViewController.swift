//
//  SearchCityViewController.swift
//  Weather
//
//  Created by BALAJI ABHISHEK on 2/17/19.
//  Copyright © 2019 BALAJI ABHISHEK. All rights reserved.
//

import UIKit

protocol  SearchCityDelegate {
    
    func cityNameEntered(city:String)
}

// This class is used to get weather details based on city name.
 
class SearchCityViewController: UIViewController {

   
    
    var cityChangedDelegate:SearchCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func goPressed(_ sender: AnyObject) {
        
        let changedCity = changeCityTextField.text!
        
        cityChangedDelegate?.cityNameEntered(city: changedCity)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
