//
//  MainViewController.swift
//  NewlyCoinedWord
//
//  Created by 장예지 on 5/18/24.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var searchBackgroundView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var newlyCoinedWordButtons: [UIButton]!
    @IBOutlet var resultImageView: UIImageView!
    @IBOutlet var newlyCoinedWordMeaningLabel: UILabel!
    
    var newlyCoinedButtonTitles: [String] = ["윰차", "만만잘부", "실매", "꾸안꾸"]
    
    var newlyCoinedWords = [
        "만반잘부":"만나서 반가워 잘 부탁해",
        "꾸안꾸":"'꾸민 듯 안 꾸민 듯'의 줄임말.\n2019년 후반부터 인터넷 유행어로 쓰이기 시작했다.",
        "중꺽마":"중요한건 꺾이지 않는 마음",
        "스불재":"스스로 불러온 재앙",
        "편백족":"편의점과 백화점의 앞글자로 만들어진 신조어"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setActions()
    }
    
    private func setUI(){
        setSearchTextField()
        setNewlyCoinedWordsButtons()
        setSearchResultView()
    }
    
    private func setSearchTextField(){
        searchBackgroundView.backgroundColor = .black
        searchTextField.addLeftPadding()
        searchTextField.placeholder = "신조어를 입력해주세요"
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = .white
        searchTextField.tintColor = .black
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
    }
    
    private func setNewlyCoinedWordsButtons(){
        for button in newlyCoinedWordButtons {
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.tintColor = .lightGray
            button.setTitleColor(.black, for: .normal)
            var config = UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            button.configuration = config
            
        }
        randomTitle()
    }
    
    private func setSearchResultView(){
        resultImageView.image = UIImage(named: "background")
        resultImageView.contentMode = .scaleAspectFill
        
        newlyCoinedWordMeaningLabel.textAlignment = .center
        newlyCoinedWordMeaningLabel.numberOfLines = 0
    }
    
    private func setActions(){
        searchButton.addTarget(self, action: #selector(textFieldEndEditing), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(textFieldEndEditing), for: .editingDidEndOnExit)
    }
    
    @objc func textFieldEndEditing(){
        randomTitle()
        searchWords()
        searchTextField.endEditing(true)
    }
    
    func searchWords(){
        guard let word = searchTextField.text else {
            newlyCoinedWordMeaningLabel.text = "다시 입력해 주세요"
            return
        }
        
        if word.isEmpty {
            newlyCoinedWordMeaningLabel.text = "다시 입력해 주세요"
        } else {
            newlyCoinedWordMeaningLabel.text = newlyCoinedWords.keys.contains(word) ? newlyCoinedWords[word] : "\(word)에 대한\n검색결과가 없습니다."
        }
    }
    
    func randomTitle(){
        newlyCoinedButtonTitles.shuffle()
        for index in newlyCoinedWordButtons.indices {
            newlyCoinedWordButtons[index].setTitle(newlyCoinedButtonTitles[index], for: .normal)
        }
    }
}

//TextField의 왼쪽 패딩 추가 코드
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
