//
//  ViewController.swift
//  TranslateFromEngToRus
//
//  Created by Vlad Sys on 11/19/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit

class FirstNavigationVC: UIViewController {
    @IBOutlet weak var speechView: UIView!
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // segment border
        segment.layer.cornerRadius = 10
        segment.layer.borderColor = UIColor.white.cgColor
        segment.layer.borderWidth = 1
        segment.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentNav(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            UIView.animate(withDuration: 0.5, animations: {
                self.speechView.alpha = 1.0
                self.textView.alpha = 0.0
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.speechView.alpha = 0.0
                self.textView.alpha = 1.0
            })
        }
            
        
    }
    
}

