//
//  PrivacyPolicyViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 25.10.2022.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

    lazy var dissmissButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 24, y: 16, width: 24, height: 24))
        let image = UIImage(named: "cross")?.withRenderingMode(.alwaysTemplate)
        image!.withTintColor(.black)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dissmissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: self.view.bounds)
        webView.load(URLRequest(url: url))
        self.view.addSubview(webView)
        self.view.addSubview(dissmissButton)
        // Do any additional setup after loading the view.
    }
    
    @objc func dissmissButtonTapped() {
        self.dismiss(animated: true)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }


}
