//
//  ViewController.swift
//  SMS2CDC
//
//  Created by Andy.Lin on 2021/5/22.
//

import UIKit

class ViewController: UIViewController {
    
//    let fileManager = FileManager.default
//    let fileName = NSHomeDirectory() + "/Documents/place.txt"
//    var placeList = ["7-11新興陽": "sms:1922&body=場所代碼：2852 8524 8913662\n本次簡訊實聯限防疫目的使用。"]
    
    //7-11新興陽 場所代碼：2852 8524 8913662\n本次簡訊實聯限防疫目的使用。SMS2CDC/PlaceInfo.txt

    
    var placeDetail: PlaceInfo!
    var placeList = [PlaceInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let path = Bundle.main.path(forResource: "PlaceInfo", ofType: "txt")
//        let content = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
//        print(content)
        
        if let placelist = PlaceInfo.readFromFile() {
            self.placeList = placelist
        }
        
        
        // 建立 place.txt 檔案
        //fileManager.createFile(atPath: fileName, contents: nil, attributes: nil)
        
        // 將檔案路徑轉換成 URL 格式
//        var placeFileurl = URL(fileURLWithPath: fileName)
//
//        do {
//            var noBackUp = URLResourceValues()
//            noBackUp.isExcludedFromBackup = true
//            try placeFileurl.setResourceValues(noBackUp)
//        } catch {
//            print("noBackUp setting fail")
//        }
        
    }

    @IBAction func saveText(_ sender: UIButton) {
//        do {
//            try "sms:1922&body=場所代碼：2852 8524 8913662\n本次簡訊實聯限防疫目的使用。".write(toFile: fileName, atomically: true, encoding:  .utf8)
//        } catch {
//            print("save file fail")
//        }
//
//        do {
//            let placeNum = try String(contentsOfFile: fileName, encoding: .utf8)
//            print(placeNum)
//        } catch {
//            print("read file fail")
//        }
    }
    
    
    
    
    @IBAction func SMSTest(_ sender: UIBarButtonItem) {
        let sms: String = "sms:1922&body=場所代碼：2852 8524 8913662\n本次簡訊實聯限防疫目的使用。"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
}

