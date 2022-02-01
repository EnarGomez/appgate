//
//  DataManager.swift
//  AppGateTest
//
//  Created by Enar GoMez on 30/01/22.
//

import Foundation
import CoreData

class DataManager {
    
    private let container: NSPersistentContainer!
    
    init() {
        self.container = NSPersistentContainer(name: "AppGateTest")
        startDatabase()
    }
    
    
    /// start the database
    private func startDatabase(){
        self.container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error al iniciar el almacenamiento \(description) - \(error)")
                return
            }
            print("Database iniciada con exito")
        }
    }
    
    
    /// add an user to database
    /// - Parameters:
    ///   - userName: user email
    ///   - password: user password
    ///   - onComplete: callback to notify
    /// - Returns: true if the user was added false for any else
    func registerUser(userName: String, password: String, onComplete: @escaping(_ succeeded: Bool, _ msg: String) -> ()){
        
        let context = container.viewContext
        let user = getUserByName(userName: userName, context: context)
        if let _ = user {
            onComplete(false, "El usuario ya existe")
        }else{
            let user = User(context: context)
            user.use_username = userName
            user.use_password = password
            
            do {
                try context.save()
                onComplete(true, "")
            } catch  {
                onComplete(false, "ocurrio un error al registrar el usuario")
            }
        }
        
        
    }
    
    
    /// register an valitation for an user
    /// - Parameters:
    ///   - userName: user to register
    ///   - latitude: user position latitude
    ///   - longitude: user position longitude
    ///   - date: register date
    ///   - status: register status
    ///   - json: detail for register
    ///   - onComplete: response
    /// - Returns:true if the user was added false for any else
    func registerValidation(userName:String, password:String, latitude: Double, longitude: Double, date: Date, json: String, onComplete: @escaping(_ succeeded: Bool, _ msg: String) -> ()){
        
        let context = container.viewContext
        let userDB = getUserByName(userName: userName, context: context)
        if let user = userDB {
            
            let status = user.use_password?.elementsEqual(password) ?? false
            
            let userValidation = Validation(context: context)
            userValidation.val_latitude = latitude
            userValidation.val_longitude = latitude
            userValidation.val_date = date
            userValidation.val_status = status
            userValidation.val_json = json
            userValidation.user = user
            
            do {
                try context.save()
                if status {
                    onComplete(true, "")
                }else{
                    onComplete(false, "Usuario o contraseña no coinciden")
                }
                
            } catch  {
                onComplete(false, "ocurrio un error al registrar la validacion")
            }
        }else{
            onComplete(false, "usuario no encontrado")
        }
    }
    
    func getValidationsByUser(userName:String, onComplete: @escaping(_ succeeded: Bool, _ msg: String, [Validation]) -> ()){
        
        let context = container.viewContext
        let user = getUserByName(userName: userName, context: context)
        if let userData = user {
            onComplete(true, "", userData.validationArray)
        }else{
            onComplete(false, "usuario no encontrado", [])
        }
        
        
    }
    
    
    /// Get an user bby username
    /// - Parameters:
    ///   - userName: username from user
    ///   - context: app context
    /// - Returns: user if exist or null if it don't exist
    func getUserByName(userName:String, context: NSManagedObjectContext) -> User? {
        
        let userFetch: NSFetchRequest<User> = User.fetchRequest()
        userFetch.predicate = NSPredicate(format: "use_username LIKE %@", userName)
        userFetch.fetchLimit = 1
        
        do {
            if let user = try context.fetch(userFetch).first {
                return user
            }else{
                return nil
            }
        } catch {
            return nil
        }
    }
}
