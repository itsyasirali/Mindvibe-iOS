//
//  QuizViewController.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var optionButton1: QuizOptionButton!
    @IBOutlet weak var optionButton2: QuizOptionButton!
    @IBOutlet weak var optionButton3: QuizOptionButton!
    @IBOutlet weak var optionButton4: QuizOptionButton!
    
    private var _response: [TriviaQuestion]?
    var category_id: String!
    var question: String!
    var quizOptionsList = [String?]()
    var correctAnswer: String!
    var score = 0
    var count = 0
    var timerCounter: Timer?
    var timerCount = 0.0
    let progress = Progress(totalUnitCount: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyling()
        NetworkManagerClass().fetchQuizBloc(difficulty: QuizDifficulty.Easy.rawValue, category: category_id, type: Type.Multiple_Choice.rawValue){
            [weak self] (quizBloc) in
            
            self?._response = quizBloc
            print("_response is :", self!._response!);
            if self!._response != nil{
                self!.dataStorage()
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let alert = UIAlertController(title: nil, message: "Loading Questions....", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.questionText.isHidden = true
        self.stackView.isHidden = true
        self.progressView.isHidden = true
        
        self.present(alert, animated: false, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timerCounter?.invalidate()
    }
    
    func setupStyling() {
        questionText.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        if #available(iOS 13.0, *) {
            questionText.textColor = .label
        } else {
            // Fallback on earlier versions
        }
        questionText.numberOfLines = 0
        
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        buttons.forEach {
            $0?.layer.cornerRadius = 12
            $0?.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
            $0?.setTitleColor(.white, for: .normal)
            $0?.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            $0?.layer.shadowColor = UIColor.black.cgColor
            $0?.layer.shadowOpacity = 0.1
            $0?.layer.shadowOffset = CGSize(width: 0, height: 4)
            $0?.layer.shadowRadius = 4
        }
        
        if #available(iOS 13.0, *) {
            progressView.trackTintColor = .systemGray5
        } else {
            // Fallback on earlier versions
        }
        progressView.progressTintColor = .systemBlue
    }
    
    func updateScoreLabel() {
        UIView.transition(with: lblScore, duration: 0.3, options: .transitionFlipFromTop, animations: {
            self.lblScore.text = "Score: \(self.score)"
        })
    }

    
    func changeQuestion(question: String){
        questionText.text = "Q\(count + 1). \(question)"
    }
    
    func changeQuizOptions(quizOptionButton: QuizOptionButton, optionText: String) {
        quizOptionButton.setTitle(optionText, for: .normal)
        quizOptionButton.isCorrectAnswer = false
        quizOptionButton.isInCorrectAnswer = false
        quizOptionButton.isChecked = false
        quizOptionButton.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
        quizOptionButton.setTitleColor(.white, for: .normal)
        quizOptionButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        quizOptionButton.layer.cornerRadius = 12
        quizOptionButton.layer.shadowColor = UIColor.black.cgColor
        quizOptionButton.layer.shadowOpacity = 0.1
        quizOptionButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        quizOptionButton.layer.shadowRadius = 4
    }
    
    
    @IBAction func optionButton1Action(_ sender: Any) {
        optionButton1.isChecked =
        !optionButton1.isChecked
        optionButton2.isChecked = false
        optionButton3.isChecked = false
        optionButton4.isChecked = false
        
        submitButtonAction()
    }
    
    @IBAction func optionButton2Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = !optionButton2.isChecked
        optionButton3.isChecked = false
        optionButton4.isChecked = false
        
        submitButtonAction()
    }
    
    @IBAction func optionButton3Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = false
        optionButton3.isChecked = !optionButton3.isChecked
        optionButton4.isChecked = false
        
        submitButtonAction()
    }
    
    @IBAction func optionButton4Action(_ sender: Any) {
        optionButton1.isChecked = false
        optionButton2.isChecked = false
        optionButton3.isChecked = false
        optionButton4.isChecked = !optionButton4.isChecked
        
        submitButtonAction()
    }
    
    func submitButtonAction() {
        if optionButton1.titleLabel?.text == correctAnswer {
            if optionButton1.isChecked {
                optionButton1.isCorrectAnswer = true
                score += 1
                updateScoreLabel()
            }
            else{
                optionButton1.isCorrectAnswer = true
                optionButton2.isInCorrectAnswer = optionButton2.isChecked
                optionButton3.isInCorrectAnswer = optionButton3.isChecked
                optionButton4.isInCorrectAnswer = optionButton4.isChecked
            }
        }
        else if optionButton2.titleLabel?.text == correctAnswer {
            if optionButton2.isChecked {
                optionButton2.isCorrectAnswer = true
                score += 1
                updateScoreLabel()
            }
            else{
                optionButton1.isInCorrectAnswer = optionButton1.isChecked
                optionButton2.isCorrectAnswer = true
                optionButton3.isInCorrectAnswer = optionButton3.isChecked
                optionButton4.isInCorrectAnswer = optionButton4.isChecked
            }
        }
        else if optionButton3.titleLabel?.text == correctAnswer {
            if optionButton3.isChecked {
                optionButton3.isCorrectAnswer = true
                score += 1
                updateScoreLabel()
            }
            else{
                optionButton1.isInCorrectAnswer = optionButton1.isChecked
                optionButton2.isInCorrectAnswer = optionButton2.isChecked
                optionButton3.isCorrectAnswer = true
                optionButton4.isInCorrectAnswer = optionButton4.isChecked
            }
        }
        else if optionButton4.titleLabel?.text == correctAnswer {
            if optionButton4.isChecked {
                optionButton4.isCorrectAnswer = true
                score += 1
                updateScoreLabel()
            }
            else{
                optionButton1.isInCorrectAnswer = optionButton1.isChecked
                optionButton2.isInCorrectAnswer = optionButton2.isChecked
                optionButton3.isInCorrectAnswer = optionButton3.isChecked
                optionButton4.isCorrectAnswer = true
            }
        }
        
        optionButton1.isUserInteractionEnabled = false
        optionButton2.isUserInteractionEnabled = false
        optionButton3.isUserInteractionEnabled = false
        optionButton4.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.count = self.count + 1
            self.optionButton1.isChecked = false
            self.optionButton2.isChecked = false
            self.optionButton3.isChecked = false
            self.optionButton4.isChecked = false
            if self.count != 10{
                self.dataStorage()
                self.timerCounter?.invalidate()
            }
            else{
                self.timerCounter?.invalidate()
                let resultVC = QuizResultViewController()
                resultVC.score = self.calculateScore()
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
            
        })
    }
    
    func dataStorage(){
        self.question = self._response?[self.count].question!.htmlDecoded
        self.quizOptionsList = [self._response?[self.count].correct_answer!.htmlDecoded, self._response?[self.count].incorrect_answers?[0].htmlDecoded, self._response?[self.count].incorrect_answers?[1].htmlDecoded, self._response?[self.count].incorrect_answers?[2].htmlDecoded]
        self.correctAnswer = self._response?[self.count].correct_answer?.htmlDecoded
        updateUI()
    }
    
    func calculateScore() -> Int {
        return score
    }
    
    func updateUI(){
        DispatchQueue.main.async {
            self.changeQuestion(question: self.question)
            self.quizOptionsList.shuffle()
            self.changeQuizOptions(quizOptionButton: self.optionButton1, optionText: self.quizOptionsList[0]!)
            self.changeQuizOptions(quizOptionButton: self.optionButton2, optionText: self.quizOptionsList[1]!)
            self.changeQuizOptions(quizOptionButton: self.optionButton3, optionText: self.quizOptionsList[2]!)
            self.changeQuizOptions(quizOptionButton: self.optionButton4, optionText: self.quizOptionsList[3]!)
            
            self.dismiss(animated: true, completion: nil)
            self.questionText.isHidden = false
            self.stackView.isHidden = false
            self.progressView.isHidden = false
            
            self.optionButton1.isUserInteractionEnabled = true
            self.optionButton2.isUserInteractionEnabled = true
            self.optionButton3.isUserInteractionEnabled = true
            self.optionButton4.isUserInteractionEnabled = true
            
            self.progressView.progress = 0.0
            self.timerCount = 0.0
            self.progressView.progressTintColor = UIColor.blue
            //            self.progress.completedUnitCount = 0
            
            self.timerCounter = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){
                (timer) in
                guard self.timerCount < 8.0 else{
                    timer.invalidate()
                    self.submitButtonAction()
                    return
                }
                
                //                self.progress.completedUnitCount += 1
                self.timerCount += 0.01
                if self.timerCount > 6.0 {
                    self.progressView.progressTintColor = UIColor.red.withAlphaComponent(0.6)
                }
                self.progressView.setProgress(Float(self.timerCount / 8.0), animated: true)
            }
            //            UIView.animate(withDuration: 0.0, animations: {
            //                self.progressView.setProgress(0.0, animated: true)
            //            })
            //            UIView.animate(withDuration: 6.0, animations: {
            //                self.progressView.setProgress(1.0, animated: true)
            //            })
            
        }
    }
}

class QuizOptionButton: UIButton{
    
    var isChecked: Bool = false{
        didSet{
            if isChecked{
                //                self.backgroundColor = UIColor.orange.withAlphaComponent(0.8)
            }
            else{
                self.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    var isCorrectAnswer: Bool = false{
        didSet{
            if isCorrectAnswer{
                self.backgroundColor = UIColor.green.withAlphaComponent(0.6)
            }
            else{
            }
        }
    }
    
    var isInCorrectAnswer: Bool = false{
        didSet{
            if isInCorrectAnswer{
                self.backgroundColor = UIColor.red.withAlphaComponent(0.6)
            }
            else{
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        self.isChecked = false
        self.setTitleColor(.black, for: .normal)
        //        self.titleEdgeInsets.left = 25.0
        self.layer.cornerRadius = self.frame.size.height / 10
    }
}

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
