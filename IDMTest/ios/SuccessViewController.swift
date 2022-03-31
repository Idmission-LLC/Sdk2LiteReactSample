//
//  SuccessViewController.swift
//  IDentitySample
//
//  Created by Stefan Kaczmarek on 10/17/21.
//

import UIKit
import IDentityLiteSDK
import IDCaptureLite
import SelfieCaptureLite

class SuccessViewController: UIViewController {
    var validateIdResult: ValidateIdResult?                             // 20
    var validateIdMatchFaceResult: ValidateIdMatchFaceResult?           // 10
    var customerEnrollResult: CustomerEnrollResult?                     // 50
    var customerEnrollBiometricsResult: CustomerEnrollBiometricsResult? // 175
    var customerVerificationResult: CustomerVerificationResult?         // 105
    var customerIdentifyResult: CustomerIdentifyResult?                 // 185
    var liveFaceCheckResult: LiveFaceCheckResult?                       // 660

    var frontDetectedData: DetectedData?
    var backDetectedData: DetectedData?

    var texts: String!
    var textObfuscated: String!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // pretty print the request object
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        // first make sure that the ID Front has been detected, if expected
        if validateIdResult != nil ||
            validateIdMatchFaceResult != nil ||
            customerEnrollResult != nil {
            guard frontDetectedData != nil else {
                texts = "ERROR"
                return
            }
        }
      
