//
//  resultNumberCollectionViewCell.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/14/25.
//

import UIKit
import SnapKit

class resultNumberCollectionViewCell: UICollectionViewCell, ViewSetting {
    
    static let identifier = "resultNumberCollectionViewCell"
    
    let backView = UIView()
    let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        contentView.addSubview(backView)
        contentView.addSubview(numberLabel)
    }
    
    func setLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setView() {
        backView.backgroundColor = .black
        backView.layer.cornerRadius = backView.frame.width / 2
        
        numberLabel.font = .systemFont(ofSize: 14, weight: .bold)
        numberLabel.textColor = .white
    }
    
    func setData(_ item: String) {
        numberLabel.text = item
    }
    
}
