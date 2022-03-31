//
//  ViewController.swift
//  IDentitySample
//
//  Created by Stefan Kaczmarek on 8/29/21.
//

import UIKit
import IDentityLiteSDK
import IDCaptureLite
import SelfieCaptureLite

extension AdditionalCustomerWFlagCommonData {
    init(serviceOptions options: ServiceOptions) {
        let manualReviewRequired: AdditionalCustomerWFlagCommonData.ManualReviewRequired
        switch options.manualReviewRequired {
        case .yes: manualReviewRequired = .yes
        case .no: manualReviewRequired = .no
        case .forced: manualReviewRequired = .forced
        }

        self = AdditionalCustomerWFlagCommonData(manualReviewRequired: manualReviewRequired,
                                                 bypassAgeValidation: options.bypassAgeValidation ? .yes : .no,
                                                 deDuplicationRequired: options.deDuplicationRequired ? .yes : .no,
                                                 bypassNameMatching: options.bypassNameMatching ? .yes : .no,
                                                 postDataAPIRequired: options.postDataAPIRequired ? .yes : .no,
                                                 sendInputImagesInPost: options.sendInputImagesInPost ? .yes : .no,
                                                 sendProcessedImagesInPost: options.sendProcessedImagesInPost ? .yes : .no,
                                                 needImmediateResponse: options.needImmediateResponse ? .yes : .no,
                                                 deduplicationSynchronous: options.deduplicationSynchronous ? .yes : .no,
                                                 verifyDataWithHost: options.verifyDataWithHost ? .yes : .no,
                                                 idBackImageRequired: options.idBackImageRequired ? .yes : .no,
                                                 stripSpecialCharacters: options.stripSpecialCharacters ? .yes : .no)
    }
}

extension AdditionalCustomerEnrollBiometricRequestData {
    init(serviceOptions options: ServiceOptions) {
        self = AdditionalCustomerEnrollBiometricRequestData(needImmediateResponse: options.needImmediateResponse ? .yes : .no,
                                                            deDuplicationRequired: options.deDuplicationRequired ? .yes : .no)
    }
}

class ViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IDCapture.isDebugMode = UserDefaults.debugMode
        SelfieCapture.isDebugMode = UserDefaults.debugMode
        IDCapture.capture4K = UserDefaults.capture4K
        SelfieCapture.capture4K = UserDefaults.capture4K
    }

    // MARK: - IBAction Methods

    // 20 - ID Validation
    func startIDValidation(instance: UIViewController) {
        // start ID capture, presenting it from this view controller
      let options = AdditionalCustomerWFlagCommonData(serviceOptions: UserDefaults.serviceOptions)
      showCaptureBackPrompt(instance: instance) { captureBack in
          // start ID capture, presenting it from this view controller
        IDentitySDK.idValidation(from: instance, options: options, captureBack: captureBack) { result in
            switch result {
            case .success(let validateIdResult):
              let successViewController = SuccessViewController()
              successViewController.validateIdResult = validateIdResult
              successViewController.frontDetectedData = validateIdResult.front
              successViewController.backDetectedData = validateIdResult.back
              let navigationController = UINavigationController(rootViewController: successViewController)
              instance.present(navigationController, animated: true)
            case .failure(let error):
              print(error.localizedDescription)
              self.sendData(text: error.localizedDescription)
            }
        }
      }
    }
  
    // 10 - ID Validation and Match Face
    func startIDValidationAndMatchFace(instance: UIViewController) {
        let options = AdditionalCustomerWFlagCommonData(serviceOptions: UserDefaults.serviceOptions)
        showCaptureBackPrompt(instance: instance) { captureBack in
          IDentitySDK.idValidationAndMatchFace(from: instance, options: options, captureBack: captureBack) { result in
              switch result {
              case .success(let validateIdMatchFaceResult):
                let successViewController = SuccessViewController()
                successViewController.validateIdMatchFaceResult = validateIdMatchFaceResult
                successViewController.frontDetectedData = validateIdMatchFaceResult.front
                successViewController.backDetectedData = validateIdMatchFaceResult.back
                let navigationController = UINavigationController(rootViewController: successViewController)
                instance.present(navigationController, animated: true)
              case .failure(let error):
                print(error.localizedDescription)
                self.sendData(text: error.localizedDescription)
              }
          }
        }
    }

    // 50 - ID Validation And Customer Enroll
      func startIDValidationAndCustomerEnroll(uniqueNumber: String, instance: UIViewController) {
          let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
          let options = AdditionalCustomerWFlagCommonData(serviceOptions: UserDefaults.serviceOptions)
          showCaptureBackPrompt(instance: instance) { captureBack in
            IDentitySDK.idValidationAndCustomerEnroll(from: instance, personalData: personalData, options: options, captureBack: captureBack) { result in
                switch result {
                case .success(let customerEnrollResult):
                  let successViewController = SuccessViewController()
                  // set the customer's unique number
                  successViewController.customerEnrollResult = customerEnrollResult
                  successViewController.frontDetectedData = customerEnrollResult.front
                  successViewController.backDetectedData = customerEnrollResult.back
                  let navigationController = UINavigationController(rootViewController: successViewController)
                  instance.present(navigationController, animated: true, completion: nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.sendData(text: error.localizedDescription)
                }
            }
          }
      }
  
    // 175 - Customer Enroll Biometrics
    func startCustomerEnrollBiometrics(uniqueNumber: String, instance: UIViewController) {
        let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
        let options = AdditionalCustomerEnrollBiometricRequestData(serviceOptions: UserDefaults.serviceOptions)
        IDentitySDK.customerEnrollBiometrics(from: instance, personalData: personalData, options: options) { result in
            switch result {
            case .success(let customerEnrollBiometricsResult):
                // pass the API request to the success view controller
                let successViewController = SuccessViewController()
                successViewController.customerEnrollBiometricsResult = customerEnrollBiometricsResult
                let navigationController = UINavigationController(rootViewController: successViewController)
                instance.present(navigationController, animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(text: error.localizedDescription)
            }
        }
    }

    // 105 - Customer Verification
    func startCustomerVerification(uniqueNumber: String, instance: UIViewController) {
        let personalData = PersonalCustomerVerifyData(uniqueNumber: uniqueNumber)
        IDentitySDK.customerVerification(from: instance, personalData: personalData) { result in
            switch result {
            case .success(let customerVerificationResult):
                // pass the API request to the success view controller
                let successViewController = SuccessViewController()
                successViewController.customerVerificationResult = customerVerificationResult
                let navigationController = UINavigationController(rootViewController: successViewController)
                instance.present(navigationController, animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(text: error.localizedDescription)
            }
        }
    }

    // 185 - Identify Customer
    func startIdentifyCustomer(instance: UIViewController) {
        IDentitySDK.identifyCustomer(from: instance) { result in
            switch result {
            case .success(let customerIdentifyResult):
                // pass the API request to the success view controller
                    let successViewController = SuccessViewController()
                    successViewController.customerIdentifyResult = customerIdentifyResult
                    let navigationController = UINavigationController(rootViewController: successViewController)
                    instance.present(navigationController, animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(text: error.localizedDescription)
            }
        }
    }

    // 660 - Live Face Check
    func startLiveFaceCheck(instance: UIViewController) {
        // start selfie capture, presenting it from this view controller
        IDentitySDK.liveFaceCheck(from: instance) { result in
            switch result {
            case .success(let liveFaceCheckResult):
                // pass the API request to the success view controller
                    let successViewController = SuccessViewController()
                    successViewController.liveFaceCheckResult = liveFaceCheckResult
                    let navigationController = UINavigationController(rootViewController: successViewController)
                    instance.present(navigationController, animated: true, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(text: error.localizedDescription)
            }
        }
    }

    private func showCaptureBackPrompt(instance: UIViewController, completion: @escaping BoolCompletion) {
        // first prompt the user to select if capturing a 2-sided ID
        let alert = UIAlertController(title: "Capture Back?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default) { _ in completion(false) })
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in completion(true) })
        instance.present(alert, animated: true)
    }
  
    private func sendData(text: String) {
      let dict2:NSMutableDictionary? = ["data" : text ]
      let iDMissionSDK = IDMissionSDK()
      iDMissionSDK.getEvent2("DataCallback", dict: dict2 ?? ["data" : "error"])
    }
}
