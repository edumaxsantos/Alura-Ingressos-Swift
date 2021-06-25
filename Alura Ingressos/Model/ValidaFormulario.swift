//
//  ValidaFormulario.swift
//  Alura Ingressos
//
//  Created by Eduardo Santos on 24/06/21.
//

import UIKit
import CPF_CNPJ_Validator

enum TiposDeTextField: Int {
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case cep = 4
    case endereco = 5
    case bairro = 6
    case numeroDoCartao = 7
    case mesDeVencimento = 8
    case anoDeVencimento = 9
    case codigoDeSeguranca = 10
    case numeroDeParcelas = 11
}

class ValidaFormulario: NSObject {

    func verificaTextFieldsPreenchidos(textFields: [UITextField]) -> Bool {
        for textField in textFields {
            if textField.text == "" {
                return false
            }
        }
        return true
    }
    
    func verificaTextFieldsValidos(listaDeTextFields: [UITextField]) -> Bool {
        var dicionarioDeTextFields: [TiposDeTextField:UITextField] = [:]
        
        for textField in listaDeTextFields {
            if let tiposTextField = TiposDeTextField(rawValue: textField.tag) {
                dicionarioDeTextFields[tiposTextField] = textField
            }
        }
        
        guard let cpf = dicionarioDeTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!) else { return false }
        
        return true
        
    }
    
    func exibeNotificacaoDePreenchimentoDosTextFields(titulo: String, mensagem: String) -> UIAlertController {
        let notificacao = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let botao = UIAlertAction(title: "Ok", style: .default, handler: nil)
        notificacao.addAction(botao)
        return notificacao
    }
}
