//
//  StartView.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 13.10.2022.
//

import UIKit

protocol StartViewDelegate: AnyObject {
    func playViewButtonPressed()
    func settingsButtonPressed()
    func shopButtonPressed()
}

class StartView: UIView {

    var playBottonConstaint: NSLayoutConstraint?
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.animateShaking()
            playButton.doGlowAnimation(withColor: .white, withEffect: .big)
            playBottonConstaint = playButton.constraints.first(where: {$0.identifier == "playBottomConstraint"})
            playBottonConstaint?.constant -= self.bounds.size.height
        }
    }
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    
    weak var delegate: StartViewDelegate?
    var contentView: UIView?
    
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
        let nibName = String(describing: StartView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func animateButtonIn() {
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseOut) {
            self.playBottonConstaint?.constant = 24
            self.layoutIfNeeded()
        }
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        delegate?.playViewButtonPressed()
    }
    @IBAction func settingsButtonPressed(_ sender: Any) {
        delegate?.settingsButtonPressed()
    }
    @IBAction func shopButtonPressed(_ sender: Any) {
        delegate?.shopButtonPressed()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