        if let _ = validateIdResult, var request = IDentitySDK.customerValidateIdRequest {
            // stub out the base64 image text for logging
            request.customerData.idData.idImageFront = "..."
            if request.customerData.idData.idImageBack != nil {
                request.customerData.idData.idImageBack = "..."
            }
            let requestObfuscated = request
          
            if let data = try? encoder.encode(request),
               let json = String(data: data, encoding: .utf8)  {
                texts = json + "\n\n- - -\n\n"
            } else {
                texts = "ERROR"
            }
          
            if let dataObfuscated = try? encoder.encode(requestObfuscated),
               let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                textObfuscated = jsonObfuscated + "\n\n- - -\n\n"
            } else {
                textObfuscated = "ERROR"
            }
        } else if let _ = validateIdMatchFaceResult, var request = IDentitySDK.customerValidateIdFaceMatchRequest {
            // stub out the base64 image texts for logging
            request.customerData.idData.idImageFront = "..."
            if request.customerData.idData.idImageBack != nil {
                request.customerData.idData.idImageBack = "..."
            }
            request.customerData.biometericData.selfie = "..."
            let requestObfuscated = request
          
            if let data = try? encoder.encode(request),
               let json = String(data: data, encoding: .utf8)  {
                texts = json + "\n\n- - -\n\n"
            } else {
                texts = "ERROR"
            }
          
            if let dataObfuscated = try? encoder.encode(requestObfuscated),
               let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                textObfuscated = jsonObfuscated + "\n\n- - -\n\n"
            } else {
                textObfuscated = "ERROR"
            }
        } else if let _ = customerEnrollResult, var request = IDentitySDK.customerEnrollRequest {
            // stub out the base64 image text for logging
            request.customerData.idData.idImageFront = "..."
            if request.customerData.idData.idImageBack != nil {
                request.customerData.idData.idImageBack = "..."
            }
            request.customerData.biometericData.selfie = "..."
            let requestObfuscated = request
          
            if let data = try? encoder.encode(request),
               let json = String(data: data, encoding: .utf8)  {
                texts = json + "\n\n- - -\n\n"
            } else {
                texts = "ERROR"
            }
          
            if let dataObfuscated = try? encoder.encode(requestObfuscated),
               let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                textObfuscated = jsonObfuscated + "\n\n- - -\n\n"
            } else {
                textObfuscated = "ERROR"
            }
        } else if let _ = customerEnrollBiometricsResult, var request = IDentitySDK.customerEnrollBiometricsRequest {
            // stub out the base64 image text for logging
            request.customerData.biometericData.selfie = "..."
            let requestObfuscated = request
          
            if let data = try? encoder.encode(request),
               let json = String(data: data, encoding: .utf8)  {
                texts = json
            } else {
                texts = "ERROR"
            }
          
            if let dataObfuscated = try? encoder.encode(requestObfuscated),
               let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                textObfuscated = jsonObfuscated
            } else {
                textObfuscated = "ERROR"
            }
        } else if let _ = customerVerificationResult, var request = IDentitySDK.customerVerifyRequest {
            // stub out the base64 image text for logging
            request.customerData.biometericData.selfie = "..."
            let requestObfuscated = request
          
            if let data = try? encoder.encode(request),
               let json = String(data: data, encoding: .utf8)  {
                texts = json
            } else {
                texts = "ERROR"
            }
          
            if let dataObfuscated = try? encoder.encode(requestObfuscated),
               let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                textObfuscated = jsonObfuscated
            } else {
                textObfuscated = "ERROR"
            }
        } else if let _ = customerIdentifyResult, var request = IDentitySDK.customerIdentifyRequest {
            // stub out the base64 image text for logging
            request.biometericData.selfie = "..."
            let requestObfuscated = request
          
            if let data = try? encoder.encode(request),
               let json = String(data: data, encoding: .utf8)  {
                texts = json
            } else {
                texts = "ERROR"
            }
          
            if let dataObfuscated = try? encoder.encode(requestObfuscated),
               let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                textObfuscated = jsonObfuscated
            } else {
                textObfuscated = "ERROR"
            }
        } else if let _ = liveFaceCheckResult, var request = IDentitySDK.customerLiveCheckRequest {
            // stub out the base64 image text for logging
            request.customerData.biometericData.selfie = "..."
            let requestObfuscated = request
          
            if let data = try? encoder.encode(request),
               let json = String(data: data, encoding: .utf8)  {
                texts = json
            } else {
                texts = "ERROR"
            }
          
            if let dataObfuscated = try? encoder.encode(requestObfuscated),
               let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                textObfuscated = jsonObfuscated
            } else {
                textObfuscated = "ERROR"
            }
        }

        guard let frontDetectedData = frontDetectedData else { return }
      
        display(detectedData: frontDetectedData, type: frontDetectedData.type ?? "UNKNOWN")
        if let backDetectedData = backDetectedData {
            texts += "\n\n"
            display(detectedData: backDetectedData, type: backDetectedData.type ?? "UNKNOWN")
        } else {
            texts += "\n"
        }
      
        displayObfuscated(detectedData: frontDetectedData, type: frontDetectedData.type ?? "UNKNOWN")
        if let backDetectedData = backDetectedData {
            textObfuscated += "\n\n"
            displayObfuscated(detectedData: backDetectedData, type: backDetectedData.type ?? "UNKNOWN")
        } else {
            textObfuscated += "\n"
        }
      
    }

  override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(false, animated: true)
          navigationItem.setHidesBackButton(true, animated: true)

          navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submit(sender:)))
    
           var obfuscatedText = textObfuscated
           obfuscatedText = obfuscatedText?.replacingOccurrences(of: UserDefaults.defaultPassword, with: "", options: .literal, range: nil)

           let alertController = UIAlertController(title: "Extracted Data", message: obfuscatedText, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
               alertController.dismiss(animated: true, completion: nil)
           }
           alertController.addAction(OKAction)

           let paragraphStyle = NSMutableParagraphStyle()
           paragraphStyle.alignment = NSTextAlignment.left

           let messageText = NSMutableAttributedString(
               string: obfuscatedText ?? "Unable to obfuscate",
               attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)
               ]
           )

           alertController.setValue(messageText, forKey: "attributedMessage")
           self.present(alertController, animated: true, completion: nil)
      }
  
    @objc func submit(sender: Any) {
        let spinner: UIActivityIndicatorView
        if #available(iOS 13, *) {
            spinner = UIActivityIndicatorView(style: .medium)
        } else {
            spinner = UIActivityIndicatorView(style: .gray)
        }
        spinner.startAnimating()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinner)

        if let validateIdResult = validateIdResult {
            validateIdResult.submit { result, hostData in
                self.navigationItem.leftBarButtonItem = nil

                switch result {
                case .success(let response):
                    var hostDataString = ""
                    if let hostData = hostData,
                       let data = try? JSONSerialization.data(withJSONObject: hostData, options: [.prettyPrinted]),
                       let json = String(data: data, encoding: .utf8) {
                        hostDataString = "Host Data:\n\n" + json + "\n\n"
                    }

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json + "\n\n\(hostDataString)- - -\n\n" + self.texts
                    }
                    self.sendData()
                    self.dismiss()
                case .failure(let error):
                    self.texts = error.localizedDescription + "\n\n- - -\n\n" + self.texts
                    self.sendData()
                    self.dismiss()
                }
            }
        } else if let validateIdMatchFaceResult = validateIdMatchFaceResult {
            validateIdMatchFaceResult.submit { result, hostData in
                self.navigationItem.leftBarButtonItem = nil

                switch result {
                case .success(let response):
                    var hostDataString = ""
                    if let hostData = hostData,
                       let data = try? JSONSerialization.data(withJSONObject: hostData, options: [.prettyPrinted]),
                       let json = String(data: data, encoding: .utf8) {
                        hostDataString = "Host Data:\n\n" + json + "\n\n"
                    }

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json + "\n\n\(hostDataString)- - -\n\n" + self.texts
                    }
                    self.sendData()
                    self.dismiss()
                case .failure(let error):
                    self.texts = error.localizedDescription + "\n\n- - -\n\n" + self.texts
                    self.sendData()
                    self.dismiss()
                }
            }
        } else if let customerEnrollResult = customerEnrollResult {
            customerEnrollResult.submit { result, hostData in
                self.navigationItem.leftBarButtonItem = nil

                switch result {
                case .success(let response):
                    var hostDataString = ""
                    if let hostData = hostData,
                       let data = try? JSONSerialization.data(withJSONObject: hostData, options: [.prettyPrinted]),
                       let json = String(data: data, encoding: .utf8) {
                        hostDataString = "Host Data:\n\n" + json + "\n\n"
                    }

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json + "\n\n\(hostDataString)- - -\n\n" + self.texts
                    }
                    self.sendData()
                    self.dismiss()
                case .failure(let error):
                    self.texts = error.localizedDescription + "\n\n- - -\n\n" + self.texts
                    self.sendData()
                    self.dismiss()
                }
            }
        } else if let customerEnrollBiometricsResult = customerEnrollBiometricsResult {
            customerEnrollBiometricsResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil

                switch result {
                case .success(let response):
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json + "\n\n- - -\n\n" + self.texts
                    }
                    self.sendData()
                    self.dismiss()
                case .failure(let error):
                    self.texts = error.localizedDescription + "\n\n- - -\n\n" + self.texts
                    self.sendData()
                    self.dismiss()
                }
            }
        } else if let customerVerificationResult = customerVerificationResult {
            customerVerificationResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil

                switch result {
                case .success(var response):
                    // stub out the base64 image text for logging
                    response.responseCustomerVerifyData?.extractedPersonalData?.enrolledFaceImage = "..."

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json + "\n\n- - -\n\n" + self.texts
                    }
                    self.sendData()
                    self.dismiss()
                case .failure(let error):
                    self.texts = error.localizedDescription + "\n\n- - -\n\n" + self.texts
                    self.sendData()
                    self.dismiss()
                }
            }
        } else if let customerIdentifyResult = customerIdentifyResult {
            customerIdentifyResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil

                switch result {
                case .success(var response):
                    // stub out the base64 image text for logging
                    response.responseCustomerData?.extractedPersonalData?.enrolledFaceImage = "..."

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json + "\n\n- - -\n\n" + self.texts
                    }
                    self.sendData()
                    self.dismiss()
                case .failure(let error):
                    self.texts = error.localizedDescription + "\n\n- - -\n\n" + self.texts
                    self.sendData()
                    self.dismiss()
                }
            }
        } else if let liveFaceCheckResult = liveFaceCheckResult {
            liveFaceCheckResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil

                switch result {
                case .success(let response):
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json + "\n\n- - -\n\n" + self.texts
                    }
                    self.sendData()
                    self.dismiss()
                case .failure(let error):
                    self.texts = error.localizedDescription + "\n\n- - -\n\n" + self.texts
                    self.sendData()
                    self.dismiss()
                }
            }
        }
    }

  private func sendData() {
    let dict2:NSMutableDictionary? = ["data" : self.texts ?? ["data" : "error"]]
    let iDMissionSDK = IDMissionSDK()
    iDMissionSDK.getEvent2("DataCallback", dict: dict2 ?? ["data" : "error"])
  }
  
  private func display(detectedData data: DetectedData, type: String) {
        texts += type + "\n\n"

        texts += "Photo Present: "
        texts += data.shouldHavePhoto ? (data.isPhotoPresent ? "YES" : "NO") : "N/A"
        texts += "\n\n"

        texts += "MRZ Present: "
        if data.shouldHaveMrz || data.mrz != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            if let mrz = data.mrz,
               let jsonData = try? encoder.encode(mrz),
               let json = String(data: jsonData, encoding: .utf8) {
               texts += "\n\n"
               texts += json
            } else {
               texts += "NO"
            }
        } else {
           texts += "N/A"
        }
        texts += "\n\n"

        texts += "Barcode Present: "
        if data.shouldHaveBarcode || data.barcode != nil {
            if let barcode = data.barcode {
               texts += "\n\n"
                for key in barcode.keys {
                    if let value = barcode[key] {
                      texts += "\(key): \(value)\n"
                    }
                }
            } else {
               texts += "NO"
            }
        } else {
           texts += "N/A"
        }
    }

  private func displayObfuscated(detectedData data: DetectedData, type: String) {
        textObfuscated += type + "\n\n"

        textObfuscated += "Photo Present: "
        textObfuscated += data.shouldHavePhoto ? (data.isPhotoPresent ? "YES" : "NO") : "N/A"
        textObfuscated += "\n\n"

        textObfuscated += "MRZ Present: "
        if data.shouldHaveMrz || data.mrz != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            if let mrz = data.mrz,
               let jsonData = try? encoder.encode(mrz),
               let json = String(data: jsonData, encoding: .utf8) {
                textObfuscated += "\n\n"
                textObfuscated += json
            } else {
                textObfuscated += "NO"
            }
        } else {
            textObfuscated += "N/A"
        }
        textObfuscated += "\n\n"

        textObfuscated += "Barcode Present: "
        if data.shouldHaveBarcode || data.barcode != nil {
            if let barcode = data.barcode {
                textObfuscated += "\n\n"
                for key in barcode.keys {
                    if let value = barcode[key] {
                      textObfuscated += "\(key): \(value)\n"
                    }
                }
            } else {
                textObfuscated += "NO"
            }
        } else {
            textObfuscated += "N/A"
        }
    }
  
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
