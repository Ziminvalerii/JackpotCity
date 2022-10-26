//
//  SettingsPresenter.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import UIKit


protocol SettingsView:AnyObject {
    func goToPrivacyVC()
}

protocol SettingsPresenterProtocol: UITableViewDelegate, UITableViewDataSource {
    var router: RouterProtocol { get }
    init(view: SettingsView, router: RouterProtocol)
    func dissmisVC(_ vc: UIViewController)
    
}

class SettingsPresenter: NSObject, SettingsPresenterProtocol {
    weak var view: SettingsView?
     var router: RouterProtocol
    
    required init(view: SettingsView, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func dissmisVC(_ vc: UIViewController) {
        router.dissmisVC(vc, completion: nil)
    }
    
    @objc func sliderValueChanged (_ sender: UISlider) {
        switch sender.tag {
        case 0:
            AudioManager.shared.player?.volume = sender.value
        case 1:
            AudioManager.shared.soundVolume = sender.value
        case 2:
            UIScreen.main.brightness = CGFloat(sender.value)
        default:
            break
        }
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        AudioManager.shared.IsVibrationOn = sender.isOn
    }
    
    @objc func buttonDidTaped(_ sender: UIButton) {
        view?.goToPrivacyVC()
    }
}

extension SettingsPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings_cell", for: indexPath) as! SettingsTableViewCell
        switch indexPath.row {
        case 0:
            
            cell.configure(with: UIImage(named: "music")!)
            cell.cellSlider.value = AudioManager.shared.player?.volume ?? 0.0
//            return cell
        case 1:
//             cell = tableView.dequeueReusableCell(withIdentifier: "settings_cell", for: indexPath) as! SettingsTableViewCell
            cell.configure(with: UIImage(named: "sound")!)
            cell.cellSlider.value = AudioManager.shared.soundVolume ?? 0.0
//            return cell
        case 2:
//             cell = tableView.dequeueReusableCell(withIdentifier: "settings_cell", for: indexPath) as! SettingsTableViewCell
            cell.configure(with: UIImage(named: "brightness")!)
            cell.cellSlider.value = Float(UIScreen.main.brightness)
//            return cell
        case 3:
            let switchCell = tableView.dequeueReusableCell(withIdentifier: "switch_cell", for: indexPath) as! SwitchTableViewCell
            switchCell.selectionStyle = .none
            switchCell.switchLabel.isOn = AudioManager.shared.IsVibrationOn
            switchCell.switchLabel.addTarget(self, action: #selector(switchValueChanged(_ :)), for: .valueChanged)
            return switchCell
        case 4:
            let cellButton = tableView.dequeueReusableCell(withIdentifier: "button_cell", for: indexPath) as! ButtonTableViewCell
            cellButton.buttonCell.addTarget(self, action: #selector(buttonDidTaped(_ :)), for: .touchUpInside)
            return cellButton
        default:
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.cellSlider.tag = indexPath.row
        cell.cellSlider.addTarget(self, action: #selector(sliderValueChanged(_ :)), for: .valueChanged)
        return cell
    }
    
    
}
