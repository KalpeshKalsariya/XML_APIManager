//
//  ViewController.swift
//  XM_APIManager
//
//  Created by Kalpesh on 18/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call API
        let params: [String: Any] = ["soap parameter 1": "Hello", "soap parameter 2": "world"]
        loginAPI(params: params) { response, error in
            if let response = response {
                print("Response: \(response)")
            } else if let error = error {
                print("Error: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    // Make a function for call
    func loginAPI(params: [String: Any], block: @escaping (_ response: [String: Any]?, _ error: String?) -> Void) {
        // Example SOAP request message
        let soapMessage = """
            <?xml version="1.0" encoding="utf-8" standalone="no"?>
            <soap:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <soap:Body>
                    
                    <!-- Add your request parameters here -->
            
                </soap:Body>
            </soap:Envelope>
            """
        
        // Specify the endpoint URL for the SOAP service
        guard let endpointURL = URL(string: "https://your-soap-service.com/YourService.asmx") else {
            print("Invalid endpoint URL")
            return
        }
        
        // Make the SOAP API call
        APIManager.shared.makeSOAPRequest(soapMessage: soapMessage, url: endpointURL, method: .post) { result in
            switch result {
            case .success(let data):
                // Parse the XML response
                let parser = XMLParser(data: data)
                let delegate = XMLParserDelegateKK()
                parser.delegate = delegate
                if parser.parse() {
                    // Handle parsed data
                    print("Parsed data:", delegate.parsedData)
                    let parsedData = delegate.parsedData
                    print("Status: \(parsedData["Status"] ?? "")")
                    print("Message: \(parsedData["Message"] ?? "")")
                } else {
                    print("Failed to parse XML")
                }
            case .failure(let error):
                // Handle the failure
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
