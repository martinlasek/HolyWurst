//
//  LoadingView.swift
//  HolyWurst
//
//  Created by Martin Lasek on 24.06.19.
//  Copyright © 2019 Martin Lasek. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
  private let overlay = UIView()
  private let spinner = UIImageView(image: UIImage(named: "spinner"))
  private let title = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup View
  
  private func setupView() {
    setupOverlay()
    setupSpinner()
    setupTitle()
  }
  
  private func setupOverlay() {
    addSubview(overlay)
    
    overlay.translatesAutoresizingMaskIntoConstraints = false
    let top = overlay.topAnchor.constraint(equalTo: topAnchor)
    let leading = overlay.leadingAnchor.constraint(equalTo: leadingAnchor)
    let bottom = overlay.bottomAnchor.constraint(equalTo: bottomAnchor)
    let trailing = overlay.trailingAnchor.constraint(equalTo: trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    overlay.backgroundColor = .white
    overlay.layer.opacity = 0.8
  }
  
  private func setupSpinner() {
    addSubview(spinner)
    
    spinner.translatesAutoresizingMaskIntoConstraints = false
    let centerX = spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
    let centerY = spinner.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50)
    let width = spinner.widthAnchor.constraint(equalToConstant: 110)
    let height = spinner.heightAnchor.constraint(equalTo: spinner.widthAnchor)
    NSLayoutConstraint.activate([centerX, centerY, width, height])
    
    spinner.contentMode = .scaleAspectFit
    
    let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.fromValue = 0.0
    rotation.toValue = NSNumber(value: Double.pi * 2)
    rotation.duration = 2
    rotation.repeatCount = .infinity
    rotation.isRemovedOnCompletion = false
    spinner.layer.add(rotation, forKey: nil)
  }
  
  private func setupTitle() {
    addSubview(title)
    
    title.translatesAutoresizingMaskIntoConstraints = false
    let centerX = title.centerXAnchor.constraint(equalTo: centerXAnchor)
    let top = title.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 30)
    NSLayoutConstraint.activate([centerX, top])
    
    let attributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.strokeColor: UIColor.black,
      NSAttributedString.Key.strokeWidth: -5.0,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35, weight: .heavy)
    ]
    title.attributedText = NSAttributedString(string: "Evaluating...", attributes: attributes)
  }
}
