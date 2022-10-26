//
//  LoaderViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 25.10.2022.
//

import Lottie
import UIKit

class LoaderViewController: UIViewController {

    private lazy var welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 300, height: 50)
        imageView.center = view.center
        imageView.center.y -= 32
        imageView.image = UIImage(named: "WelcomeLabel")
        return imageView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.frame.size = CGSize(width: 250, height: 50)
        progressView.center.x = view.center.x
        progressView.frame.origin.y = view.bounds.height - 50
        
        progressView.progressTintColor = .white
//        UIColor(red: 29/255, green: 77/255, blue: 21/255, alpha: 1.0)
        
        progressView.trackTintColor = .lightGray.withAlphaComponent(0.5)
        
        progressView.progress = 0
//        progressView.
        
        progressView.transform = CGAffineTransform(scaleX: 1, y: 5)
        
        return progressView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "background1")
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.isUserInteractionEnabled = true
        return backgroundImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundImageView)

        view.addSubview(progressView)
        
        view.addSubview(welcomeImageView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setAnimatedProgress(duration: 3) {
            let progressViewCenter = self.progressView.center
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.progressView.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 1.5) { [weak self] in
                    self?.welcomeImageView.center = progressViewCenter
                    self?.welcomeImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                } completion: { _ in
                    let builder = Builder()
                    let router = Router(builder: builder)
    //                let menuVC = MenuViewController()
                    (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = router.presentGameVC()
                }
            }
        }
       
    }
    
    func setAnimatedProgress(progress: Float = 1, duration: Float = 1, completion: (() -> ())? = nil) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
                DispatchQueue.main.async {
                    let current = self.progressView.progress
                    let progress = Float.random(in: 0.1 ... 0.25)
                    self.progressView.setProgress(current+(progress), animated: true)
                }
                if self.progressView.progress >= progress {
                    timer.invalidate()
                    if completion != nil {
                        completion!()
                    }
                }
            }
        }

//    class func instantiateMyViewController() -> Self {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
//        return vc
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
