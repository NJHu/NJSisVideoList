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
        let topic = sisVideoListViewModel.videoList[indexPath.row];
        if let playVc = NJMediator.sharedMediator.Mediator_NJSisPlayPage_PlayController(video: topic.videoUrl, topicId: topic.id, videoSize: CGSize(width: topic.width, height: topic.height)) {
            self.navigationController?.pushViewController(playVc, animated: true)
        }
    }
}
