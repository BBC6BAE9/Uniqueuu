//
//  UNLoginViewController.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/18.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit

class UNLoginViewController: UNBaseViewController {
    /// 手机号
    @IBOutlet weak var mobileField: UITextField!
    /// 密码
    @IBOutlet weak var passwordField: UITextField!
    /// 登录按钮
    @IBOutlet weak var loginButton: UIButton!
    /// 忘记密码按钮
    @IBOutlet weak var forgetPwdBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏的左右按钮
        setupBarButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func loginButtonClick(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: isLogin)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 设置导航栏按钮
    private func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(regiisterButtonClick))
    }
    
    /// 取消按钮点击
    func cancelButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    /// 注册按钮点击
    func regiisterButtonClick() {
        let registerVC = UNRegisterViewController()
        registerVC.title = "注册"
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    /// - 其他社交账号登录
    @IBAction func otherLoginButtonClick(sender: UIButton) {
        if let buttonType = YMOtherLoginButtonType(rawValue: sender.tag) {
            switch buttonType {
            case .weiboLogin:
                
                break
            case .weChatLogin:
                
                break
            case .QQLogin:
                
                break
            }
        }
    }
    
}
