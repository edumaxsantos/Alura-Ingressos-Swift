//
//  PickerViewAno.swift
//  Alura Ingressos
//
//  Created by Eduardo Santos on 26/06/21.
//

import UIKit
protocol PickerViewAnoSelecionado {
    func anoSelecionado(ano: String)
}

class PickerViewAno: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let listaDeAnos = ["21", "22", "23", "24", "25"]
    var delegate: PickerViewAnoSelecionado?

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaDeAnos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let anoAtual = listaDeAnos[row]
        return anoAtual
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.anoSelecionado(ano: self.listaDeAnos[row])
        }
    }
    
}
