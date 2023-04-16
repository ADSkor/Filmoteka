//
//  SearchScreenTextFieldView.swift
//  Filmoteka
//
//  Created by Aleksandr Skorotkin on 15.04.2023.
//

import Miji
import UIKit

class SearchScreenTextFieldView: XibView {
    @IBOutlet private weak var separatorView: UIView?
    @IBOutlet private weak var searchButton: UIButton?
    @IBOutlet private weak var textField: UITextField?

    weak var delegate: SearchScreenTextFieldViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchButton?.tintColor = UIColor.black
        textField?.font = UIFont.boldItalicFont(size: 16)
        textField?.returnKeyType = .search
        textField?.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        textField?.delegate = self
        separatorView?.backgroundColor = .systemGray2
    }
    
    func shakeButton() {
        searchButton?.shake()
    }

    func resignFocus() {
        textField?.resignFirstResponder()
    }

    func setFocus() {
        textField?.becomeFirstResponder()
    }

    func set(text: String) {
        textField?.text = text
    }

    @IBAction private func didTap(searchButton _: UIButton?) {
        delegate?.searchScreenTextFieldViewDidTapSearchButton(self, text: textField?.text ?? "")
    }

    @objc private func textDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.searchScreenTextFieldViewTextDidChange(self, text: text)
    }
}

extension SearchScreenTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_: UITextField) {
        delegate?.searchScreenTextFieldViewDidBeginEditing(self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.searchScreenTextFieldViewDidTapSearchButton(self, text: textField.text ?? "")
        return true
    }
}
