//
//  QRCodeScanner.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 20/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import Foundation

import AVFoundation
import UIKit

protocol QRCodeScannedProtocol: AnyObject {
    func QRCode(code: String)
}

final class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    weak var delegate: QRCodeScannedProtocol?
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "SCAN SCOOTER'S QR CODE"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = UIColor.init(white: 1, alpha: 0.7)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        btn.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.init(white: 1, alpha: 0.1)
        return btn
    }()
    
    var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -1)
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x:0, y: 0, width: view.frame.width, height: 300)
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        view.addSubview(textLabel)
        textLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 350, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        view.addSubview(footerView)
        view.addSubview(cancelBtn)
        
        footerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        
        cancelBtn.anchor(top: footerView.topAnchor, left: footerView.leftAnchor, bottom: footerView.bottomAnchor, right: footerView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: -8, paddingRight: 8, width: 0, height: 0)
    }
    
    @objc func cancelBtnPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            dismiss(animated: true)
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        delegate?.QRCode(code: code)

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
