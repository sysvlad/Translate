//
//  speechVC.swift
//  TranslateFromEngToRus
//
//  Created by Vlad Sys on 11/19/17.
//  Copyright © 2017 Vlad Sys. All rights reserved.
//

import UIKit
import Speech
import ROGoogleTranslate

struct cellData {
    let cell: Int!
    let textOne: String!
    let textTwo: String!
}

public class speechVC: UIViewController, SFSpeechRecognizerDelegate, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    
    var array = [cellData]()
    
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var translatedBtn: UIButton!
    @IBOutlet weak var translateBtn: UIButton!
    public override func viewDidLoad() {
        super.viewDidLoad()

    
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
          self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //btn
        translateBtn.layer.cornerRadius = 34.5
        translateBtn.layer.borderWidth = 4
        translateBtn.layer.borderColor = UIColor.white.cgColor
        translateBtn.clipsToBounds = true
        
        
        
        translatedBtn.layer.cornerRadius = 34.5
        translatedBtn.layer.borderWidth = 4
        translatedBtn.layer.borderColor = UIColor.white.cgColor
        translatedBtn.clipsToBounds = true
        
        
        // Disable the record buttons until authorization has been granted.
        translateBtn.isEnabled = false
    }

    override public func viewDidAppear(_ animated: Bool) {
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.translateBtn.isEnabled = true
                    
                case .denied:
                    self.translateBtn.isEnabled = false
                    self.translateBtn.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.translateBtn.isEnabled = false
                    self.translateBtn.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.translateBtn.isEnabled = false
                    self.translateBtn.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
         let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.label.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
                print(result.bestTranscription.formattedString)
            }
            
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.translateBtn.isEnabled = true
                self.translateBtn.setImage(UIImage(named: "microImg.png" ), for: [])
            }
        }
        
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        //textFieldOne.text = "Say something"
        label.text = "Say something"
        
    }
    
    // MARK: SFSpeechRecognizerDelegate
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            translateBtn.isEnabled = true
            translateBtn.setImage(UIImage(named: "microImg.png" ), for: [])
        } else {
            translateBtn.isEnabled = false
            
        }
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
    
    @IBAction func recordBtnTapped(_ sender: AnyObject) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            translateBtn.isEnabled = false
            translateBtn.setImage(UIImage(named: "microImg.png" ), for: [])
            let translator = ROGoogleTranslate()
            translator.apiKey = "AIzaSyDfyDTvTGMFO9xQr88qbPJbYBHkMl9a6yA" // Add your API Key here
            
            var params = ROGoogleTranslateParams()
            params.source =  "en"
            params.target =  "ru"
            params.text = label.text ?? "The textfield is empty"
            translator.translate(params: params) { (result) in
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.array.append(cellData(cell: 1,textOne: params.text, textTwo: result))
                    self.tableView.insertRows(at: [IndexPath.init(row: self.array.count-1, section: 0)], with: .fade)
                    self.tableView.endUpdates()
                    
                }
            }
        } else {
            self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
            try! startRecording()
            
        }
    }
    @IBAction func secondBtnTapped(_ sender: AnyObject) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            translateBtn.isEnabled = false
            translateBtn.setImage(UIImage(named: "microImg.png" ), for: [])
            let translator = ROGoogleTranslate()
            translator.apiKey = "AIzaSyDfyDTvTGMFO9xQr88qbPJbYBHkMl9a6yA" // Add your API Key here
            
            var params = ROGoogleTranslateParams()
            params.source =  "ru"
            params.target =  "en"
            params.text = label.text ?? "The textfield is empty"
            
            translator.translate(params: params) { (result) in
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.array.append(cellData(cell: 2,textOne: params.text, textTwo: result))
                    self.tableView.insertRows(at: [IndexPath.init(row: self.array.count-1, section: 0)], with: .fade)
                    self.tableView.endUpdates()
                    
                }
            }
        } else {
            self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU"))!
            try! startRecording()
            
        }
    }
 

}
