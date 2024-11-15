import tkinter as tk
from tkinter import filedialog, messagebox
from PIL import Image, ImageTk
from ocr_processing import extract_text_from_card  # Đây là module OCR của bạn
from export_to_excel import export_to_excel  # Nhập hàm từ file export_to_excel.py

# Hàm xử lý khi người dùng chọn ảnh
def process_image(event=None):
    # Mở hộp thoại để người dùng chọn ảnh
    file_path = filedialog.askopenfilename(title="Chọn ảnh", filetypes=(("Image files", "*.jpg;*.jpeg;*.png"), ("All files", "*.*")))

    if file_path:
        # Trích xuất văn bản từ ảnh
        ocr_results, error = extract_text_from_card(file_path)

        if ocr_results:
            # Cập nhật giao diện với kết quả OCR
            hoten.set(ocr_results.get("Tên", "Không tìm thấy"))
            mssv.set(ocr_results.get("Mã sinh viên", "Không tìm thấy"))
            ngaysinh.set(ocr_results.get("Ngày sinh", "Không tìm thấy"))
            nganh.set(ocr_results.get("Ngành học", "Không tìm thấy"))
            khoa.set(ocr_results.get("Khoa", "Không tìm thấy"))
            khoa_2.set(ocr_results.get("Khóa học", "Không tìm thấy"))

            # In ra kết quả OCR để kiểm tra
            print("Kết quả OCR:")
            print("Tên:", ocr_results.get("Tên", "Không tìm thấy"))
            print("Mã sinh viên:", ocr_results.get("Mã sinh viên", "Không tìm thấy"))
            print("Ngày sinh:", ocr_results.get("Ngày sinh", "Không tìm thấy"))
            print("Ngành học:", ocr_results.get("Ngành học", "Không tìm thấy"))
            print("Khoa:", ocr_results.get("Khoa", "Không tìm thấy"))
            print("Khóa học:", ocr_results.get("Khóa học", "Không tìm thấy"))
            print("\n----------------------\n")

        else:
            messagebox.showerror("Lỗi", error)

        # Hiển thị ảnh kết quả (thu nhỏ)
        image_pil = Image.open(file_path)

        # Thay đổi kích thước ảnh
        image_pil.thumbnail((300, 400))  # Thu nhỏ ảnh với kích thước tối đa là 300x400

        image_tk = ImageTk.PhotoImage(image_pil)

        # Cập nhật ảnh trong giao diện
        image_label.config(image=image_tk)
        image_label.image = image_tk

# Khởi tạo giao diện Tkinter
root = tk.Tk()
root.geometry("1300x770")
root.resizable(width=False, height=False)
root.title("TRÍCH XUẤT THÔNG TIN TỪ THẺ SINH VIÊN")
root.configure(bg='white')

# Giao diện chữ
tentruong = tk.Label(root, text="TRƯỜNG ĐẠI HỌC PHENIKAA", bg='white', font=('Time 25 bold'))
tentruong.pack(side="top")
a = tk.Label(root, text="      ", bg='white', font=('Time 5 bold'))
a.pack(side="top")
khoa = tk.Label(root, text="KHOA CÔNG NGHỆ THÔNG TIN", bg='white', font=('Time 22 bold'))
khoa.pack(side="top")
b = tk.Label(root, text="      ", bg='white', font=('Time 5 bold'))
b.pack(side="top")
hocphan = tk.Label(root, text="HỌC PHẦN THỊ GIÁC MÁY TÍNH", bg='white', font=('Time 20 bold'))
hocphan.pack(side="top")
c = tk.Label(root, text="    ", bg='white', font=('Time 30 bold'))
c.pack(side="top")
doan = tk.Label(root, text="ĐỒ ÁN", bg='white', fg='red', font=('Time 30 bold'))
doan.pack(side="top")
detai = tk.Label(root, text="TRÍCH XUẤT THÔNG TIN TỪ THẺ SINH VIÊN", bg='white', fg='red', font=('Time 30 bold'))
detai.pack(side="top")
kiemtra = tk.Label(root, text="Nếu thông tin chính xác hãy nhấn NHẬP DỮ LIỆU", bg='white', fg='blue', font=('Time 20 bold'))
kiemtra.place(x=630, y=643)
thoigian = tk.Label(root, text="Vui lòng kiểm tra thông tin", bg='white', fg='blue', font=('Time 25 bold'))
thoigian.place(x=740, y=350)

