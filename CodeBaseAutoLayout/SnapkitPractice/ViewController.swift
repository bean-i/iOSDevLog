//
//  ViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/13/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var netFlixButton = {
        let btn = UIButton()
        btn.setTitle("넷플릭스로 바로 가기", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.tag = 0
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var naverPayButton = {
        let btn = UIButton()
        btn.setTitle("네이버페이 바로 가기", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.tag = 1
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var movieSearchButton = {
        let btn = UIButton()
        btn.setTitle("영화 검색 바로 가기", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        btn.tag = 2
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    let buttonStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setAutoLayout()
    }
    
    func setUI() {
        [
            netFlixButton,
            naverPayButton,
            movieSearchButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
        
        view.addSubview(buttonStackView)
    }

    func setAutoLayout() {
        buttonStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(100)
            make.height.equalTo(200)
        }
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var vc = UIViewController()
        switch sender.tag {
        case 0:
            vc = NetFlixViewController()
        case 1:
            vc = PayViewController()
        case 2:
            vc = MovieSearchViewController()
        default:
            return
        }
        present(vc, animated: true)
    }

}

