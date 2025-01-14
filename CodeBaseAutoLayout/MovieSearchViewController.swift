//
//  MovieSearchViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/13/25.
//

import UIKit
import SnapKit

class MovieSearchViewController: UIViewController {
    
    let backgroundImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "film")
        img.contentMode = .scaleAspectFill
        img.layer.shadowColor = UIColor.darkGray.cgColor
        return img
    }()
    
    let backgroundShadowView = {
        let shadowView = UIView()
        shadowView.backgroundColor = .black
        shadowView.layer.opacity = 0.7
        return shadowView
    }()
    
    let searchView = {
        let searchView = UIView()
//        searchView.backgroundColor = .green
        return searchView
    }()
    
    let searchTextField = {
        let tf = UITextField()
        tf.placeholder = "영화를 검색해 보세요."
        tf.textColor = .white
//        tf.backgroundColor = .red
        return tf
    }()
    
    let searchUnderLineView = {
        let lineView = UIView()
        lineView.backgroundColor = .white
        return lineView
    }()
    
    let searchButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("검색", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    lazy var movieCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setAutoLayout()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieSearchCollectionViewCell.self, forCellWithReuseIdentifier: "MovieSearchCollectionViewCell")
    }
    
    func setUI() {
        
        [
            searchTextField,
            searchUnderLineView,
            searchButton
        ].forEach { searchView.addSubview($0) }
        
        [
            backgroundImageView,
            backgroundShadowView,
            searchView,
            movieCollectionView
        ].forEach { view.addSubview($0) }
    }
    
    func setAutoLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundShadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(46)
        }
        
        searchUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(searchTextField.snp.trailing)
            make.height.equalTo(4)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(searchTextField.snp.trailing).offset(15)
            make.height.equalToSuperview()
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing = 20
        layout.itemSize = CGSize(width: Int(UIScreen.main.bounds.width) - 2 * spacing, height: 44)
        return layout
    }
    
    
}

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieSearchCollectionViewCell", for: indexPath) as! MovieSearchCollectionViewCell
        cell.setData(movieData[indexPath.item], indexPath.item)
        
        return cell
    }
    
}
