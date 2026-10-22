//
//  SceneDelegate.swift
//  Todoey
//
//  Created by Julie Alexan on 10/22/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//
import UIKit


final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Move applicationDidBecomeActive UI work here.
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        displaySavedData()
    }
    func sceneWillResignActive(_ scene: UIScene) {
        // Move applicationWillResignActive UI work here.
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        //print(userDefaults.value(forKey: "UserTodoList") as? [String])
        
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Move applicationWillEnterForeground UI work here.
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Move applicationDidEnterBackground UI work here.
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let plistPath = getPath()
        
        if !FileManager.default.fileExists(atPath: plistPath) {
            
            FileManager.default.createFile(atPath: plistPath, contents: nil, attributes: nil)
            
        }
        
        let data:NSMutableDictionary = [:]
        data.setValue("test_Value", forKey: "test_key")
        data.write(toFile: plistPath, atomically: true)
        print(data)
    }
    
    
    func getPath() -> String {
        let plistFileName = "data.plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0] as NSString
        let plistPath = documentPath.appendingPathComponent(plistFileName)
        return plistPath
    }
    
    func displaySavedData() {
        let plistPath = self.getPath()
        if FileManager.default.fileExists(atPath: plistPath) {
            if let savedData = NSMutableDictionary(contentsOfFile: plistPath) {
                print(savedData)
            }
        }
        
    }
}



