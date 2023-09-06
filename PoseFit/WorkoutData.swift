
import Foundation

struct WeeklyWorkoutData: Identifiable {
    let id = UUID()
    let dayOfWeek: Int
    let duration: Int
}
extension WeeklyWorkoutData {
    static let sampleData: [WeeklyWorkoutData] = [
        WeeklyWorkoutData(dayOfWeek: 1, duration: 120),
        WeeklyWorkoutData(dayOfWeek: 2, duration: 180),
       
    ]
}

struct MonthlyWorkoutData {
    var dayOfMonth: Int
    var duration: Int
}
extension MonthlyWorkoutData {
    static let sampleData: [MonthlyWorkoutData] = [
        MonthlyWorkoutData(dayOfMonth: 1, duration: 250),
        MonthlyWorkoutData(dayOfMonth: 2, duration: 350),
       
    ]
}
