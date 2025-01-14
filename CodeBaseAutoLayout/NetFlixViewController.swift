//
//  NetFlixViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/13/25.
//

import UIKit
import SnapKit

class NetFlixViewController: UIViewController {
    
    let logoImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wordmark")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let textFieldListView = UIView()
    
    let emailTextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.placeholder = "이메일 주소 또는 전화번호"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.borderStyle = .none
        tf.layer.cornerRadius = 8
        return tf
    }()
    
    let passwordTextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.placeholder = "비밀번호"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.borderStyle = .none
        tf.layer.cornerRadius = 8
        return tf
    }()
    
    let nickNameTextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.placeholder = "닉네임"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.borderStyle = .none
        tf.layer.cornerRadius = 8
        return tf
    }()
    
    let locationTextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.placeholder = "위치"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.borderStyle = .none
        tf.layer.cornerRadius = 8
        return tf
    }()
    
    let codeTextField = {
        let tf = UITextField()
        tf.backgroundColor = .gray
        tf.placeholder = "추천 코드 입력"
        tf.textAlignment = .center
        tf.textColor = .white
        tf.borderStyle = .none
        tf.layer.cornerRadius = 8
        return tf
    }()
    
    let signUpButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("회원가입", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    let infoLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let infoSwitch = {
        let uISwitch = UISwitch()
        uISwitch.onTintColor = .red
        uISwitch.setOn(true, animated: true)
        return uISwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
        setAutoLayout()
    }
    
    func setUI() {
        
        [   emailTextField,
            passwordTextField,
            nickNameTextField,
            locationTextField,
            codeTextField,
            signUpButton
        ].forEach { textFieldListView.addSubview($0) }
        
        [   logoImageView,
            textFieldListView,
            infoLabel,
            infoSwitch
        ].forEach { view.addSubview($0) }
    }

    func setAutoLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        textFieldListView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(30)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textFieldListView.snp.bottom)
            make.height.equalTo(44)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldListView.snp.bottom).offset(20)
            make.leading.equalTo(textFieldListView)
        }
        
        infoSwitch.snp.makeConstraints { make in
            make.top.equalTo(textFieldListView.snp.bottom).offset(20)
            make.trailing.equalTo(textFieldListView)
        }
        
    }
    
}