# Giao diện khung chữ (Sắp xếp theo thứ tự mới)
gd_hoten = tk.Label(root, text="Họ và tên:", bg='white', fg='black', font=('Time 18 bold'))
gd_hoten.place(x=745, y=425)

gd_mssv = tk.Label(root, text="MSSV:", bg='white', fg='black', font=('Time 18 bold'))
gd_mssv.place(x=745, y=460)

gd_ngaysinh = tk.Label(root, text="Ngày sinh:", bg='white', fg='black', font=('Time 18 bold'))
gd_ngaysinh.place(x=745, y=495)

gd_nganh = tk.Label(root, text="Ngành học:", bg='white', fg='black', font=('Time 18 bold'))
gd_nganh.place(x=745, y=530)

gd_khoa = tk.Label(root, text="Khoa:", bg='white', fg='black', font=('Time 18 bold'))
gd_khoa.place(x=745, y=565)

gd_khoa_2 = tk.Label(root, text="Khóa:", bg='white', fg='black', font=('Time 18 bold'))
gd_khoa_2.place(x=745, y=600)

# Tạo các biến StringVar() để liên kết dữ liệu với giao diện
hoten = tk.StringVar()
mssv = tk.StringVar()
ngaysinh = tk.StringVar()
nganh = tk.StringVar()
khoa = tk.StringVar()
khoa_2 = tk.StringVar()

# Tạo các label để hiển thị dữ liệu
hoten_label = tk.Label(root, textvariable=hoten, bg='white', fg='black', font=('Time 18'))
hoten_label.place(x=880, y=425)

mssv_label = tk.Label(root, textvariable=mssv, bg='white', fg='black', font=('Time 18'))
mssv_label.place(x=880, y=460)

ngaysinh_label = tk.Label(root, textvariable=ngaysinh, bg='white', fg='black', font=('Time 18'))
ngaysinh_label.place(x=880, y=495)

nganh_label = tk.Label(root, textvariable=nganh, bg='white', fg='black', font=('Time 18'))
nganh_label.place(x=880, y=530)

khoa_label = tk.Label(root, textvariable=khoa, bg='white', fg='black', font=('Time 18'))
khoa_label.place(x=880, y=565)

khoa_2_label = tk.Label(root, textvariable=khoa_2, bg='white', fg='black', font=('Time 18'))
khoa_2_label.place(x=880, y=600)

# Tạo khung để hiển thị ảnh (có thể sử dụng sau này cho việc hiển thị ảnh từ camera)
video_frame = tk.Label(root, bg="gray", width=35, height=20, relief="solid", bd=5)

# Đặt vị trí của khung ảnh tại tọa độ (230, 320) và không cho phép di chuyển nữa
video_frame.place(x=230, y=320)

# Tạo Label để hiển thị ảnh kết quả
image_label = tk.Label(root, bg="white", relief="solid", bd=2)
image_label.place(x=230, y=320, width=300, height=400)

# Cập nhật ảnh khi người dùng chọn ảnh
image_label.bind("<Button-1>", process_image)

# Hàm xử lý khi nhấn button
def handle_export():
    # Thu thập thông tin từ giao diện (giả sử đã dùng StringVar)
    data = {
        "Tên": hoten.get(),
        "Mã sinh viên": mssv.get(),
        "Ngày sinh": ngaysinh.get(),
        "Ngành học": nganh.get(),
        "Khoa": khoa.get(),
        "Khóa học": khoa_2.get()
    }
    export_to_excel(data)

# Button trong giao diện
extract_button = tk.Button(root, text="Trích xuất sang Excel", font=('Time 18 bold'), command=handle_export)
extract_button.place(x=747, y=683)
# Chạy giao diện Tkinter
root.mainloop()
