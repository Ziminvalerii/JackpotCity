//
//  GameOverView.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 19.10.2022.
//

import UIKit

protocol GameOverViewDelegate: AnyObject {
    func heartButtonPressed()
}

class GameOverView: UIView {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorLabelCenterYConstraint: NSLayoutConstraint! {
        didSet {
            errorLabelCenterYConstraint.constant = self.bounds.size.height/2 + 24
        }
    }
    @IBOutlet weak var tapView: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTaped))
            tapView.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var coinStackView: UIStackView! {
        didSet {
            coinStackView.layer.masksToBounds = false
            coinStackView.layer.shadowColor = UIColor(red: 255/255, green: 200/255, blue: 67/255, alpha: 1).cgColor
            coinStackView.layer.shadowRadius = 7
            coinStackView.layer.shadowOpacity = 1
            coinStackView.layer.shadowOffset = .zero
        }
    }
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.progress = 1
        }
    }
    @IBOutlet weak var coinLabel: UILabel!
   
    @IBOutlet weak var loseImageView: UIImageView!
    
    var contentView: UIView?
    
    weak var delegate: GameOverViewDelegate?
    
    var isReborn: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
        
    }
    //MARK: -View Configuration
    private func configureView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        
//        view.layer.cornerRadius = 10
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let nibName = String(describing: GameOverView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func animateErrorLabel() {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
            self.errorLabelCenterYConstraint?.constant = 0
            self.errorLabel.alpha = 0
            self.layoutIfNeeded()
        } completion: { success in
            self.errorLabelCenterYConstraint?.constant = self.bounds.size.height/2 + 24
            self.errorLabel.alpha = 1
        }
    }
    
    @objc func viewDidTaped() {
        print("view was tapped")
        progressView.progress -= 0.25
    }
   
    
    @IBAction func heartButtonTapped(_ sender: Any) {
        print("HeartPressed")
//        isReborn = true
//        animateErrorLabel()
        AudioManager.shared.vibrate()
        delegate?.heartButtonPressed()
    }
    func animateView() {
        heartButton.animateShaking()
        heartButton.doGlowAnimation(withColor: UIColor(red: 93/255, green: 144/255, blue: 213/255, alpha: 1), withEffect: .big)
    }

}
