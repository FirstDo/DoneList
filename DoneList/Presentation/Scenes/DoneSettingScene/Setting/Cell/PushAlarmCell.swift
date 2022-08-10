//
//  PushAlarmCell.swift
//  DoneList
//
//  Created by 김도연 on 2022/08/10.
//

import SwiftUI

struct PushAlarmCell: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct PushAlarmCell_Previews: PreviewProvider {
    static var previews: some View {
        PushAlarmCell()
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.light)
        
        PushAlarmCell()
            .previewLayout(.fixed(width: 400, height: 100))
            .preferredColorScheme(.dark)
    }
}
