//
//  QRController.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/18.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit
import AVFoundation

class QRController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAvfoundation()
    }
    
    func setupAvfoundation() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var deviceInput: AVCaptureDeviceInput!
        var error: NSError?
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: device)
        } catch let error1 as NSError  {
            error = error1
            deviceInput = nil
        }
        if (error == nil && captureSession?.canAddInput(deviceInput) != false) {
            captureSession?.addInput(deviceInput)
            let metaDataOutput = AVCaptureMetadataOutput()
            metaDataOutput.setMetadataObjectsDelegate(self , queue:DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            if captureSession!.canAddOutput(metaDataOutput) {
                captureSession?.addOutput(metaDataOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                
                self.captureSession?.startRunning()
            }
        }
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print(#function)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
