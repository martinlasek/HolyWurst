//
//  IntroView.swift
//  HolyWurst
//
//  Created by Martin Lasek on 23.06.19.
//  Copyright © 2019 Martin Lasek. All rights reserved.
//

import UIKit

final class IntroView: UIView {
  let title = UILabel()
  let subtitle = UILabel()
  
  let titleContainer = UIView()
  let subtitleContainer = UIView()
  
  let stackView = UIStackView()
  
  let overlay = UIView()
  
  let welcomeText = UILabel()
  let actionText = UILabel()
  let redCircleIV = UIImageView(image: UIImage(named: "circle"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup View
  
  private func setupView() {
    setupTitleContainer()
    setupSubtitleContainer()
    setupStackView()
    setupOverlay()
    setupWelcomeText()
    setupActionText()
    setupRedCircle()
  }
  
  private func setupTitleContainer() {
    addSubview(titleContainer)
    
    titleContainer.translatesAutoresizingMaskIntoConstraints = false
    let top = titleContainer.topAnchor.constraint(equalTo: topAnchor)
    let leading = titleContainer.leadingAnchor.constraint(equalTo: leadingAnchor)
    let trailing = titleContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
    let height = titleContainer.heightAnchor.constraint(equalToConstant: 125)
    NSLayoutConstraint.activate([top, leading, trailing, height])
    
    titleContainer.backgroundColor = .newRed
    
    titleContainer.addSubview(title)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    let centerX = title.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor)
    let centerY = title.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor)
    NSLayoutConstraint.activate([centerX, centerY])
    
    let attributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.strokeColor: UIColor.black,
      NSAttributedString.Key.strokeWidth: -5.0,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 65, weight: .heavy)
    ]
    title.attributedText = NSAttributedString(string: "HolyWurst", attributes: attributes)
  }
  
  private func setupSubtitleContainer() {
    addSubview(subtitleContainer)
    
    subtitleContainer.translatesAutoresizingMaskIntoConstraints = false
    let top = subtitleContainer.topAnchor.constraint(equalTo: titleContainer.bottomAnchor)
    let leading = subtitleContainer.leadingAnchor.constraint(equalTo: leadingAnchor)
    let trailing = subtitleContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
    let height = subtitleContainer.heightAnchor.constraint(equalToConstant: 50)
    NSLayoutConstraint.activate([top, leading, trailing, height])
    
    subtitleContainer.backgroundColor = .white
    
    subtitleContainer.addSubview(subtitle)
    
    subtitle.translatesAutoresizingMaskIntoConstraints = false
    let centerX = subtitle.centerXAnchor.constraint(equalTo: subtitleContainer.centerXAnchor)
    let centerY = subtitle.centerYAnchor.constraint(equalTo: subtitleContainer.centerYAnchor)
    NSLayoutConstraint.activate([centerX, centerY])
    
    subtitle.text = "\"The Shazam for Food\""
    subtitle.font = .systemFont(ofSize: 25, weight: .heavy)
    subtitle.textColor = .newRed
  }
  
  private func setupStackView() {
    addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let top = stackView.topAnchor.constraint(equalTo: subtitleContainer.bottomAnchor)
    let leading = stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let bottom = stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let trailing = stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    let imageOne = UIImageView(image: UIImage(named: "food_burger"))
    let imageTwo = UIImageView(image: UIImage(named: "food_sea"))
    let imageThree = UIImageView(image: UIImage(named: "food_pasta"))
    
    imageOne.contentMode = .scaleAspectFill
    imageTwo.contentMode = .scaleAspectFill
    imageThree.contentMode = .scaleAspectFill
    
    imageOne.clipsToBounds = true
    imageTwo.clipsToBounds = true
    imageThree.clipsToBounds = true
    
    stackView.addArrangedSubview(imageOne)
    stackView.addArrangedSubview(imageTwo)
    stackView.addArrangedSubview(imageThree)
    
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 0
  }
  
  private func setupOverlay() {
    addSubview(overlay)
    
    overlay.translatesAutoresizingMaskIntoConstraints = false
    let top = overlay.topAnchor.constraint(equalTo: stackView.topAnchor)
    let leading = overlay.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
    let bottom = overlay.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
    let trailing = overlay.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    overlay.backgroundColor = .black
    overlay.layer.opacity = 0.6
  }
  
  private func setupWelcomeText() {
    addSubview(welcomeText)
    
    welcomeText.translatesAutoresizingMaskIntoConstraints = false
    let top = welcomeText.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 50)
    let centerX = welcomeText.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
    NSLayoutConstraint.activate([top, centerX])
    
    let attributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.strokeColor: UIColor.black,
      NSAttributedString.Key.strokeWidth: -5.0,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .heavy)
    ]
    welcomeText.attributedText = NSAttributedString(string: "Let's Get Started", attributes: attributes)
  }
  
  private func setupActionText() {
    addSubview(actionText)
    
    actionText.translatesAutoresizingMaskIntoConstraints = false
    let bottom = actionText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    let centerX = actionText.centerXAnchor.constraint(equalTo: centerXAnchor)
    NSLayoutConstraint.activate([bottom, centerX])
    
    let attributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.strokeColor: UIColor.black,
      NSAttributedString.Key.strokeWidth: -5.0,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35, weight: .heavy)
    ]
    actionText.attributedText = NSAttributedString(string: "Touch to HolyWurst", attributes: attributes)
    actionText.isHidden = true
  }
  
  private func setupRedCircle() {
    addSubview(redCircleIV)
    
    redCircleIV.translatesAutoresizingMaskIntoConstraints = false
    let centerX = redCircleIV.centerXAnchor.constraint(equalTo: centerXAnchor)
    let bottom = redCircleIV.bottomAnchor.constraint(equalTo: actionText.topAnchor)
    let width = redCircleIV.widthAnchor.constraint(equalToConstant: 75)
    let height = redCircleIV.heightAnchor.constraint(equalTo: redCircleIV.widthAnchor)
    NSLayoutConstraint.activate([centerX, bottom, width, height])
    
    redCircleIV.contentMode = .scaleAspectFit
    redCircleIV.isHidden = true
  }
  
  // MARK - Public
  
  func reset() {
    welcomeText.isHidden = false
    actionText.isHidden = true
    redCircleIV.isHidden = true
  }
  
  func showNextText() {
    welcomeText.isHidden = true
    actionText.isHidden = false
    redCircleIV.isHidden = false
  }
}
