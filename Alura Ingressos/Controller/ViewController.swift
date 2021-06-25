//
//  ViewController.swift
//  Alura Ingressos
//
//  Created by Eduardo Santos on 24/06/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imagemBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    @IBAction func botaoComprar(_ sender: UIButton) {
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFields)
        
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Parabéns", mensagem: "Compra realizada com sucesso")
            present(alerta, animated: true)
        } else {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Atenção", mensagem: "Preencha corretamente todos os campos")
            
            present(alerta, animated: true)
        }
    }
    
    @IBAction func textFieldCepAlterouValor(_ sender: UITextField) {
        AF.request("https://viacep.com.br/ws/01001000/json/", method: .get).validate().responseJSON { (response) in
            print(response)
        }
    }
    

}

