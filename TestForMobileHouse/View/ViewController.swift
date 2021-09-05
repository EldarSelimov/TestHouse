//
//  ViewController.swift
//  TestForMobileHouse
//
//  Created by Eldar on 03.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    var networkDataFetcher = NetworkDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        buttonOutlet.layer.cornerRadius = 10
        searchTextField.layer.cornerRadius = 10
        searchTextField.backgroundColor = UIColor(red: 0.965, green: 0.973, blue: 0.992, alpha: 1)
        searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textDidChange(searchTextField)
        searchTextField.delegate = self
    }
    
    @objc func textDidChange(_ textField: UITextField) {
        if searchTextField.text != "" {
            
            buttonOutlet.isEnabled = true
        } else {
            buttonOutlet.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showSecond" else { return }
        guard let destination = segue.destination as? PhotoCollectionViewController else { return }
        destination.searchText = searchTextField.text!
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == " "{
            return false
        }
        return true
    }
}

