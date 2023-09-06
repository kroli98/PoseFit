import SwiftUI
import CoreData
import Charts


struct WeeklyChartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var currentDate = Date()
    @State  var weeklyData: [WeeklyWorkoutData] = []
    @State var currentChartId: Int?
    @State var totalWorkouts = 0
    @State var totalDuration = 0

    var body: some View {
      
        VStack {
                   Text("Heti edzési időtartamok")
                       .font(.headline)

                   HStack {
                       Button(action: {
                           changeWeek(by: -1)
                       }) {
                           Image(systemName: "chevron.left")
                       }

                       Chart {
                                         ForEach(1...7, id: \.self) { day in
                                             let dayData = weeklyData.first(where: { $0.dayOfWeek == day })
                                             BarMark(
                                                 x: .value("A hét napjai", dayOfWeekString(from: day)),
                                                 y: .value("Időtartam", dayData?.duration ?? 0)
                                             )
                                         }
                                     }
                                     .chartYAxis {
                                         AxisMarks(preset: .aligned, position: .leading)
                                     }
                          

                       Button(action: {
                           changeWeek(by: 1)
                       }) {
                           Image(systemName: "chevron.right")
                       }
                   }

                   HStack {
                       Text("\(totalWorkouts) edzés")
                       Rectangle()
                           .frame(width: 2)
                           .foregroundColor(.gray)
                           .padding(.horizontal, 10)
                       Text("\(totalDuration) perc")
                   }
                   .frame(maxHeight: 30)
                   .padding(.horizontal,50)
                   .padding(.bottom)
               }
               .onAppear {
                   fetchData(forWeekContaining: currentDate)
                   totalWorkouts = getTotalWorkouts()
                   totalDuration = getTotalDuration()
                  
               }
    }
    
    private func getTotalWorkouts() -> Int {
          return weeklyData
            .compactMap { $0 }
              .filter { $0.duration > 0 }
              .count
      }
    private func getTotalDuration() -> Int {
        return weeklyData.compactMap { $0 }.reduce(0) { $0 + $1.duration }
       }
    private func changeWeek(by offset: Int) {
          let calendar = Calendar.current
          if let newDate = calendar.date(byAdding: .weekOfYear, value: offset, to: currentDate) {
              currentDate = newDate.startOfWeek(using: calendar)
              fetchData(forWeekContaining: currentDate)
              totalWorkouts = getTotalWorkouts()
              totalDuration = getTotalDuration()
              
          }
      }
    func dayOfWeekString(from day: Int) -> String {
         let calendar = Calendar.current
         let desiredDate = calendar.date(byAdding: .day, value: day - 1, to: currentDate.startOfWeek(using: calendar))!
         let formatter = DateFormatter()
         formatter.locale = Locale(identifier: "hu_HU")
         formatter.dateFormat = "EEE"
         return formatter.string(from: desiredDate)
     }

    private func getWeek() -> Date {
        let calendar = Calendar.current
        let currentWeekStart = currentDate.startOfWeek(using: calendar)
     
        return  currentWeekStart
    }

    private func fetchData(forWeekContaining date: Date) {
        let weekStart = getWeek()
          
                fetchData(for: weekStart)
            
        
    }

    private func fetchData(for startDate: Date) {
        var data: [WeeklyWorkoutData] = []
        let endDate = Calendar.current.date(byAdding: .day, value: 6, to: startDate)!
        
        let fetchRequest: NSFetchRequest<CompletedExercise> = CompletedExercise.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as NSDate, endDate as NSDate)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CompletedExercise.date, ascending: true)]

        do {
            let results = try viewContext.fetch(fetchRequest)
            for day in 1...7 {
                let dayDate = Calendar.current.date(byAdding: .day, value: day - 1, to: startDate)!
                let filteredExercises = results.filter {
                    Calendar.current.isDate($0.date ?? Date(), inSameDayAs: dayDate)
                }
                let totalDuration = filteredExercises.reduce(0) { $0 + Int($1.elapsedExerciseTime) }
                data.append(WeeklyWorkoutData(dayOfWeek: day, duration: totalDuration / 60))
            }
        } catch {
            print("Error fetching data: \(error)")
        }

        weeklyData = data
    }
}


struct WeeklyChartView_Previews: PreviewProvider {
    static var previews: some View {
      
        return WeeklyChartView()
    }
}

extension Date {
    func startOfWeek(using calendar: Calendar) -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components)!
    }
}
