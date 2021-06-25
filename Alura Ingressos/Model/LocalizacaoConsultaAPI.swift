//
//  LocalizacaoConsultaAPI.swift
//  Alura Ingressos
//
//  Created by Eduardo Santos on 25/06/21.
//

import UIKit
import Alamofire

class LocalizacaoConsultaAPI: NSObject {

    func consultaViaCepAPI(cep: String, sucesso: @escaping(_ localizacao: Localizacao) -> Void, falha: @escaping(_ error: Error) -> Void) {
        AF.request("https://viacep.com.br/ws/\(cep)/json/", method: .get).validate().responseJSON { (response) in
            switch response.result {
                case let .success(value):
                    if let resultado = value as? [String:String] {
                        let localizacao = Localizacao(resultado)
                        sucesso(localizacao)
                    }
                    break
                case let .failure(error):
                    falha(error)
                    break
            }
        }
    }
}
