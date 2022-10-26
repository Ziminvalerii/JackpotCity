//
//  ShopViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit

class ShopViewController: BaseViewController<ShopPresenterProtocol>, ShopView {
    
    @IBOutlet weak var coinCountLabel: UILabel! {
        didSet {
            updateCointCount()
        }
    }
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = presenter
            collectionView.dataSource = presenter
        }
    }
    
    let overlay = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var buyView: BuyView?
    
    var errorLabelCenterY: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabelCenterY = self.view.constraints.first(where: {$0.identifier == "errorLabelCenterY"})!
        errorLabelCenterY!.constant = view.bounds.height/2 + 24
        // Do any additional setup after loading the view.
      
    }
    
    

    @IBAction func crossButtonPressed(_ sender: Any) {
        presenter.dissmissVC(self)
    }
    
    func animateIn(_ view: UIView, overlay: UIView) {
        view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        view.alpha = 0
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        UIView.animate(withDuration: 0.4) {
            view.alpha = 1
            view.transform = CGAffineTransform.identity
            overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        }
    }
    
    func animateOut(_ view : UIView, overlay: UIView) {
        UIView.animate(withDuration: 0.4) {
            view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            view.alpha = 0
            overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        } completion: { (_) in
            view.removeFromSuperview()
            overlay.removeFromSuperview()
        }
    }
    
    func animateErrorLabel() {
        view.bringSubviewToFront(errorLabel)
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
            self.errorLabelCenterY?.constant = 0
            self.errorLabel.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { success in
            self.errorLabelCenterY?.constant = self.view.bounds.size.height/2 + 24
            self.errorLabel.alpha = 1
        }
    }
    
    func updateCointCount() {
        coinCountLabel.text = SettingsManager.currentCoin.description
    }
    
    func collectionViewReloadData() {
        collectionView.reloadData()
    }
    func showBuyView(item: CharacterModel) {
        buyView = BuyView(frame: CGRect(x: 0, y: 0, width: 200, height: 150), character: item)
        view.addSubview(overlay)
        buyView!.center = overlay.center
        self.view.addSubview(buyView!)
        buyView!.delegate = self
        animateIn(buyView!, overlay: overlay)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ShopViewController: BuyViewDelegate {
    func confirmButtonPressed(item: CharacterModel) {
        presenter.buyItem(character: item) { success in
            if success {
                updateCointCount()
                collectionViewReloadData()
                animateOut(buyView!, overlay: overlay)
            } else {
                buyView!.shake()
            }
        }
        
    }
    
    func cancelButtonPressed(item: CharacterModel) {
        animateOut(buyView!, overlay: overlay)
    }
    
     
}
