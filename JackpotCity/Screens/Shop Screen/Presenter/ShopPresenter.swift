//
//  ShopPresenter.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit

protocol ShopView:AnyObject {
    func showBuyView(item: CharacterModel)
    func collectionViewReloadData()
    func animateErrorLabel()
}

protocol ShopPresenterProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    init(view: ShopView, router: RouterProtocol)
    func dissmissVC(_ vc: UIViewController) 
    func buyItem(character: CharacterModel, complition: (_ success: Bool) -> Void)
}

class ShopPresenter: NSObject, ShopPresenterProtocol {
    weak var view: ShopView?
    private var router: RouterProtocol
    let characters = SettingsManager.playersArr
    
    required init(view: ShopView, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func buyItem(character: CharacterModel, complition: (_ success: Bool) -> Void) {
        if SettingsManager.currentCoin >= character.price {
            SettingsManager.currentCoin -= character.price
            SettingsManager.boughtPlayers.append(character)
            complition(true)
        } else {
            view?.animateErrorLabel()
            complition(false)
        }
    }
    
    func dissmissVC(_ vc: UIViewController) {
        router.dissmisVC(vc, completion: nil)
    }
    
}

extension ShopPresenter: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shop_cell", for: indexPath) as! ShopCollectionViewCell
        let data = characters[indexPath.row]
        cell.configure(playerImage: data.image ?? UIImage(), price: data.price.description)
        if SettingsManager.boughtPlayers.contains(where: {$0.index == data.index}) {
            cell.activeLabel.isHidden = false
            if SettingsManager.selectedIndex == data.index {
                cell.activeLabel.text = "Active"
            } else {
                cell.activeLabel.text = "Available"
            }
            cell.coinStack.isHidden = true
        } else {
            cell.activeLabel.isHidden = true
            cell.coinStack.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let data = characters[indexPath.row]
        if SettingsManager.boughtPlayers.contains(where: {$0.index == data.index}) {
            SettingsManager.selectedIndex = indexPath.row
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.view?.collectionViewReloadData()
            }
        } else {
            view?.showBuyView(item: characters[indexPath.row])
        }
    }
    
    
}

