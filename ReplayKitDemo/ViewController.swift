//
//  ViewController.swift
//  ReplayKitDemo
//
//  Created by Jamario Davis on 12/13/20.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {
    let recorder = RPScreenRecorder.shared()
    override func viewDidLoad() {
            super.viewDidLoad()
            self.hideKeyboardWhenTappedAround()
        }
// Start recording
    @IBAction func onRecordTapped(_ sender: UIButton) {
        recorder.startRecording { (error) in
            if let error = error {
                print(error)
            }
        }
    }
// Stop recording
    @IBAction func onStopTapped(_ sender: UIButton) {
        recorder.stopRecording(handler: { (previewVC, error) in
            if let previewVC = previewVC {
                previewVC.previewControllerDelegate = self
                self.present(previewVC, animated: true, completion: nil)
            }
            if let error = error {
                print(error)
            }
        })
    }
}
// Indicates that the preview view controller is ready to be dismissed.
extension ViewController: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}
// Dismiss keyboard
extension ViewController {
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
