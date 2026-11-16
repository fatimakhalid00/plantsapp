import SwiftUI

// صفحة إضافة تذكير للنبتة
struct SetReminderView: View {
    // الصفحة تاخذ القيم من الـ ViewModel بدل الـ State
    @Bindable var viewModel: PlantsViewModel

    var body: some View {
        // المسافة صفر، وكل مسافة نحددها بنفسنا تحت عشان تطابق Sketch
        VStack(spacing: 0) {

            // الهيدر: زر إغلاق + العنوان + زر تأكيد
            HStack {
                // زر الإغلاق يسكر الصفحة بدون حفظ (المنطق في الـ ViewModel)
                CircleButton(icon: "xmark", color: Color(red: 73/255, green: 73/255, blue: 76/255)) {
                    viewModel.closeSheet()
                }
                Spacer()
                Text("Set Reminder").font(.system(size: 17, weight: .semibold))
                Spacer()
                // زر التأكيد يحفظ النبتة ويسكر الصفحة (المنطق في الـ ViewModel)
                CircleButton(icon: "checkmark", color: .plantGreen) {
                    viewModel.savePlant()
                }
                // الزر ما يشتغل ويبهت إذا اسم النبتة فاضي
                .disabled(!viewModel.canSave)
                .opacity(viewModel.canSave ? 1 : 0.4)
            }
            // مسافة الأزرار من الأطراف ومن فوق الشيت
            .padding(.horizontal, 22)
            .padding(.top, 13)

            // حقل اسم النبتة
            HStack(spacing: 8) {
                Text("Plant Name").font(.system(size: 18, weight: .medium))
                // الكلمة الرمادية Pothos بلون 8E8E93 مثل Sketch
                TextField("", text: $viewModel.plantName, prompt: Text("Pothos").foregroundColor(Color.valueGray))
                    .font(.system(size: 17)).tint(.plantGreen)
            }
            // مسافة النص من داخل الحقل وارتفاعه مثل Sketch
            .padding(.horizontal, 18)
            .frame(height: 56)
            .background(Color.fieldBG, in: Capsule())
            // مسافات الحقل من الأطراف ومن الهيدر
            .padding(.horizontal, 19)
            .padding(.top, 51)

            // كرت الأول: الغرفة والإضاءة
            Card {
                ReminderRow(icon: "location", title: "Room", options: viewModel.roomOptions, selection: $viewModel.room)
                Line()
                ReminderRow(icon: "sun.max", title: "Light", options: viewModel.lightOptions, selection: $viewModel.light)
            }
            // مسافات الكرت من الأطراف ومن حقل الاسم
            .padding(.horizontal, 19)
            .padding(.top, 47)

            // كرت الثاني: أيام السقي وكمية الماء
            Card {
                ReminderRow(icon: "drop", title: "Watering Days", options: viewModel.daysOptions, selection: $viewModel.days)
                Line()
                ReminderRow(icon: "drop", title: "Water", options: viewModel.waterOptions, selection: $viewModel.water)
            }
            // مسافات الكرت من الأطراف ومن الكرت الأول
            .padding(.horizontal, 19)
            .padding(.top, 37)

            // زر حذف التذكير، يطلع بس لما نعدل نبتة موجودة
            if viewModel.isEditing {
                Button {
                    viewModel.deleteEditingPlant()
                } label: {
                    Text("Delete Reminder")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        // لون الزر 2C2C2E وزواياه 26 مثل Sketch
                        .background(Color.fieldBG, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                }
                // مسافات الزر من الأطراف
                .padding(.horizontal, 19)
                // المسافة بين الكرت الثاني وزر الحذف مثل Sketch (67.59 بعد التصغير للجوال)
                .padding(.top, 63)
            }

//يخلي كل شي فوق
            Spacer()
        }
        .foregroundColor(.white)
        // الشيت ياخذ كل الشاشة، والمحتوى يبدأ من فوق
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        // خلفية الشيت بزوايا علوية دائرية مثل Sketch
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 38, topTrailingRadius: 38)
                .fill(Color.sheetBG)
        )
        // المسافة من أعلى الشاشة لين بداية الشيت (68 مثل Sketch)
        .padding(.top, 68)
        // الشيت من حافة الشاشة لحافتها، حتى تحت وفوق
        .ignoresSafeArea()
        // السحب لتحت يسكر الشيت
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.height > 120 {
                    viewModel.closeSheet()
                }
            }
        )
        .preferredColorScheme(.dark)
    }
}

// عرض الصفحة في الـ Preview
// نعطيها ViewModel تجريبي عشان يشتغل الـ Preview
#Preview {
    SetReminderView(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
