//
//  CustomAuthPickerViewController.swift
//  PracticeFirebaseUI
//
//  Created by Johnny Toda on 2023/10/13.
//

import Foundation
import FirebaseAuthUI

final class CustomAuthPickerViewController: FUIAuthPickerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
//        Auth.auth().languageCode = "jp"

    }

    

    private func configureButtons() {
        guard let buttons = self.view.subviews.first?.subviews.first?.subviews.first?.subviews as? [UIButton] else { return }
        let titles = ["Googleでログイン", "Appleでログイン"]

        for (index, _) in zip(titles.indices, titles) {
            if let button = buttons[index] as? UIButton {
                button.setTitle(titles[index], for: .normal)
                button.layer.cornerRadius = 20.0
                button.layer.masksToBounds = true
            }
        }
    }
    private func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
