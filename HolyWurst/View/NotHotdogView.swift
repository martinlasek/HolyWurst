//
//  HotdogView.swift
//  HolyWurst
//
//  Created by Martin Lasek on 23.06.19.
//  Copyright © 2019 Martin Lasek. All rights reserved.
//

import UIKit

final class NotHotdogView: UIView {
  let container = UIView()
  let circle = UIView()
  let title = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup View
  
  private func setupView() {
    setupContainer()
    setupCircle()
    setupTitle()
  }
  
  private func setupContainer() {
    addSubview(container)
    
    container.translatesAutoresizingMaskIntoConstraints = false
    let top = container.topAnchor.constraint(equalTo: topAnchor, constant: 50)
    let leading = container.leadingAnchor.constraint(equalTo: leadingAnchor)
    let bottom = container.bottomAnchor.constraint(equalTo: bottomAnchor)
    let trailing = container.trailingAnchor.constraint(equalTo: trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    container.backgroundColor = .newRed
  }
  
  private func setupCircle() {
    container.addSubview(circle)
    
    circle.translatesAutoresizingMaskIntoConstraints = false
    let centerX = circle.centerXAnchor.constraint(equalTo: centerXAnchor)
    let top = circle.topAnchor.constraint(equalTo: topAnchor)
    let height = circle.heightAnchor.constraint(equalToConstant: 100)
    let width = circle.widthAnchor.constraint(equalToConstant: 100)
    NSLayoutConstraint.activate([centerX, top, height, width])
    
    circle.backgroundColor = .newRed
    circle.layer.cornerRadius = 50
    
    let image = UIImage(named: "not_hotdog")
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    
    circle.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let ivCenterX = imageView.centerXAnchor.constraint(equalTo: circle.centerXAnchor)
    let ivCenterY = imageView.centerYAnchor.constraint(equalTo: circle.centerYAnchor, constant: -10)
    let ivWidth = imageView.widthAnchor.constraint(equalTo: circle.widthAnchor, multiplier: 0.5)
    let ivHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
    NSLayoutConstraint.activate([ivCenterX, ivCenterY, ivHeight, ivWidth])
  }
  
  private func setupTitle() {
    container.addSubview(title)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    let centerX = title.centerXAnchor.constraint(equalTo: container.centerXAnchor)
    let centerY = title.centerYAnchor.constraint(equalTo: container.centerYAnchor)
    NSLayoutConstraint.activate([centerX, centerY])
    
    let attributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.strokeColor: UIColor.black,
      NSAttributedString.Key.strokeWidth: -5.0,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50, weight: .heavy)
    ]
    title.attributedText = NSAttributedString(string: "Not hotdog", attributes: attributes)
  }
}
