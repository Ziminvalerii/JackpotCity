//
//  PauseView.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 19.10.2022.
//

import UIKit

protocol PauseViewDelegate: AnyObject {
    func resumeButtonPressed()
    func homeButtonPressed()
}

class PauseView: UIView {

    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var homeButtonPressed: UIButton!
    @IBOutlet weak var pauseTitile: UIImageView!
    var contentView: UIView?
    weak var delegate: PauseViewDelegate?
    
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
        let nibName = String(describing: PauseView.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        delegate?.homeButtonPressed()
    }
    @IBAction func resumeButtonPressed(_ sender: Any) {
        delegate?.resumeButtonPressed()
    }
}
