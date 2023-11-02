//
//  CustomAuthPickerViewController.swift
//  PracticeFirebaseUI
//
//  Created by Johnny Toda on 2023/10/13.
//

import Foundation
import FirebaseAuthUI

final class CustomAuthPickerViewController: FUIAuthPickerViewController {
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, descriptionLabel])
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var titleLabel =  {
        let label = UILabel()
        label.text = "🍅ようこそ🍅"
        label.font = UIFont(name: "Hiragino Sans", size: 40)
        label.textAlignment = .center
        return label
    }()

    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SignInIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var descriptionLabel =  {
        let label = UILabel()
        label.text = "ログイン&アカウント作成"
        label.font = UIFont(name: "Hiragino Sans", size: 16)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        setUpButtons()
        authUI.delegate = self
        print("view.descendantの結果：", view.descendant(UIButton.self))
    }


    ///  認証ボタンのレイアウトを整える
    private func setUpButtons() {
        for button in view.descendant(UIButton.self) {
            configureSignInButton(button)
        }
    }

    /// 指定のレイアウトのボタンを生成する
    private func configureSignInButton(_ button: UIButton) {
        var configuration = UIButton.Configuration.plain()
        configuration.image = button.imageView?.image
        configuration.imagePadding = 8
        configuration.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 30)

        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true

        // FIXME: 認証機能が増えるほどコードが膨張してしまう問題
        if button.titleLabel!.text!.contains("Google") {
            var string = AttributedString(stringLiteral: "Googleで続ける")
            string.font = .systemFont(ofSize: 12, weight: .semibold)

            button.configurationUpdateHandler = { button in
                //            string.foregroundColor = .green
                string.foregroundColor = .gray.withAlphaComponent(
                    button.state == .highlighted ? 1.0 : 1.0
                )
                configuration.attributedTitle = string
                button.configuration = configuration
            }
        } else if button.titleLabel!.text!.contains("Apple") {
            var string = AttributedString(stringLiteral: "Appleで続ける")
            string.font = .systemFont(ofSize: 12, weight: .semibold)

            button.configurationUpdateHandler = { button in
                string.foregroundColor = .white.withAlphaComponent(
                    button.state == .highlighted ? 1.0 : 1.0
                )
                configuration.attributedTitle = string
                button.configuration = configuration
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
    }

    /// ラベルを生成して画面中央に配置
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        // 😼この一行で全てのAutoLayoutに.isActive = trueを一括で指定できる
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }

    private func setUpUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension CustomAuthPickerViewController: FUIAuthDelegate {
    // サインイン・サインアップ完了後に実行する処理
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let _ = user {
            // ログイン成功処理
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController

            homeVC.modalTransitionStyle = .crossDissolve
            homeVC.modalPresentationStyle = .fullScreen

            present(homeVC, animated: true)
        } else {
            // ログイン失敗処理
            print("LoginFailure")
        }
    }
}
