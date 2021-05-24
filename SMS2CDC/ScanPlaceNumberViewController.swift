//
//  ScanPlaceNumberViewController.swift
//  SMS2CDC
//
//  Created by Andy.Lin on 2021/5/23.
//

import UIKit
import AVFoundation


class ScanPlaceNumberViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var btmBarView: UIView!
    
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var dataPassed: String?
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scanQRCode()
    }
    
    func scanQRCode() {
        guard let audioDevice = AVCaptureDevice.default(for: .video) else  {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // 使用前一個裝置物件還來取得 AVCaptureDeviceInput 類別的實列例
            //let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // 在擷取 session 設定輸入裝置
            //captureSession.addInput(input)
            
            let vedioInput = try AVCaptureDeviceInput(device: audioDevice)
            if captureSession.canAddInput(vedioInput) {
                // 在擷取 session 設定輸入裝置
                captureSession.addInput(vedioInput)
            }
            
            // 初始化一個 AVCaptureMetadataOutput 物件並將其設定做為擷取 session 的輸出裝置
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // 設定委派並使用預設的調度佇列來執行回呼（call back）
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr] //supportedCodeTypes //
            
            // 初始化影片預覽層，並將其作為子層加入 viewPreview 視圖的圖層中
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            
            // 開始影片的擷取
            captureSession.startRunning()
            
            //移動訊息標籤與頂部列至上層
            view.bringSubviewToFront(btmBarView)
            
            //標示QRCode範圍
            qrCodeFrameView = UIView()
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 3
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
        } catch {
            // 發生錯誤，單存輸出其狀況不再繼續執行
            print(error)
            return
        }
    }
    

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // 檢查  metadataObjects 陣列為非空值，它至少需包含一個物件
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }

        // 取得元資料（metadata）物件
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr { //supportedCodeTypes.contains(metadataObj.type) { //
            // 倘若發現的元資料與 QR code 元資料相同，便更新狀態標籤的文字並設定邊界
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds

            //取得條碼訊息
            if metadataObj.stringValue != nil {
                
                //取得掃描資訊
                let scanStr = metadataObj.stringValue?.uppercased()
                let separated = "SMSTO:1922:"
                let separatedStr = scanStr?.components(separatedBy: separated)
                if separatedStr?.count ?? 1 < 2 {
                    dataPassed = ""
                } else {
                    dataPassed = separatedStr?[1]
                }
                
                performSegue(withIdentifier: "goBackAddPlaceSegue", sender: nil)
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
