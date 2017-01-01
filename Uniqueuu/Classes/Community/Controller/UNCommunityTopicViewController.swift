//
//  UNCommunityTopicViewController.swift
//  Uniqueuu
//
//  Created by huang on 2016/12/31.
//  Copyright © 2016年 BBC6BAE9. All rights reserved.
//

import UIKit

class UNCommunityTopicViewController: UITableViewController {
    
    var type = Int()
    //首页数据列表
    var items = [UNHomeItem]()
    
    var count = Int()
    
    override func viewDidLoad() {
        
        view.backgroundColor = YMGlobalColor()
        setupTableView()
       // 添加刷新控件
        refreshControl = UIRefreshControl()
        refreshControl?.beginRefreshing()
        refreshControl?.addTarget(self, action: #selector(loadHomeData), for: .valueChanged)
        
        // 获取首页数据
        UNNetworkTool.shareNetworkTool.loadHomeInfo(id: type) { [weak self] (homeItems) in
            self?.items = homeItems
            self!.tableView!.reloadData()
            self!.refreshControl?.endRefreshing()
        }
        
    }
    
    func loadHomeData() {
        // 获取首页数据
        UNNetworkTool.shareNetworkTool.loadHomeInfo(id: type) { [weak self] (homeItems) in
            self!.items = homeItems
            
            self!.tableView!.reloadData()
            self!.refreshControl?.endRefreshing()
        }
        
    }
    
    func setupTableView() {
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY + kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: String(describing: YMHomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "homeCellID")
    }
    
}

extension UNCommunityTopicViewController: YMHomeCellDelegate {
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        //        return count
        //        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! YMHomeCell
        homeCell.selectionStyle = .none
        homeCell.delegate = self
        homeCell.bgImageView.image = UIImage(named: "slash")
        homeCell.homeItem = items[indexPath.row]
        
        
        return homeCell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UNDetailViewController()
        detailVC.homeItem = items[indexPath.row]
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }
    // MARK: - YMHomeCellDelegate
    func homeCellDidClickedFavoriteButton(button: UIButton) {
        //        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
        //            let loginVC = YMLoginViewController()
        //            loginVC.title = "登录"
        //            let nav = YMNavigationController(rootViewController: loginVC)
        //            presentViewController(nav, animated: true, completion: nil)
        //        } else {
        //
        //        }
    }
    
    
    //---------------------------------------------------
    //获得图片URL数组
    func urlStringArr() ->[String]
    {
        //字符串数组
        var arr = [String]()
        
        for i in 0 ..< 5
        {
            let urlStr = "http://7xpbws.com1.z0.glb.clouddn.com/JMCarouselViewimg_0\(i+1).png"
            
            arr.append(urlStr)
        }
        return arr
    }
}


