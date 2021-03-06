//
//  ViewController.swift
//  Alura Ingressos
//
//  Created by Eduardo Santos on 24/06/21.
//

import UIKit
import Money


class ViewController: UIViewController, PickerViewMesSelecionado, PickerViewAnoSelecionado, PickerViewNumeroDeParcela {
    
    // MARK: - Outlets
    @IBOutlet weak var imagemBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    @IBOutlet weak var labelValorDasParcelas: UILabel!
    
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    var pickerViewParcela = PickerViewParcela()
    
    var valorDoIngresso: Money<BRL> = 199
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        pickerViewParcela.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func aumentarScrollView(notification: Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + 750)
    }
    
    func buscaTextField(tipoDeTextField: TiposDeTextField, completion: (_ textFieldSolicitado: UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = TiposDeTextField(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
    // MARK: - PickerViewDelegate
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento) { (textFieldMes) in
            textFieldMes.text = mes
        }
    }
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .anoDeVencimento) { (textFieldAno) in
            textFieldAno.text = ano
        }
    }
    
    func pickerViewParcelaSelecionada(parcela: String) {
        self.buscaTextField(tipoDeTextField: .numeroDeParcelas) { (textFieldNumeroDeParcela) in
            textFieldNumeroDeParcela.text = "\(parcela)x"
            let calculoDaParcela = valorDoIngresso * (1 / Double(parcela)!)
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "pt-BR")
            formatter.currencyCode = valorDoIngresso.currency.code
            let valorFormatado = formatter.string(for: calculoDaParcela.amount)
            self.labelValorDasParcelas.text = String(format: "%@x %@ (ou R$199,00 ?? vista)", parcela, valorFormatado!)
        }
    }
    
    // MARK: - Actions
    @IBAction func botaoComprar(_ sender: UIButton) {
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFields)
        
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Parab??ns", mensagem: "Compra realizada com sucesso")
            present(alerta, animated: true)
        } else {
            let alerta = ValidaFormulario().exibeNotificacaoDePreenchimentoDosTextFields(titulo: "Aten????o", mensagem: "Preencha corretamente todos os campos")
            
            present(alerta, animated: true)
        }
    }
    
    @IBAction func textFieldCepAlterouValor(_ sender: UITextField) {
        guard let cep = sender.text else { return }
        LocalizacaoConsultaAPI().consultaViaCepAPI(cep: cep, sucesso: { (localizacao) in
            self.buscaTextField(tipoDeTextField: .endereco, completion: { (textFieldEndereco) in
                textFieldEndereco.text = localizacao.logradouro
            })
            self.buscaTextField(tipoDeTextField: .bairro, completion: { (textFieldBairro) in
                textFieldBairro.text = localizacao.bairro
            })
        }, falha: { (error) in
            print(error.localizedDescription)
        })
    }
    @IBAction func textFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
    }
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        sender.inputView = pickerView
    }
    @IBAction func textFieldCodigoDeSeguranca(_ sender: UITextField) {
        guard let texto = sender.text else { return }
        
        if texto.count < 3 {
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca) { (textFieldCodigoSeguranca) in
                textFieldCodigoSeguranca.text = texto
            }
        }
        
//        if texto.count > 3 {
//            let codigo = texto.suffix(3)
//            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca) { (textFieldCodigoSeguranca) in
//                textFieldCodigoSeguranca.text = String(codigo)
//            }
//        } else {
//            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca) { (textFieldCodigoSeguranca) in
//                textFieldCodigoSeguranca.text = texto
//            }
//        }
    }
    @IBAction func textFieldParcelas(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewParcela
        pickerView.dataSource = pickerViewParcela
        sender.inputView = pickerView
    }
    

}

