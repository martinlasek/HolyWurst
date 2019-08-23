//
//  ModalView.swift
//  HolyWurst
//
//  Created by Martin Lasek on 23.08.19.
//  Copyright © 2019 Martin Lasek. All rights reserved.
//

import UIKit

final class ModalView: UIView {
  private let backgroundView = UIView()
  
  private let containerView = UIView()
  private let introLabel = UILabel()
  private let introDescriptionLabel = UILabel()
  private let manualLabel = UILabel()
  private let manualDescriptionLabel = UILabel()
  
  private let okButton = UIButton()
  
  var delegate: ModalViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup View
  
  private func setupView() {
    setupBackgroundView()
    setupContainerView()
    
    setupIntroLabel()
    setupIntroDescriptionLabel()
    setupManualLabel()
    setupManualDescriptionLabel()
    
    setupOKButton()
  }
  
  private func setupBackgroundView() {
    addSubview(backgroundView)
    
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    let top = backgroundView.topAnchor.constraint(equalTo: topAnchor)
    let leading = backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let bottom = backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let trailing = backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    backgroundView.backgroundColor = .black
    backgroundView.layer.opacity = 0.33
  }
  
  private func setupContainerView() {
    addSubview(containerView)
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    let centerY = containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50)
    let width = containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
    let centerX = containerView.centerXAnchor.constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate([centerY, width, centerX])
    
    containerView.backgroundColor = .white
    containerView.layer.cornerRadius = 20
    containerView.clipsToBounds = true
  }
  
  private func setupIntroLabel() {
    containerView.addSubview(introLabel)
    
    introLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = introLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15)
    let leading = introLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15)
    let trailing = introLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15)
    NSLayoutConstraint.activate([top, leading, trailing])
    
    introLabel.text = "INTRO"
    introLabel.textAlignment = .center
    introLabel.font = .systemFont(ofSize: 24, weight: .heavy)
  }
  
  private func setupIntroDescriptionLabel() {
    containerView.addSubview(introDescriptionLabel)
    
    introDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = introDescriptionLabel.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 5)
    let leading = introDescriptionLabel.leadingAnchor.constraint(equalTo: introLabel.leadingAnchor)
    let trailing = introDescriptionLabel.trailingAnchor.constraint(equalTo: introLabel.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, trailing])
    
    introDescriptionLabel.text = "This app uses machine learning to help you identify hotdogs!"
    introDescriptionLabel.numberOfLines = 0
    introDescriptionLabel.textAlignment = .center
    introDescriptionLabel.font = .systemFont(ofSize: 16)
  }
  
  private func setupManualLabel() {
    containerView.addSubview(manualLabel)
    
    manualLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = manualLabel.topAnchor.constraint(equalTo: introDescriptionLabel.bottomAnchor, constant: 30)
    let leading = manualLabel.leadingAnchor.constraint(equalTo: introDescriptionLabel.leadingAnchor)
    let trailing = manualLabel.trailingAnchor.constraint(equalTo: introDescriptionLabel.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, trailing])
    
    manualLabel.text = "MANUAL"
    manualLabel.textAlignment = .center
    manualLabel.font = .systemFont(ofSize: 24, weight: .heavy)
  }
  
  private func setupManualDescriptionLabel() {
    containerView.addSubview(manualDescriptionLabel)
    
    manualDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    let top = manualDescriptionLabel.topAnchor.constraint(equalTo: manualLabel.bottomAnchor, constant: 5)
    let leading = manualDescriptionLabel.leadingAnchor.constraint(equalTo: manualLabel.leadingAnchor)
    let trailing = manualDescriptionLabel.trailingAnchor.constraint(equalTo: manualLabel.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, trailing])
    
    manualDescriptionLabel.text = "Use the “swipe down” gesture to return back here."
    manualDescriptionLabel.numberOfLines = 0
    manualDescriptionLabel.textAlignment = .center
    manualDescriptionLabel.font = .systemFont(ofSize: 16)
  }
  
  private func setupOKButton() {
    containerView.addSubview(okButton)
    
    okButton.translatesAutoresizingMaskIntoConstraints = false
    let top = okButton.topAnchor.constraint(equalTo: manualDescriptionLabel.bottomAnchor, constant: 15)
    let leading = okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -1)
    let trailing = okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 1)
    let height = okButton.heightAnchor.constraint(equalToConstant: 50)
    let bottom = okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 1)
    NSLayoutConstraint.activate([top, leading, trailing, height, bottom])
    
    okButton.setTitle("OK", for: .normal)
    okButton.setTitleColor(.blue, for: .normal)
    okButton.layer.borderWidth = 1
    okButton.layer.borderColor = UIColor.gray.cgColor
    okButton.addTarget(self, action: #selector(okAction), for: .touchUpInside)
  }
  
  // MARK: - Actions
  
  @objc private func okAction() {
    if let delegate = delegate {
      delegate.okAction()
    }
  }
}

protocol ModalViewDelegate {
  func okAction()
}
