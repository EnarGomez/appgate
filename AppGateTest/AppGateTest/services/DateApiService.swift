//
//  DateApiService.swift
//  AppGateTest
//
//  Created by Enar GoMez on 30/01/22.
//

import Foundation

struct DateApiService {
    
    //let dateUrl = "http://api.geonames.org/timezoneJSON?formatted=true&lat={1}&lng={2}&username=qa_mobile_easy&style=full"
    
    private func fetchDate(latitude: Double, longitude: Double) -> String {
        return  "http://api.geonames.org/timezoneJSON?formatted=true&lat=\(latitude)&lng=\(longitude)&username=qa_mobile_easy&style=full"
    }
    
    /// Obtiene los datos desde un objeto data y los transforma al modelo ImageInfo
    /// - Parameter date: informacion
    /// - Returns: arreglo de datos
    private func parseJSON(_ dateinfo: Data) -> DateInformation? {
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(DateInformation.self, from: dateinfo)
            return decodeData
        }catch{
            return nil
        }
    }
    
    /// launch request
    /// - Parameters:
    ///   - latitude: latitude description
    ///   - longitude: longitude description
    ///   - onCompletion: response
    /// - Returns: information 
    func fetchRequest(latitude: Double, longitude: Double, onCompletion: @escaping (_ success: Bool, _ data: DateInformation?) ->()) {
        let urlString = fetchDate(latitude: latitude, longitude: longitude)
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url ) { (data, response, error) in
                if error != nil {
                    onCompletion(false, nil)
                }
                
                if let safeData = data {
                    if let objDateInformation = parseJSON(safeData) {
                        onCompletion(true, objDateInformation)
                    }else{
                        onCompletion(false, nil)
                    }
                }
            }
            task.resume()
        }
    }
    
}
