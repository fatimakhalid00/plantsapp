import SwiftUI
//هنا الالوان
extension Color {
    static let sheetBG    = Color(red: 28/255, green: 28/255, blue: 30/255)
    static let fieldBG    = Color(red: 44/255, green: 44/255, blue: 46/255)
    static let plantGreen = Color(red: 51/255, green: 128/255, blue: 105/255)
}
//هنا  العنوان
struct ReminderRow: View {
    let icon, title: String
    let options: [String]
    @Binding var selection: String

    var body: some View {
        HStack(spacing: 10) {
            // حجم الأيقونة ولونها الرمادي
            Image(systemName: icon).font(.system(size: 15)).foregroundStyle(.secondary).frame(width: 20)
            // حجم خط العنوان
            Text(title).font(.system(size: 16))
            Spacer()
//الليست هنا
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { Text($0) }
            }
            .labelsHidden().tint(.secondary)
        }
//مسافات الصف من داخل
        .padding(.horizontal, 16).padding(.vertical, 12)
    }
}

// كرت فيه صفين وبينهم خط، وزواياه دائرية
struct Card<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) { content }
            .background(Color.fieldBG)
            .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

// الخط الفاصل بين الصفين داخل الكرت
struct Line: View {
    var body: some View {
        Divider().overlay(Color.white.opacity(0.08)).padding(.horizontal, 16)
    }
}

// هنا الزر الدائري حق التاكيد
func circleButton(_ icon: String, _ color: Color) -> some View {
    Button { } label: {
        Image(systemName: icon)
            .font(.system(size: 15, weight: .semibold))
            .frame(width: 40, height: 40)
            .background(color, in: Circle())
    }
}

struct SetReminderView: View {
//هنا القيم المحفوظة عشان استدعيها على طول
    @State private var plantName = ""
    @State private var room = "Bedroom"
    @State private var light = "Full sun"
    @State private var days = "Every day"
    @State private var water = "20-50 ml"

    var body: some View {
        // المسافة 40 بين كل عنصر والثاني
        VStack(spacing: 40) {

            //  هنا حطيت الهيدر زر إغلاق + العنوان + زر تأكيد
            HStack {
                circleButton("xmark", .fieldBG)
                Spacer()
                Text("Set Reminder").font(.system(size: 16, weight: .semibold))
                Spacer()
                circleButton("checkmark", .plantGreen)
            }

            // حقل اسم النبتة (المؤشر أخضر)
            HStack(spacing: 8) {
                Text("Plant Name").font(.system(size: 16, weight: .medium))
                TextField("Pothos", text: $plantName).font(.system(size: 16)).tint(.plantGreen)
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color.fieldBG, in: Capsule())

            // كرت Room و Light
            Card {
                ReminderRow(icon: "location", title: "Room", options: ["Bedroom", "Kitchen", "Living Room"], selection: $room)
                Line()
                ReminderRow(icon: "sun.max", title: "Light", options: ["Full sun", "Partial shade", "Shade"], selection: $light)
            }

            // كرت Watering Days و Water
            Card {
                ReminderRow(icon: "drop", title: "Watering Days", options: ["Every day", "Every 2 days", "Once a week"], selection: $days)
                Line()
                ReminderRow(icon: "drop", title: "Water", options: ["20-50 ml", "50-100 ml", "100-200 ml"], selection: $water)
            }

            Spacer()
        }
        .foregroundColor(.white)
        // مسافات الشاشة من الأطراف ومن فوق
        .padding(.horizontal, 20).padding(.top, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // خلفية الشيت بزوايا علوية دائرية
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 40, topTrailingRadius: 40)
                .fill(Color.sheetBG).ignoresSafeArea(edges: .bottom)
        )
        .padding(.top, 8)
        // الخلفية السوداء ورا الشيت + الدارك مود
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

#Preview { SetReminderView() }
