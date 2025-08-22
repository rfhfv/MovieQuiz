//
//  MovieQuizView.swift
//  MovieQuiz
//
//  Created by admin on 13.08.2025.
//

import UIKit

final class MovieQuizView: UIView {
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .ypGray
        return indicator
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Вопрос:"
        label.font = UIFont(name: "YSDisplay-Medium", size: 20)
        label.textColor = .ypWhite
        return label
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "1/10"
        label.accessibilityIdentifier = "Index"
        label.font = UIFont(name: "YSDisplay-Medium", size: 20)
        label.textColor = .ypWhite
        return label
    }()
    
    let questionTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Рейтинг этого фильма меньше чем 5?"
        label.font = UIFont(name: "YSDisplay-Bold", size: 23)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .ypWhite
        return label
    }()
    
    let quizImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "")
        image.accessibilityIdentifier = "Poster"
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.layer.borderColor = UIColor.clear.cgColor
        image.layer.borderWidth = 8
        return image
    }()
    
    let noButton: UIButton = {
        let button = UIButton()
        button.setTitle("Нет", for: .normal)
        button.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        button.accessibilityIdentifier = "No"
        button.layer.cornerRadius = 15
        button.setTitleColor(.ypBlack, for: .normal)
        button.backgroundColor = .ypWhite
        return button
    }()
    
    let yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Да", for: .normal)
        button.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        button.accessibilityIdentifier = "Yes"
        button.layer.cornerRadius = 15
        button.setTitleColor(.ypBlack, for: .normal)
        button.backgroundColor = .ypWhite
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .ypBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieQuizView {
    func setupView() {
        addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(counterLabel)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(quizImage)
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(questionTextLabel)
        questionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            counterLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            counterLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            quizImage.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            quizImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            quizImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            quizImage.heightAnchor.constraint(equalToConstant: 502),
            
            questionTextLabel.topAnchor.constraint(equalTo: quizImage.bottomAnchor, constant: 45),
            questionTextLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 62),
            questionTextLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -62),
            
            noButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            noButton.heightAnchor.constraint(equalToConstant: 60),
            noButton.trailingAnchor.constraint(equalTo: yesButton.leadingAnchor, constant: -20),
            noButton.widthAnchor.constraint(equalTo: yesButton.widthAnchor),
            noButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            yesButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            yesButton.leadingAnchor.constraint(equalTo: noButton.trailingAnchor, constant: 20),
            yesButton.heightAnchor.constraint(equalToConstant: 60),
            yesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: quizImage.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: quizImage.centerXAnchor)
        ])
    }
}
