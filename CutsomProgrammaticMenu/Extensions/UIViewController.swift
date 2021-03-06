//
//  UIViewController.swift
//  CutsomProgrammaticMenu
//
//  Created by Sherif  Wagih on 9/16/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import UIKit
import SwiftMessages
extension UIViewController
{
    func addSubview(_ view:UIView)
    {
        self.view.addSubview(view)
    }
    /// Show a large `SwiftMessages` message, specifiying a message body and a theme.
    func showMessage(body: String, theme: Theme) {
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: 3)
        config.presentationStyle = .top
        config.presentationContext = .automatic // .window(windowLevel: UIWindowLevelAlert)
        //        config.preferredStatusBarStyle = .lightContent
        
        SwiftMessages.show(config: config) { () -> UIView in // code is always executed on the main queue
            let view = MessageView.viewFromNib(layout: .messageView) // .messageView, .statusLine
            view.configureContent(title: nil, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: { _ in SwiftMessages.hide() })
            view.configureTheme(theme, iconStyle: .light) // info, success, warning, error
            //            view.accessibilityPrefix = "warning"
            view.titleLabel?.isHidden = true
            //            view.iconImageView?.isHidden = true
            //            view.iconLabel?.isHidden = true
            view.button?.isHidden = true
            view.bodyLabel?.font = view.bodyLabel?.font.withSize(14)
            
            return view
        }
    }
    
    /// Show a single line `SwiftMessages` message, specifiying a message body and a theme.
    func showLiteMessage(body: String, theme: Theme) {
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: 2)
        config.presentationStyle = .top
        config.presentationContext = .automatic
        SwiftMessages.show(config: config) { () -> UIView in
            let view = MessageView.viewFromNib(layout: .statusLine)
            view.configureContent(title: nil, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: { _ in SwiftMessages.hide() })
            view.configureTheme(theme, iconStyle: .light)
            view.titleLabel?.isHidden = true
            view.button?.isHidden = true
            return view
        }
    }
    func Authenticate(animated:Bool = true) -> Bool
    {
        if NewUser.getLocallySavedUser() == nil
        {
            let setting = UINavigationController(rootViewController: SettingsVC())
            setting.modalPresentationStyle = .fullScreen
            present(setting, animated: animated, completion: nil)
            return false
        }
        return true
    }
    func adjustNavigationControllers()
    {
        navigationController?.navigationBar.isHidden = true
        guard var navigationArray = self.navigationController?.viewControllers else {return}
        if navigationArray.count > 1
        {
            navigationArray.remove(at: 0)
            self.navigationController?.viewControllers = navigationArray
        }
    }
    func setupTitleView(title:String,comparedTo:UIView? = nil , adjust:Bool = true)
    {
        let titleLabel = UILabel()
        
        titleLabel.text = title.localized()
        
        let titleView = UIView()
        
        if comparedTo == nil
        {
            view.addSubview(titleView)
        }
        else
        {
        view.insertSubview(titleView, belowSubview: comparedTo!)
        }
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "Rectangle 5"))
        
        titleView.addSubview(backgroundImage)
        
        backgroundImage.contentMode = .scaleAspectFill
        
        backgroundImage.clipsToBounds = true
        
        backgroundImage.fillSuperView(padding: .init(top: 0, left: -20, bottom: 0, right: -20))
        
        titleView.anchorToView(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
        
        view.backgroundColor = .white
        
        titleView.addSubview(titleLabel)
        
        titleLabel.textColor = .white
        
        titleLabel.anchorToView(centerH:true,centerV:true)
        
        if adjust
        {
            adjustNavigationControllers()
        }
    }
}
