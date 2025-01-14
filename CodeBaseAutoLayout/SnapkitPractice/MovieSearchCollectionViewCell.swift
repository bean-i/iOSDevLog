//
//  MovieSearchCollectionViewCell.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/13/25.
//

import UIKit
import SnapKit

class MovieSearchCollectionViewCell: UICollectionViewCell {
    
    let rankView = {
        let rankView = UIView()
        rankView.backgroundColor = .white
        return rankView
    }()
    
    let rankLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let movieNameLabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let mainView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setAutoLayout()
        // dateLabel의 compression resistance priority를 높여서, 줄어들지 않고 자신의 컨텐츠 유지하도록 설정
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ item: Movie, _ index: Int) {
        rankLabel.text = String(index + 1)
        movieNameLabel.text = item.name
        dateLabel.text = item.date
    }
    
    func setUI() {
        rankView.addSubview(rankLabel)
        
        [
            rankView,
            movieNameLabel,
            dateLabel
        ].forEach { contentView.addSubview($0) }
    
    }
    
    func setAutoLayout() {

        rankView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankView.snp.trailing).offset(15)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
}
