//
//  SettingsViewController.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import UIKit

class SettingsViewController: BaseViewController<SettingsPresenterProtocol>, SettingsView {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = presenter
            tableView.delegate = presenter
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossButtonPressed(_ sender: Any) {
        presenter.dissmisVC(self)
    }
    
    func goToPrivacyVC() {
        presenter.router.presentPrivacyVC(at: self)
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
