//
//  NJSisVideoListController.swift
//  Pods
//
//  Created by HuXuPeng on 2018/8/10.
//

import UIKit
import NJKit
import MJRefresh
import NJMediator
import NJMediator_NJSisPlayPage

class NJSisVideoListController: NJRefreshTableViewController {
    lazy var sisVideoListViewModel: NJSisVideoListViewModel = NJSisVideoListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nj_isBackActionBtnHidden = true
        self.title = "视频列表"
        self.tableView.separatorStyle = .none
    }
    override func loadData(isMore: Bool) {
        
        sisVideoListViewModel.getVideos(isMore: isMore) {[weak self] (response, hasMore) in
            self?.endHeaderFooterRefreshing()
            
            guard response == nil else{
                print(response?.error)
                return
            }
            
            self?.tableView.reloadData()
            self?.tableView.mj_footer.state = hasMore ? MJRefreshState.idle : MJRefreshState.noMoreData
        }
    }
}

extension NJSisVideoListController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat (sisVideoListViewModel.videoList[indexPath.row].cellHeight);
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sisVideoListViewModel.videoList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NJSisVideoListCell.cell(tableView: tableView)
        cell.sisVideo = sisVideoListViewModel.videoList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let playVc = NJMediator.sharedMediator.Mediator_NJSisPlayPage_PlayController(video: sisVideoListViewModel.videoList[indexPath.row].videoUrl, topicId: sisVideoListViewModel.videoList[indexPath.row].id) {
            self.navigationController?.pushViewController(playVc, animated: true)
        }
    }
}
