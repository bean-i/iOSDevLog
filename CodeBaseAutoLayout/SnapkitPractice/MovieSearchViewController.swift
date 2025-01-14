//
//  MovieSearchViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/13/25.
//

import UIKit
import SnapKit
import Alamofire

class MovieSearchViewController: UIViewController, ViewSetting {
    
    
    let backgroundImageView = UIImageView()
    let backgroundShadowView = UIView()
    
    let searchView = UIView()
    let searchTextField = UITextField()
    let searchUnderLineView = UIView()
    let searchButton = UIButton()
    
    let movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=0bc4ffa481b80d1d29745a4dd826eae1&targetDt="
    
    var movieData: [Movie] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    
    static let yesterday: String = Date.dateToString(Date.yesterday)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieData(url + MovieSearchViewController.yesterday)
        
        setHierarchy()
        setLayout()
        setView()
    }
    
    func setHierarchy() {
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
    
    func setLayout() {
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
    
    func setView() {
        // backgroundImageView
        backgroundImageView.image = UIImage(named: "film")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.shadowColor = UIColor.darkGray.cgColor
        
        // backgroundShadowView
        backgroundShadowView.backgroundColor = .black
        backgroundShadowView.layer.opacity = 0.7
        
        // searchTextField
        searchTextField.delegate = self
        
        searchTextField.text = MovieSearchViewController.yesterday
        searchTextField.textColor = .white
        
        // searchUnderLineView
        searchUnderLineView.backgroundColor = .white
        
        // searchButton
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        // movieCollectionView
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieSearchCollectionViewCell.self, forCellWithReuseIdentifier: "MovieSearchCollectionViewCell")
        movieCollectionView.collectionViewLayout = setCollectionViewLayout()
        
        movieCollectionView.backgroundColor = .clear
    }
    
    func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing = 20
        layout.itemSize = CGSize(width: Int(UIScreen.main.bounds.width) - 2 * spacing, height: 44)
        return layout
    }
    
    func getMovieData(_ url: String) {
        AF.request(url, method: .get).responseDecodable(of: MovieBox.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                self.movieData = value.boxOfficeResult.dailyBoxOfficeList
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieDataFromDate() {
        guard let searchDate = searchTextField.text,
              !searchDate.isEmpty else {
            print("입력 오류")
            return
        }
        getMovieData(url + searchDate)
    }
    
    @objc func searchButtonTapped() {
        getMovieDataFromDate()
    }
}

extension MovieSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getMovieDataFromDate()
        view.endEditing(true)
        return true
    }
}

extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieSearchCollectionViewCell", for: indexPath) as! MovieSearchCollectionViewCell
        cell.setData(movieData[indexPath.item])
        
        return cell
    }
    
}
