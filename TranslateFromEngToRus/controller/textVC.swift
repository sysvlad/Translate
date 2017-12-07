//
//  textVC.swift
//  TranslateFromEngToRus
//
//  Created by Vlad Sys on 11/19/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit
import ROGoogleTranslate


class textVC: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    var array = [cellData]()
   
    @IBOutlet weak var sendBtnTwo: UIButton!
    @IBOutlet weak var textFieldTwo: UITextField!
    @IBOutlet weak var translateBtn: UIButton!
    @IBOutlet weak var translatedBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtnOne: UIButton!
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //btn
        translateBtn.layer.cornerRadius = 34.5
        translateBtn.layer.borderWidth = 4
        translateBtn.layer.borderColor = UIColor.white.cgColor
        translateBtn.clipsToBounds = true
        
        
        
        translatedBtn.layer.cornerRadius = 34.5
        translatedBtn.layer.borderWidth = 4
        translatedBtn.layer.borderColor = UIColor.white.cgColor
        translatedBtn.clipsToBounds = true
        
        
      

    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
       
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:120), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if array[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("TableViewCellOne", owner: self, options: nil)?.first as! TableViewCellOne
            cell.textOne.text = array[indexPath.row].textOne
            cell.textTwo.text = array[indexPath.row].textTwo
            return cell
        }else if array[indexPath.row].cell == 2{
            let cell = Bundle.main.loadNibNamed("TableViewCellTwo", owner: self, options: nil)?.first as! TableViewCellTwo
            cell.textOne.text = array[indexPath.row].textOne
            cell.textTwo.text = array[indexPath.row].textTwo
            return cell
        }else{
            let cell = Bundle.main.loadNibNamed("TableViewCellOne", owner: self, options: nil)?.first as! TableViewCellOne
            cell.textOne.text = array[indexPath.row].textOne
            cell.textTwo.text = array[indexPath.row].textTwo
            return cell
        }
        
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if array[indexPath.row].cell == 1 {
            return 110
        }else if array[indexPath.row].cell == 2{
            return 110
        }else{
            return 110
        }
    }
    @IBAction func sendBtnTwo(_ sender: AnyObject) {
        textFieldTwo.resignFirstResponder()
        let translator = ROGoogleTranslate()
        translator.apiKey = "AIzaSyDfyDTvTGMFO9xQr88qbPJbYBHkMl9a6yA" // Add your API Key here
        
        var params = ROGoogleTranslateParams()
        params.source =  "ru"
        params.target =  "en"
        params.text = textFieldTwo.text ?? "The textfield is empty"
        
        translator.translate(params: params) { (result) in
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.array.append(cellData(cell: 2,textOne: params.text, textTwo: result))
                self.tableView.insertRows(at: [IndexPath.init(row: self.array.count-1, section: 0)], with: .fade)
                self.tableView.endUpdates()
                
            }
        }
        self.textFieldTwo.text = " "
    }
    @IBAction func SendBtnOne(_ sender: AnyObject) {
        textFieldOne.resignFirstResponder()
        let translator = ROGoogleTranslate()
        translator.apiKey = "AIzaSyDfyDTvTGMFO9xQr88qbPJbYBHkMl9a6yA" // Add your API Key here
        
        var params = ROGoogleTranslateParams()
        params.source =  "en"
        params.target =  "ru"
        params.text = textFieldOne.text ?? "The textfield is empty"
        
        translator.translate(params: params) { (result) in
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.array.append(cellData(cell: 1,textOne: params.text, textTwo: result))
                self.tableView.insertRows(at: [IndexPath.init(row: self.array.count-1, section: 0)], with: .fade)
                self.tableView.endUpdates()
                
            }
        }
        self.textFieldOne.text = " "
    }
    @IBAction func firstFlagTapped(_ sender: AnyObject) {
        self.sendBtnOne.isHidden = false
        self.textFieldOne.isHidden = false
        self.sendBtnTwo.isHidden = true
        self.textFieldTwo.isHidden = true
    }

    @IBAction func secondFlagTapped(_ sender: AnyObject) {
        self.sendBtnOne.isHidden = true
        self.textFieldOne.isHidden = true
        self.sendBtnTwo.isHidden = false
        self.textFieldTwo.isHidden = false
    }
}
