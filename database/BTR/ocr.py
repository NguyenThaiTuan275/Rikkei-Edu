import pytesseract
import cv2

# Đặt đường dẫn đến tesseract
pytesseract.pytesseract.tesseract_cmd = r'D:\TGMT_Final\Tesseract\tesseract.exe'

def extract_text(frame):
    # Cắt các vùng cần thiết từ khung hình
    TEN = frame[265:310, 160:350]
    NS = frame[310:340, 166:350]
    NGANH = frame[335:368, 177:370]
    KHOA = frame[365:410, 160:340]
    MSSV = frame[400:440, 160:350]

    # Chuyển đổi các vùng cắt thành ảnh nhị phân
    TEN = cv2.cvtColor(TEN, cv2.COLOR_BGR2GRAY)
    NS = cv2.cvtColor(NS, cv2.COLOR_BGR2GRAY)
    NGANH = cv2.cvtColor(NGANH, cv2.COLOR_BGR2GRAY)
    KHOA = cv2.cvtColor(KHOA, cv2.COLOR_BGR2GRAY)
    MSSV = cv2.cvtColor(MSSV, cv2.COLOR_BGR2GRAY)

    # Áp dụng phép phân ngưỡng
    ret, threshTEN = cv2.threshold(TEN, 55, 255, cv2.THRESH_BINARY_INV)
    ret, threshNS = cv2.threshold(NS, 80, 255, cv2.THRESH_BINARY_INV)
    ret, threshNGANH = cv2.threshold(NGANH, 55, 255, cv2.THRESH_BINARY_INV)
    ret, threshKHOA = cv2.threshold(KHOA, 100, 255, cv2.THRESH_BINARY_INV)
    ret, threshMSSV = cv2.threshold(MSSV, 100, 255, cv2.THRESH_BINARY_INV)

    # Trích xuất văn bản từ các vùng
    text_TEN = pytesseract.image_to_string(threshTEN, lang='vie')
    text_NS = pytesseract.image_to_string(threshNS)
    text_NGANH = pytesseract.image_to_string(threshNGANH, lang='vie')
    text_KHOA = pytesseract.image_to_string(threshKHOA, lang='vie')
    text_MSSV = pytesseract.image_to_string(threshMSSV)

    return text_TEN, text_NS, text_NGANH, text_KHOA, text_MSSV
