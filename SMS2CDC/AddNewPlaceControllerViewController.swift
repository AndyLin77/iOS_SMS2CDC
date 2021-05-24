//
//  AddNewPlaceControllerViewController.swift
//  SMS2CDC
//
//  Created by Andy.Lin on 2021/5/22.
//

import UIKit

class AddNewPlaceControllerViewController: UIViewController, UITextFieldDelegate {
    
    //var placeList = ["7-11新興陽": "sms:1922&body=場所代碼：2852 8524 8913662\n本次簡訊實聯限防疫目的使用。"]
    
    @IBOutlet weak var placeTitleTextField: UITextField! {
        didSet {
            let BorderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)
            placeTitleTextField.layer.borderColor = BorderColor.cgColor
            placeTitleTextField.layer.borderWidth = 1.0
            placeTitleTextField.layer.cornerRadius = 5.0
                }
    }
    @IBOutlet weak var scanDataTextView: UITextView! {
        didSet {
            let BorderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)
            scanDataTextView.layer.borderColor = BorderColor.cgColor
            scanDataTextView.layer.borderWidth = 1.0
            scanDataTextView.layer.cornerRadius = 5.0
                }
    }
    
    var placeDetail: PlaceInfo!
    var placeList = [PlaceInfo]()
    
//    var dataRecieved: String? {
//        willSet {
//            scanDataTextField.text = ""
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let placelist = PlaceInfo.readFromFile() {
            self.placeList = placelist
        }
        placeTitleTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savePlaceNum(_ sender: UIBarButtonItem) {
        
        if placeTitleTextField.text!.isEmpty{
            let optionMenu = UIAlertController(title: "提示訊息", message: "請輸入場所名稱", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "確定", style: .cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
            return
        }
    
    
        if scanDataTextView.text.isEmpty {
            let optionMenu = UIAlertController(title: "提示訊息", message: "請掃描取得場所編號", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "確定", style: .cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
            return
        }
        
        placeDetail = PlaceInfo(title: placeTitleTextField.text!, message: scanDataTextView.text)
        placeList.insert(placeDetail!, at: 0)
        PlaceInfo.saveToFile(place: placeList)
        
        performSegue(withIdentifier: "goBackPlaceListSegue", sender: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func unwindBack(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? ScanPlaceNumberViewController
        scanDataTextView.text = sourceViewController?.dataPassed
//        if sourceViewController?.dataPassed == "" {
//            let optionMenu = UIAlertController(title: "QRCode 錯誤", message: "請掃描取店家提供之CDC實聯制QRCode", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "確定", style: .cancel, handler: nil)
//            optionMenu.addAction(cancelAction)
//            self.present(optionMenu, animated: true, completion: nil)
//        } else {
//
//        }
        
        // Use data from the view controller which initiated the unwind segue
        
        
    }
}
