//
//  PlayerController.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit
import AVFoundation

private var playerViewControllerKVOContext = 0

class PlayerController: UIViewController {

    let player = AVPlayer()
    static let assetKeysRequiredToPlay = [
        "playable",
        "hasProtectedContent"
    ]
    
    var duration: Double {
        get {
            guard let currentItem = player.currentItem else {
                return 0.0
            }
            return CMTimeGetSeconds(currentItem.duration)
        }
    }
    
    var asset: AVURLAsset? {
        didSet {
            guard let newAsset = asset else { return }
            asynchronouslyLoadURLAsset(newAsset)
        }
    }
    
    var rate: Float {
        get {
            return player.rate
        }
        set {
            player.rate = newValue
        }
    }
    private var playerItem: AVPlayerItem? = nil {
        didSet {
            /*
             If needed, configure player item here before associating it with a player.
             (example: adding outputs, setting text style rules, selecting media options)
             */
            player.replaceCurrentItem(with: self.playerItem)
        }
    }
    let captureSession = AVCaptureSession()
    override func viewDidLoad() {
        super.viewDidLoad()
        //录制质量
        captureSession.canSetSessionPreset(AVCaptureSessionPresetLow)
        //使用的设备 视频和图片
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        //添加到输入中
        let deviceInput = try? AVCaptureDeviceInput(device: captureDevice)
        if captureSession.canAddInput(deviceInput) {
            captureSession.addInput(deviceInput)
        }
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.frame = .init(x: 0, y: 100, width: self.view.frame.width, height: 200)
        self.view.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        addObserver(self, forKeyPath: #keyPath(PlayerController.player.currentItem.duration), options: [.new, .initial], context: &playerViewControllerKVOContext)
    }
    private var timeObserverToken: Any?
    
    override func viewWillDisappear(_ animated: Bool) {
//        if let timeObserverToken = timeObserverToken {
//            player.removeTimeObserver(timeObserverToken)
//            self.timeObserverToken = nil
//        }
//        player.pause()
//        removeObserver(self, forKeyPath: #keyPath(PlayerController.player.currentItem.duration), context: &playerViewControllerKVOContext)
//        removeObserver(self, forKeyPath: #keyPath(PlayerController.player.rate), context: &playerViewControllerKVOContext)
//        removeObserver(self, forKeyPath: #keyPath(PlayerController.player.currentItem.status), context: &playerViewControllerKVOContext)
    }
    
    func asynchronouslyLoadURLAsset(_ newAsset: AVURLAsset) {
        /*
         Using AVAsset now runs the risk of blocking the current thread (the
         main UI thread) whilst I/O happens to populate the properties. It's
         prudent to defer our work until the properties we need have been loaded.
         */
        newAsset.loadValuesAsynchronously(forKeys: PlayerController.assetKeysRequiredToPlay) {
            /*
             The asset invokes its completion handler on an arbitrary queue.
             To avoid multiple threads using our internal state at the same time
             we'll elect to use the main thread at all times, let's dispatch
             our handler to the main queue.
             */
            DispatchQueue.main.async {
                /*
                 `self.asset` has already changed! No point continuing because
                 another `newAsset` will come along in a moment.
                 */
                guard newAsset == self.asset else { return }
                
                /*
                 Test whether the values of each of the keys we need have been
                 successfully loaded.
                 */
                for key in PlayerController.assetKeysRequiredToPlay {
                    var error: NSError?
                    
                    if newAsset.statusOfValue(forKey: key, error: &error) == .failed {
                        let stringFormat = NSLocalizedString("error.asset_key_%@_failed.description", comment: "Can't use this AVAsset because one of it's keys failed to load")
                        
                        let message = String.localizedStringWithFormat(stringFormat, key)
                        
//                        self.handleErrorWithMessage(message, error: error)
                        
                        return
                    }
                }
                
                // We can't play this asset.
                if !newAsset.isPlayable || newAsset.hasProtectedContent {
                    let message = NSLocalizedString("error.asset_not_playable.description", comment: "Can't use this AVAsset because it isn't playable or has protected content")
                    
//                    self.handleErrorWithMessage(message)
                    
                    return
                }
                
                /*
                 We can play this asset. Create a new `AVPlayerItem` and make
                 it our player's current item.
                 */
                self.playerItem = AVPlayerItem(asset: newAsset)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
