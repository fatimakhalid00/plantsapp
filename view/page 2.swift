import SwiftUI

// الزر الدائري (يستخدم للإغلاق وللتأكيد)
// action هو الكود اللي يشتغل لما نضغط الزر
func circleButton(_ icon: String, _ color: Color, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Image(systemName: icon)
            .font(.system(size: 15, weight: .semibold))
            .frame(width: 40, height: 40)
            // تأثير الزجاج (Liquid Glass) بلون الزر، وinteractive يخليه يتجاوب لما نضغطه
            .glassEffect(.regular.tint(color).interactive(), in: .circle)
    }
}

// صفحة إضافة تذكير للنبتة
struct SetReminderView: View {
    // الصفحة تاخذ القيم من الـ ViewModel بدل الـ State
    @Bindable var viewModel: PlantsViewModel
    // عشان نسكر الصفحة
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        // يرتب كل العناصر تحت بعض، والمسافة بينهم 40
        VStack(spacing: 40) {

            // الهيدر: زر إغلاق + العنوان + زر تأكيد
            HStack {
                // زر الإغلاق يسكر الصفحة بدون حفظ
                circleButton("xmark", .fieldBG) {
                    // نعتبر المستخدم بدأ عشان تطلع صفحة No reminders
                    viewModel.hasStarted = true
                    dismiss()
                }
                Spacer()
                Text("Set Reminder").font(.system(size: 16, weight: .semibold))
                Spacer()
                // زر التأكيد يحفظ النبتة ثم يسكر الصفحة
                circleButton("checkmark", .plantGreen) {
                    viewModel.savePlant()
                    dismiss()
                }
                // الزر ما يشتغل ويبهت إذا اسم النبتة فاضي
                .disabled(!viewModel.canSave)
                .opacity(viewModel.canSave ? 1 : 0.4)
            }
            // حقل اسم النبتة
            HStack(spacing: 8) {
                Text("Plant Name").font(.system(size: 16, weight: .medium))
                TextField("Pothos", text: $viewModel.plantName).font(.system(size: 16)).tint(.plantGreen)
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color.fieldBG, in: Capsule())

            // كرت الأول: الغرفة والإضاءة
            Card {
                ReminderRow(icon: "location", title: "Room", options: viewModel.roomOptions, selection: $viewModel.room)
                Line()
                ReminderRow(icon: "sun.max", title: "Light", options: viewModel.lightOptions, selection: $viewModel.light)
            }

            // كرت الثاني: أيام السقي وكمية الماء
            Card {
                ReminderRow(icon: "drop", title: "Watering Days", options: viewModel.daysOptions, selection: $viewModel.days)
                Line()
                ReminderRow(icon: "drop", title: "Water", options: viewModel.waterOptions, selection: $viewModel.water)
            }

            // زر حذف التذكير، يطلع بس لما نعدل نبتة موجودة
            if viewModel.isEditing {
                Button {
                    viewModel.deleteEditingPlant()
                    dismiss()
                } label: {
                    Text("Delete Reminder")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.fieldBG, in: Capsule())
                }
            }

//يخلي كل شي فوق
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
        .background(Color(.systemBackground).ignoresSafeArea())        .preferredColorScheme(.dark)
    }
}

// عرض الصفحة في الـ Preview
// نعطيها ViewModel تجريبي عشان يشتغل الـ Preview
#Preview { SetReminderView(viewModel: PlantsViewModel()) }
