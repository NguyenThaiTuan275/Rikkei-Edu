from tkinter import *

# Tạo giao diện bằng tkinter
root = Tk()
root.geometry('1300x770')
root.resizable(width=False, height=False)
root.title("TRÍCH XUẤT THÔNG TỪ THẺ SINH VIÊN")
root.configure(bg='white')

# Giao diện chữ
tentruong = Label(root, text="TRƯỜNG ĐẠI HỌC PHENIKAA", bg='white', font=('Time 25 bold'))
tentruong.pack(side=TOP)
a = Label(root, text="      ", bg='white', font=('Time 5 bold'))
a.pack(side=TOP)
khoa = Label(root, text="KHOA CÔNG NGHỆ THÔNG TIN", bg='white', font=('Time 22 bold'))
khoa.pack(side=TOP)
b = Label(root, text="      ", bg='white', font=('Time 5 bold'))
b.pack(side=TOP)
hocphan = Label(root, text="HỌC PHẦN THỊ GIÁC MÁY TÍNH", bg='white', font=('Time 20 bold'))
hocphan.pack(side=TOP)
c = Label(root, text="    ", bg='white', font=('Time 30 bold'))
c.pack(side=TOP)
doan = Label(root, text="ĐỒ ÁN", bg='white', fg='red', font=('Time 30 bold'))
doan.pack(side=TOP)
detai = Label(root, text="TRÍCH XUẤT THÔNG TIN TỪ THẺ SINH VIÊN", bg='white', fg='red', font=('Time 30 bold'))
detai.pack(side=TOP)
kiemtra = Label(root, text="Nếu thông tin chính xác hãy nhấn NHẬP DỮ LIỆU", bg='white', fg='blue', font=('Time 20 bold'))
kiemtra.place(x=630, y=643)
thoigian = Label(root, text="Vui lòng kiểm tra thông tin", bg='white', fg='blue', font=('Time 25 bold'))
thoigian.place(x=740, y=350)

# Giao diện khung chữ (Sắp xếp theo thứ tự mới)
gd_hoten = Label(root, text="Họ và tên:", bg='white', fg='black', font=('Time 18 bold'))
gd_hoten.place(x=745, y=425)

gd_mssv = Label(root, text="MSSV:", bg='white', fg='black', font=('Time 18 bold'))
gd_mssv.place(x=745, y=460)

gd_ngaysinh = Label(root, text="Ngày sinh:", bg='white', fg='black', font=('Time 18 bold'))
gd_ngaysinh.place(x=745, y=495)

gd_nganh = Label(root, text="Ngành học:", bg='white', fg='black', font=('Time 18 bold'))
gd_nganh.place(x=745, y=530)

gd_khoa = Label(root, text="Khoa:", bg='white', fg='black', font=('Time 18 bold'))
gd_khoa.place(x=745, y=565)

gd_khoa_2 = Label(root, text="Khóa:", bg='white', fg='black', font=('Time 18 bold'))
gd_khoa_2.place(x=745, y=600)

# Tạo khung để hiển thị ảnh (có thể sử dụng sau này cho việc hiển thị ảnh từ camera)
video_frame = Label(root, bg="gray", width=35, height=20, relief="solid")

# Đặt vị trí của khung ảnh tại tọa độ (230, 320) và không cho phép di chuyển nữa
video_frame.place(x=230, y=320)

# Nút để bắt đầu trích xuất thông tin
extract_button = Button(root, text="Trích xuất thông tin", font=('Time 18 bold'))
extract_button.place(x=930, y=650)

# Chạy giao diện Tkinter
root.mainloop()
