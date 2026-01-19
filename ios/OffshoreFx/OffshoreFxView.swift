//
//  OffshoreFxView.swift
//  Runner
//
//  Created by Saulo Nascimento on 17/01/26.
//

import UIKit

public protocol OffshoreFxCallback: AnyObject {
    func onSuccess(data: [String: Any])
    func onError(errorMessage: String)
    func onPaused()
}


public class OffshoreFxView: UIView {
    
    public weak var callback: OffshoreFxCallback?
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Offshore FX"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Converta seus ativos agora"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Valor em USD"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let convertButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Simular Conversão", for: .normal)
        btn.backgroundColor = UIColor(red: 0.0, green: 0.78, blue: 0.32, alpha: 1.0) // #00C853
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // MARK: - Botões de Callback
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func initWithData(_ model: OffshoreFxModel) {
        titleLabel.text = "Conta: \(model.accountNumber)"
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .white
        
        // Adicionar Views
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(amountTextField)
        addSubview(convertButton)
        addSubview(stackView)
        
        setupStackViewButtons()
        setupConstraints()
        setupActions()
    }
    
    private func setupStackViewButtons() {
        let btnSuccess = createCallbackButton(title: "Success", color: .systemBlue, action: #selector(didTapSuccess))
        let btnError = createCallbackButton(title: "Error", color: .systemRed, action: #selector(didTapError))
        let btnPaused = createCallbackButton(title: "Paused", color: .systemOrange, action: #selector(didTapPaused))
        
        stackView.addArrangedSubview(btnSuccess)
        stackView.addArrangedSubview(btnError)
        stackView.addArrangedSubview(btnPaused)
    }
    
    private func createCallbackButton(title: String, color: UIColor, action: Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = color
        btn.layer.cornerRadius = 4
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            amountTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            amountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),
            
            convertButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 24),
            convertButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            convertButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            convertButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: convertButton.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func setupActions() {
        convertButton.addTarget(self, action: #selector(didTapConvert), for: .touchUpInside)
    }
    
    
    @objc private func didTapConvert() {
        guard let text = amountTextField.text, let amount = Double(text) else {
            print("Valor inválido")
            return
        }
        // Simulação igual ao Android
        let result = amount * 5.0
        print("Convertendo \(amount) USD -> R$ \(result)")
    }
    
    
    @objc private func didTapSuccess() {
        callback?.onSuccess(data: ["status": "Operação realizada com sucesso no iOS"])
    }
    
    @objc private func didTapError() {
        callback?.onError(errorMessage: "Falha na conexão iOS")
    }
    
    @objc private func didTapPaused() {
        callback?.onPaused()
    }
    
    public func initWithData(accountHolder: String, balance: Double, currency: String) {
        titleLabel.text = "Olá, \(accountHolder)"
        subtitleLabel.text = "Saldo disponível: \(currency) \(balance)"
        amountTextField.text = "\(balance)"
    }
    
}
