//
//  DetailViewController.swift
//  Gaongil
//
//  Created by Lena on 2022/10/18.
//

import UIKit
import SafariServices
import SwiftSoup

class DetailViewController: UIViewController {
    
    var instituteView = CustomView()
    var progressView = CustomView()
    var suggestionDateView = CustomView()
    var proposerView = CustomView()
    
    var shared = ResponseManager.shared
    let coreDataManager = CoreDataManager.shared
    var result = [Row]()
    var selectedIndex = 0
    var detailLawLink: String?
    
    
    //    var favoriteLawIsSelected : Bool = false{
    //        willSet {
    //            self.setSelected(newValue)
    //        }
    //    }
    
    
    private var lawTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlack
        label.font = .boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        let subviews = [instituteView, progressView, suggestionDateView, proposerView]
        
        instituteView.updateSubTitleLabel("소관기관")
        progressView.updateSubTitleLabel("진행사항")
        suggestionDateView.updateSubTitleLabel("제안일")
        proposerView.updateSubTitleLabel("제안자")
        
        for view in subviews {
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
        
    }()
    
    private var contentTextView: UITextView = {
        let textView = UITextView()
        
        textView.isScrollEnabled = true
        textView.textColor = .customBlack
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 19, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private var lawUrlButton: UIButton = {
        let button = UIButton()
        button.setTitle("웹에서 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customSelectedGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(lawUrlButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func favoriteLaw() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"star.fill"), style: .done, target: self, action: nil)
        
        let lawTitle = lawTitleLabel.text ?? String()
        let institute = instituteView.contentLabel.text ?? String()
        let progress = progressView.contentLabel.text ?? String()
        let proposer = proposerView.contentLabel.text ?? String()
        let suggestionDate = suggestionDateView.contentLabel.text ?? String()
        let contentText = contentTextView.text ?? String()
        coreDataManager.saveFavoriteCoreData(lawTitle: lawTitle, institute: institute, progress: progress, proposer: proposer, suggestionDate: suggestionDate, contentText: contentText) { _ in }
        
        
        //        if favoriteLawIsSelected {
        //            favoriteLawIsSelected = false
        //            print(favoriteLawIsSelected)
        //        } else {
        //            favoriteLawIsSelected = true
        //            print(favoriteLawIsSelected)
        //        }
    }
    
    @objc func lawUrlButtonTapped() {
        //        let detailLawSafariView: SFSafariViewController = SFSafariViewController(url: detailLawLink! as URL)
        //        self.present(detailLawSafariView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .white
        
        self.navigationItem.title = "법안 상세내용"
        self.navigationItem.largeTitleDisplayMode = .never
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"star"), style: .plain, target: self, action: #selector(favoriteLaw))
        self.navigationController?.navigationBar.tintColor = .customSelectedGreen
        
        [lawTitleLabel, cardView, contentTextView].forEach { view.addSubview($0) }
        cardView.addSubview(informationStackView)
        //        contentTextView.addSubview(lawUrlButton)
        
        configureConstraints()
        cardView.setShadow(offset: CGSize.init(width: 1, height: 1),
                           color: UIColor.black,
                           radius: 6,
                           opacity: 0.2)
        
        lawTitleLabel.text = shared.rows[0][selectedIndex].billName ?? String()
        instituteView.contentLabel.text = shared.rows[0][selectedIndex].currCommittee ?? String()
        progressView.contentLabel.text = shared.rows[0][selectedIndex].procResultCd ?? String()
        proposerView.contentLabel.text = shared.rows[0][selectedIndex].proposer ?? String()
        suggestionDateView.contentLabel.text = shared.rows[0][selectedIndex].proposeDt ?? String()
        detailLawLink = self.shared.rows[0][selectedIndex].linkUrl
        
        guard let detailLawLink else { return }
        
        getWebpage(detailLawLink) { result in
            if let content = result {
                print("제안이유 및 제안내용을 성공적으로 불러왔습니다.")
                print(content)
                self.contentTextView.attributedText = content
            } else {
                print("제안이유 및 제안내용을 찾을 수 없거나 오류가 발생했습니다.")
                self.contentTextView.text = "내용을 불러올 수 없습니다."
            }
        }
    }
    
    func viewDidDisappear() {
        super.viewDidDisappear(true)
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .automatic
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            lawTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            lawTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenHeight / 30.145),
            lawTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 22.94),
            
            cardView.topAnchor.constraint(equalTo: lawTitleLabel.bottomAnchor, constant: screenHeight / 25.09),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.heightAnchor.constraint(equalToConstant: screenHeight / 6.58),
            
            informationStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: screenWidth / 25.94),
            informationStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -screenWidth / 22.94),
            informationStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            informationStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5),
            
            contentTextView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: screenHeight / 26.09),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 22.94),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenWidth / 22.94),
            contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
        ])
    }
    
    func getWebpage(_ myURL: String, completion: @escaping (NSAttributedString?) -> Void) {
        guard let url = URL(string: myURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            if let data = data, let html = String(data: data, encoding: .utf8) {
                do {
                    // SwiftSoup으로 HTML 파싱
                    let document = try SwiftSoup.parse(html)
                    print("Parsed document: \(document)")
                    
                    // "제안이유 및 주요내용" 추출
                    if let content = self.extractContent(from: html) {
                        DispatchQueue.main.async {
                            completion(content) // 추출된 결과 반환
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil) // 찾지 못했을 경우
                        }
                    }
                } catch {
                    print("Error parsing HTML: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
   
    func extractContent(from html: String) -> NSAttributedString? {
        do {
            let document = try SwiftSoup.parse(html)
            let titleElements = try document.select("h5.subti02") // 제목 h5 태그
            let contentElements = try document.select("div.textType02") // 내용 div 태그
            
            let resultAttributedString = NSMutableAttributedString()
            
            // 각 제목과 내용을 순서대로 처리
            for (index, titleElement) in titleElements.array().enumerated() {
                let titleText = try titleElement.text().htmlEscaped // 제목 추출
                
                // "의안접수정보" 제목은 무시
                if titleText.contains("의안접수정보") {
                    continue
                }
                
                // 내용이 존재하지 않는 경우 제목도 추가하지 않음
                if index >= contentElements.array().count {
                    continue
                }
                
                let contentElement = contentElements.array()[index]
                let rawContent = try contentElement.html().htmlEscaped // HTML 내용 추출
                let contentText = rawContent
                    .replacingOccurrences(of: "<br>", with: "\n") // <br> 태그를 개행으로 변경
                    .replacingOccurrences(of: "&nbsp;", with: " ") // 공백 문자 처리
                let paragraphs = contentText
                    .components(separatedBy: "\n")
                    .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                
                // 내용이 비어있는 경우 제목 추가하지 않음
                if paragraphs.isEmpty {
                    continue
                }
                
                // 제목 - 볼드 스타일 적용
                let titleAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 18),
                    .foregroundColor: UIColor.black
                ]
                let titleAttributedString = NSAttributedString(string: "\(titleText)\n\n", attributes: titleAttributes)
                resultAttributedString.append(titleAttributedString)
                
                // 내용 - 일반 텍스트 스타일 적용
                let contentAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 15),
                    .foregroundColor: UIColor.darkGray
                ]
                for paragraph in paragraphs {
                    let paragraphText = NSAttributedString(string: "\(paragraph)\n\n", attributes: contentAttributes)
                    resultAttributedString.append(paragraphText)
                }
            }
            
            return resultAttributedString
        } catch {
            print("Error parsing HTML: \(error)")
            return nil
        }
    }
    
    
    
}

protocol SendUpdateProtocol : AnyObject {
    func sendUpdated()
}
