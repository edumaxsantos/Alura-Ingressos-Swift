//
//  Localizacao.swift
//  Alura Ingressos
//
//  Created by Eduardo Santos on 25/06/21.
//

import UIKit

class Localizacao: NSObject {
    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""
    
    init(_ dicionario: [String:String]) {
        self.logradouro = dicionario["logradouro"] ?? ""
        self.bairro = dicionario["bairro"] ?? ""
        self.cidade = dicionario["cidade"] ?? ""
        self.uf = dicionario["uf"] ?? ""
    }
}
