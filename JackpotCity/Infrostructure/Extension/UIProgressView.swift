//
//  UIProgressView.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 19.10.2022.
//

import UIKit


extension UIProgressView {
    @available(iOS 10.0, *)
    func setAnimatedProgress(progress: Float = 1, duration: Float = 1, completion: (() -> ())? = nil) {
          Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            DispatchQueue.main.async {
                let current = self.progress
                self.setProgress(current-(1/duration), animated: true)
            }
            if self.progress <= progress {
                timer.invalidate()
                if completion != nil {
                    completion!()
                }
            }
        }
    }
//    func stopAnimatedProgress() {
//        Timer.in
//    }
}
