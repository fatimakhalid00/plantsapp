import SwiftUI

struct page3: View {
    // نفس الـ ViewModel اللي تستخدمه باقي الصفحات
    @Bindable var viewModel: PlantsViewModel

    var body: some View {
        // ZStack عشان زر + يطلع فوق القائمة
        ZStack(alignment: .bottomTrailing) {
            // خلفية الشاشة
            Color(.systemBackground)
                .ignoresSafeArea()
            // VStack يرتب العناصر تحت بعض
            VStack(spacing: 0) {
                // العنوان مع الخط
                PageHeader()
                // النص اللي يتغير حسب الإنجاز (في النص)
                Text(viewModel.statusText)
                    .font(.system(size: 16))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)
                // شريط التقدم (أسمك شوي مثل التصميم)
                ProgressView(value: viewModel.progress)
                    .tint(.plantGreen)
                    .scaleEffect(x: 1, y: 2.2, anchor: .center)
                    .padding(.horizontal, 20)
                    .padding(.top, 14)
                    .padding(.bottom, 8)
                // قائمة النباتات
                List {
                    ForEach(viewModel.plants) { plant in
                        // كل صف يعرض نبتة: الدائرة تعلمها، والضغط على الصف يفتح التعديل
                        PlantRow(
                            plant: plant,
                            onToggle: { viewModel.toggleDone(plant) },
                            onEdit: { viewModel.startEditing(plant) }
                        )
                        .listRowBackground(Color.clear)
                        // السحب لليسار يطلع زر الحذف الأحمر
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.deletePlant(plant)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            // زر + يفتح صفحة Set Reminder لإضافة نبتة
            PlusButton {
                viewModel.startAdding()
            }
        }
    }
}

// عرض الصفحة في الـ Preview بدون نباتات
#Preview {
    page3(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
