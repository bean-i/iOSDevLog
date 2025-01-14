//
//  PayViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/13/25.
//

import UIKit
import SnapKit

class PayViewController: UIViewController {
    
    let segment = {
        let seg = UISegmentedControl()
        seg.insertSegment(withTitle: "멤버십", at: 0, animated: true)
        seg.insertSegment(withTitle: "현장결제", at: 1, animated: true)
        seg.insertSegment(withTitle: "쿠폰", at: 2, animated: true)
        seg.selectedSegmentIndex = 1
        seg.backgroundColor = .darkGray
        seg.tintColor = .white
        seg.selectedSegmentTintColor = .lightGray
        return seg
    }()
    
    let modalView = {
        let modalView = UIView()
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 15
        return modalView
    }()
    
    let topBarView = UIView()
    
    let logoImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "naver_pay")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let selectNationLabel = {
        let label = UILabel()
        label.text = "국내"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        return label
    }()

    let closeButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    let lockImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "lock")
        img.contentMode = .scaleAspectFill
        img.tintColor = .green
        return img
    }()
    
    let guideLabel = {
        let label = UILabel()
        label.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    let checkView = UIView()
    
    let checkButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "check"), for: .normal)
        btn.tintColor = .green
        return btn
    }()
    
    let checkLabel = {
        let label = UILabel()
        label.text = "바로결제 사용하기"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let confirmButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGreen
        btn.setTitle("확인", for: .normal)
        btn.layer.cornerRadius = 20
        btn.tintColor = .white
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
        setAutoLayout()
    }
    
    func setUI() {
        [logoImageView,
         selectNationLabel,
         closeButton
        ].forEach { topBarView.addSubview($0) }
        
        [
        checkButton,
        checkLabel
        ].forEach { checkView.addSubview($0) }
        
        [topBarView,
         checkView,
         confirmButton
        ].forEach { modalView.addSubview($0) }
        
        [
        segment,
        modalView,
        lockImageView,
        guideLabel
        ].forEach { view.addSubview($0) }

    }
    
    func setAutoLayout() {
        segment.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        modalView.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        topBarView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(44)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(28)
        }
        
        selectNationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(logoImageView.snp.trailing)
            make.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        lockImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topBarView.snp.bottom).offset(30)
            make.width.height.equalTo(120)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(lockImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        checkView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        checkLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(checkView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        
    }


}
