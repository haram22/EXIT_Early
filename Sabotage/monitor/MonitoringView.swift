import DeviceActivity
import SwiftUI

struct MonitoringView: View {
    @EnvironmentObject var scheduleVM: ScheduleVM
    
    @State private var context: DeviceActivityReport.Context = .totalActivity
    @State private var filter = DeviceActivityFilter(
        segment: .daily(
            during: Calendar.current.dateInterval(
                of: .day,
                for: .now
            ) ?? DateInterval()
        )
    )

    @State private var selectedDate: Date = Date() // Added this line
    
    var body: some View {
        VStack {
            DeviceActivityReport(context, filter: filter)
                .frame(width: 150, height: 170)
//                .offset(x: 0, y: 150)
                .foregroundColor(.base100) // Changed from .green to .black
                .background(.base100) // Changed from .blue to .black
                .overlay(DeviceActivityReport(context, filter: filter))
                .onAppear {
                    filter = DeviceActivityFilter(
                        segment: .daily(
                            during: Calendar.current.dateInterval(
                                of: .day, for: .now
                            ) ?? DateInterval()
                        ),
                        users: .all,
                        devices: .init([.iPhone]),
                        applications: scheduleVM.selection.applicationTokens,
                        categories: scheduleVM.selection.categoryTokens
                    )
                    
                    // Console에 값을 출력합니다.
                    print("🐥 Current Filter: \(filter)")
                    print("🍀Current Context: \(context)")
                }
                .padding()
                .onChange(of: selectedDate) { newValue in
                    print("🦢Selected Date: \(newValue)")
                    // You can perform actions or notify Main.swift here
                }
        }
//        .frame(maxWidth: 80, maxHeight: 170)
//        .padding()
//        .offset(x: -20, y: 0)

    }
}

//struct MonitoringView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonitoringView()
//    }
//}
