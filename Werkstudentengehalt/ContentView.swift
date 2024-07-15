//
//  ContentView.swift
//  Werkstudentengehalt
//
//  Created by Steven Truong on 19.11.23.
//

import SwiftUI

enum Waehrung: String{
    case Brutto
    case Netto
}

struct ContentView: View {
    @State private var stundenlohn: Double? = nil
    @State private var wochenstundenAktiv = 16
    @State private var bruttoNettoAktiv = Waehrung.Brutto
    
    @FocusState private var betragImFokus: Bool
    
    let wochenstunden = [16, 20]
    let bruttoNetto = [Waehrung.Brutto, Waehrung.Netto]
    
    var bruttoGehalt: Double {
        let wochenstundenDouble = Double(wochenstundenAktiv)
        let bruttoSumme = (stundenlohn ?? 0) * wochenstundenDouble * 4
        return bruttoSumme
    }
    var nettoGehalt: Double {
        bruttoGehalt * 0.907
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Betrag in Euro", value: $stundenlohn, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($betragImFokus)
                        } header: {
                            Text("Wie viel Euro pro Stunde?")
                          }
                
                Section {
                    Picker("", selection: $wochenstundenAktiv) {
                        ForEach(wochenstunden, id: \.self) {
                            Text("\($0) Stunden")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Wie viele Stunden in der Woche?")
                  }
                
                Section {
                        Picker("", selection: $bruttoNettoAktiv) {
                            ForEach(bruttoNetto, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    if bruttoNettoAktiv == .Brutto {
                        Text(bruttoGehalt, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                    }
                    else {
                        Text(nettoGehalt, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                    }
                } header: {
                    Text("Brutto- oder Nettogehalt pro Monat?")
                  }
            }
            .navigationTitle("Werkstudentengehalt")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Fertig") {
                        betragImFokus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
