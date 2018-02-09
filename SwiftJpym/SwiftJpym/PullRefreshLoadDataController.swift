
//
//  PullRefreshLoadDataController.swift
//  SwiftJpym
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 liushuang.library. All rights reserved.
//

import UIKit

class PullRefreshLoadDataController: UITableViewController{
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    var emojiData = [String]()
    let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshController
        } else {
            // Fallback on earlier versions
        }
        emojiData = favoriteEmoji;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.refreshController.addTarget(self, action: "didRoadEmoji", for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didRoadEmoji() {
        let workingQueue = DispatchQueue(label: "my_queue")
        
        // 派发到刚创建的队列中，GCD 会负责进行线程调度
        workingQueue.async() {
            // 在 workingQueue 中异步进行
            Thread.sleep(forTimeInterval: 2.0) // 模拟两秒的执行时间
            
            DispatchQueue.main.async() {
                // 返回到主线程更新 UI
                self.emojiData = self.newFavoriteEmoji
                self.tableView.reloadData()
                self.refreshController.endRefreshing()
            }
        }
    }
}
//MARK: - delegate
extension PullRefreshLoadDataController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
//MARK: - datasource
extension PullRefreshLoadDataController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteEmoji.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel!.text = self.emojiData[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel!.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell;
    }
}


