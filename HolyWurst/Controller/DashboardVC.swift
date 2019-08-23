//
//  DashboardVC.swift
//  HolyWurst
//
//  Created by Martin Lasek on 23.06.19.
//  Copyright © 2019 Martin Lasek. All rights reserved.
//

import UIKit
import CoreML
import Vision

final class DashboardVC: UIViewController {
  var safeArea: UILayoutGuide!
  
  private let modalView = ModalView()
  
  private let introView = IntroView()
  private let loadingView = LoadingView()
  
  private var imageView = UIImageView()
  private let hotdogView = HotdogView()
  private let notHotdogView = NotHotdogView()
  
  private var classificationRequest: VNCoreMLRequest!

  override func loadView() {
    super.loadView()
    view.backgroundColor = .white
    safeArea = view.layoutMarginsGuide
    
    setupIntroView()
    setupImageView()
    setupLoadingView()
    setupHotdogView()
    setupNotHotdogView()
    setupClassificationRequest()
    
    setupModalView()
  }
  
  // MARK: - Setup View
  
  private func setupModalView() {
    view.addSubview(modalView)

    modalView.translatesAutoresizingMaskIntoConstraints = false
    let top = modalView.topAnchor.constraint(equalTo: view.topAnchor)
    let leading = modalView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let bottom = modalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    let trailing = modalView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    modalView.delegate = self
  }
  
  private func setupIntroView() {
    view.addSubview(introView)
    
    introView.translatesAutoresizingMaskIntoConstraints = false
    let top = introView.topAnchor.constraint(equalTo: view.topAnchor)
    let leading = introView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let bottom = introView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    let trailing = introView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
  }
  
  private func setupImageView() {
    view.addSubview(imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    let top = imageView.topAnchor.constraint(equalTo: view.topAnchor)
    let leading = imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let bottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    let trailing = imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    imageView.contentMode = .scaleAspectFill
  }
  
  private func setupLoadingView() {
    view.addSubview(loadingView)
    
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    let top = loadingView.topAnchor.constraint(equalTo: view.topAnchor)
    let leading = loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let bottom = loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    let trailing = loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    NSLayoutConstraint.activate([top, leading, bottom, trailing])
    
    loadingView.layer.opacity = 0
  }
  
  private func setupHotdogView() {
    view.addSubview(hotdogView)
    
    hotdogView.translatesAutoresizingMaskIntoConstraints = false
    let top = hotdogView.topAnchor.constraint(equalTo: view.topAnchor)
    let leading = hotdogView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let trailing = hotdogView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    let height = hotdogView.heightAnchor.constraint(equalToConstant: 150)
    NSLayoutConstraint.activate([top, leading, trailing, height])
    
    hotdogView.isHidden = true
  }
  
  private func setupNotHotdogView() {
    view.addSubview(notHotdogView)
    
    notHotdogView.translatesAutoresizingMaskIntoConstraints = false
    let bottom = notHotdogView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    let leading = notHotdogView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    let trailing = notHotdogView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    let height = notHotdogView.heightAnchor.constraint(equalToConstant: 150)
    NSLayoutConstraint.activate([bottom, leading, trailing, height])
    
    notHotdogView.isHidden = true
  }
  
  // MARK: - Additional Setup
  
  private func setupClassificationRequest() {
    do {
      let model = try VNCoreMLModel(for: HotdogClassifier().model)
      classificationRequest = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
        self?.processClassifications(for: request, error: error)
      })
      classificationRequest.imageCropAndScaleOption = .centerCrop
    } catch { fatalError("Failed to load Vision ML model: \(error)") }
  }
  
  // MARK: - Gestures
  
  var touchCount = 0
  @objc private func tapHandler(_ gestureRecognizer: UITapGestureRecognizer) {
    if touchCount == 0 {
      introView.showNextText()
      touchCount = touchCount + 1
    } else {
      presentCamera()
    }
  }
  
  @objc private func swipeHandler(_ gestureRecognizer: UISwipeGestureRecognizer) {
    if gestureRecognizer.direction == .down {
      reset()
    }
  }
  
  // MARK: - Private
  
  private func setupGestureRecognizers() {
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
    swipe.direction = .down
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
    view.addGestureRecognizer(swipe)
    view.addGestureRecognizer(tap)
    tap.require(toFail: swipe)
  }
  
  private func reset() {
    imageView.image = nil
    introView.reset()
    touchCount = 0
    hotdogView.isHidden = true
    notHotdogView.isHidden = true
  }
  
  private func presentCamera() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = .camera
    present(picker, animated: true)
  }
  
  private func isHotdog() {
    self.hotdogView.isHidden = false
    self.notHotdogView.isHidden = true
  }
  
  private func isNotHotdog() {
    self.hotdogView.isHidden = true
    self.notHotdogView.isHidden = false
  }
  
  private func isLoading() {
    hotdogView.isHidden = true
    notHotdogView.isHidden = true
    loadingView.layer.opacity = 1.0
  }
  
  private func isNotLoading() {
    self.loadingView.layer.opacity = 0
  }
  
  private func classify(image: UIImage) {
    let orientation = CGImagePropertyOrientation(image.imageOrientation)
    guard let ciImage = CIImage(image: image) else {
      print("Unable to create a CIImage from UIImage")
      return
    }
    
    DispatchQueue.main.async {
      let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
      do { try handler.perform([self.classificationRequest]) }
      catch { print("Failed to perform classification.\n\(error.localizedDescription)") }
    }
  }
  
  private func processClassifications(for request: VNRequest, error: Error?) {
    DispatchQueue.main.async {
      guard let results = request.results else { return }
      
      // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
      let classifications = results as! [VNClassificationObservation]
      if !classifications.isEmpty {
        let topClassifications = classifications[0]
        switch topClassifications.identifier {
        case "hotdog": self.isHotdog()
        default: self.isNotHotdog()
        }
      }
    }
  }
}

extension DashboardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)
    
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      imageView.image = image
      
      isLoading()
      
      Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
        DispatchQueue.main.async { self.isNotLoading() }
        self.classify(image: image)
      }
    }
  }
}

extension DashboardVC: ModalViewDelegate {
  func okAction() {
    UIView.transition(
      with: self.view,
      duration: 0.25,
      options: [.transitionCrossDissolve],
      animations: {self.modalView.removeFromSuperview()}
    )
    
    setupGestureRecognizers()
  }
}
