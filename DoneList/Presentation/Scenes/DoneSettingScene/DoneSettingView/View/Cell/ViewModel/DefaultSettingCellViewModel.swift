//
//  DefaultSettingCellViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

protocol DefaultSettingCellViewModelInput { }

protocol DefaultSettingCellViewModelOutput {
    var item: Content { get }
}

protocol DefaultSettingCellViewModelType: DefaultSettingCellViewModelInput, DefaultSettingCellViewModelOutput { }

final class DefaultSettingCellViewModel: DefaultSettingCellViewModelType {
    
    private let contents = [
        Content(imageName: "star", titleName: "별점 남기기"),
        Content(imageName: "swift", titleName: "오픈 소스 라이센스")
    ]
    
    // MARK: - Output
    
    let item: Content
    
    init(row: Int) {
        self.item = contents[row]
    }
}
