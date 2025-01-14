//
//  LotteryViewController.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

class LotteryViewController: UIViewController, ViewSetting {

    let roundTextField = UITextField()
    
    let roundView = UIView()
    let roundInfoLabel = UILabel()
    let roundDateLabel = UILabel()
    let underLineView = UIView()
    
    let roundResultLabelView = UIView()
    let currentRoundLabel = UILabel()
    let roundResultLabel = UILabel()
    
    let resultNumberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let roundPickerView = UIPickerView()
    
    // 가장 최근 회차
    var maxRound: Int {
        get {
            UserDefaults.standard.integer(forKey: "maxRound")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "maxRound")
        }
    }
    var maxDate: String {
        get {
            UserDefaults.standard.string(forKey: "maxDate") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "maxDate")
        }
    }
    lazy var selectedRound: Int = maxRound
    var selectedDate: String = ""
    var numbers: [Int] = [1, 2, 3, 4, 5, 6, 7] {
        didSet {
            resultNumberCollectionView.reloadData()
        }
    }
    
    var url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
    var currentLottoResult: Lotto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatest()
        getLottoData(String(selectedRound))
        setHierarchy()
        setLayout()
        setView()
    }
    
    func setHierarchy() {
        
        [
            currentRoundLabel,
            roundResultLabel
        ].forEach { roundResultLabelView.addSubview($0) }
        
        [
            roundInfoLabel,
            roundDateLabel,
            underLineView
        ].forEach { roundView.addSubview($0) }
        
        [
            roundTextField,
            roundView,
            roundResultLabelView,
            resultNumberCollectionView
        ].forEach { view.addSubview($0) }
    }
    
    func setLayout() {
        roundTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        roundView.snp.makeConstraints { make in
            make.top.equalTo(roundTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        roundInfoLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        roundDateLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(roundInfoLabel.snp.bottom).offset(15)
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        roundResultLabelView.snp.makeConstraints { make in
            make.top.equalTo(roundView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        currentRoundLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        roundResultLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(currentRoundLabel.snp.trailing).offset(5)
        }
        
        resultNumberCollectionView.snp.makeConstraints { make in
            make.top.equalTo(roundResultLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }

        
    }
    
    func setView() {
        // roundTextField
        roundTextField.delegate = self
        
        roundTextField.textAlignment = .center
        roundTextField.borderStyle = .none
        roundTextField.layer.borderColor = UIColor.lightGray.cgColor
        roundTextField.layer.borderWidth = 1
        roundTextField.layer.cornerRadius = 8
        roundTextField.placeholder = "회차를 선택하세요"
        
        // roundInfoLabel
        roundInfoLabel.text = "당첨번호 안내"
        roundInfoLabel.textAlignment = .left
        
        // roundDateLabel
        roundDateLabel.text = "\(selectedDate)"
        roundDateLabel.textAlignment = .right
        roundDateLabel.textColor = .gray
        roundDateLabel.font = .systemFont(ofSize: 12)
        
        // underLineView
        underLineView.backgroundColor = .lightGray
        
        // currentRoundLabel
        currentRoundLabel.text = "\(selectedRound)회"
        currentRoundLabel.textAlignment = .left
        currentRoundLabel.textColor = .systemYellow
        currentRoundLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        // roundResultLabel
        roundResultLabel.text = "당첨 결과"
        roundResultLabel.textAlignment = .right
        roundResultLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        // roundPickerView
        roundPickerView.delegate = self
        roundPickerView.dataSource = self
        
        // resultNumberCollectionView
        resultNumberCollectionView.delegate = self
        resultNumberCollectionView.dataSource = self
        resultNumberCollectionView.collectionViewLayout = setCollectionViewLayout()
        resultNumberCollectionView.register(resultNumberCollectionViewCell.self, forCellWithReuseIdentifier: resultNumberCollectionViewCell.identifier)
        
    }
    
    func setCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let spacing: CGFloat = 5
        let inset: CGFloat = 20
    
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let deviceWidth = UIScreen.main.bounds.width
        let size = (deviceWidth - (2 * inset) - (7 * spacing)) / 8
        layout.itemSize = CGSize(width: size, height: size)
        
        return layout
    }
    
    func getLatest() {
        // 임시로 초기화 해놓았는데, 보통 이런 초기화는 어디서 하는지 궁금합니다.!
        UserDefaults.standard.removeObject(forKey: "maxRound")
        UserDefaults.standard.set(1154, forKey: "maxRound")
        
        UserDefaults.standard.removeObject(forKey: "maxDate")
        UserDefaults.standard.set("20250111", forKey: "maxDate")
        
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let weekAgoString = Date.dateToString(weekAgo)
        if weekAgoString == maxDate {
            print("이전 회차로부터 1주일이 지났습니다.")
            let newRound = maxRound + 1
            maxRound = newRound // 회차 늘려주기
            maxDate = weekAgoString
        }
    }
    
    func getLottoData(_ round: String) {
        AF.request(url + round, method: .get).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.currentLottoResult = value
                
                guard let result = self.currentLottoResult else {
                    return
                }
                
                self.updateUI(result)
            case .failure(_):
                print("error")
            }
        }
    }
    
    func updateUI(_ value: Lotto) {
        selectedRound = value.drwNo
        selectedDate = value.drwNoDate
        numbers = [value.drwtNo1, value.drwtNo2, value.drwtNo3, value.drwtNo4, value.drwtNo5, value.drwtNo6, value.bnusNo]
        
        roundDateLabel.text = "\(selectedDate)"
        currentRoundLabel.text = "\(selectedRound)회"
        roundTextField.text = "\(selectedRound)"
    }

}

extension LotteryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        roundTextField.inputView = roundPickerView
    }
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxRound
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(maxRound - row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedRound = maxRound - row
        getLottoData(String(selectedRound))
        
    }
    
    
}


extension LotteryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resultNumberCollectionViewCell.identifier, for: indexPath) as! resultNumberCollectionViewCell
        
        if indexPath.item == 6 {
            cell.setData("+")
        } else if indexPath.item == 7 {
            cell.setData(String(numbers[indexPath.item - 1]))
        } else {
            cell.setData(String(numbers[indexPath.item]))
        }
        
        DispatchQueue.main.async {
            cell.backView.layer.cornerRadius = cell.backView.frame.width / 2
        }
        
        return cell
    }
    

}
