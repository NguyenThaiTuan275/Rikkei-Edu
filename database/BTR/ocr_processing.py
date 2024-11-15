import cv2
import easyocr
import numpy as np
import dlib

# Cài đặt dlib cho phát hiện khuôn mặt
detector = dlib.get_frontal_face_detector()

# Cài đặt EasyOCR
reader = easyocr.Reader(['vi'])  # Dùng ngôn ngữ tiếng Việt

# Hàm nhận diện khung thẻ
def detect_card(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edges = cv2.Canny(blurred, 50, 150)

    # Tìm đường viền
    contours, _ = cv2.findContours(edges.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Lọc các đường viền có dạng hình chữ nhật
    card_contour = None
    for contour in contours:
        approx = cv2.approxPolyDP(contour, 0.02 * cv2.arcLength(contour, True), True)
        if len(approx) == 4 and cv2.contourArea(approx) > 10000:  # Diện tích lớn hơn 10,000 pixel
            card_contour = approx
            break

    if card_contour is not None:
        # Vẽ khung thẻ lên ảnh
        cv2.drawContours(image, [card_contour], -1, (0, 255, 0), 2)

        # Cắt thẻ
        x, y, w, h = cv2.boundingRect(card_contour)
        card_roi = image[y:y + h, x:x + w]
        return card_roi, image, (x, y, w, h)

    return None, image, None

# Hàm chuẩn hóa kích thước ảnh
def normalize_card_image(card_roi, target_width, target_height):
    # Thay đổi kích thước thẻ về kích thước cố định
    normalized_card = cv2.resize(card_roi, (target_width, target_height))
    return normalized_card

# Các ROI đã xác định cho từng trường dữ liệu (tọa độ mới mà bạn cung cấp)
roi_coords = [
    {'label': 'Tên', 'x1': 313, 'y1': 286, 'x2': 790, 'y2': 333},
    {'label': 'Mã sinh viên', 'x1': 313, 'y1': 326, 'x2': 781, 'y2': 378},
    {'label': 'Ngày sinh', 'x1': 461, 'y1': 376, 'x2': 785, 'y2': 414},
    {'label': 'Ngành học', 'x1': 459, 'y1': 411, 'x2': 786, 'y2': 449},
    {'label': 'Khoa', 'x1': 460, 'y1': 443, 'x2': 782, 'y2': 476},
    {'label': 'Khóa học', 'x1': 460, 'y1': 478, 'x2': 779, 'y2': 509},
]

# Hàm trích xuất thông tin OCR từ thẻ
def extract_text_from_card(image_path):
    # Đọc ảnh đầu vào
    image = cv2.imread(image_path)
    if image is None:
        return None, "Không thể đọc ảnh từ file!"

    # Phát hiện thẻ và cắt vùng thẻ
    card_roi, output_image, card_position = detect_card(image)

    if card_roi is not None:
        # Chuẩn hóa thẻ về kích thước cố định (ví dụ: 600x800)
        target_width, target_height = 800, 600
        normalized_card = normalize_card_image(card_roi, target_width, target_height)

        # Cập nhật ROI dựa trên thẻ đã chuẩn hóa
        card_width = normalized_card.shape[1]
        card_height = normalized_card.shape[0]

        ocr_results = {}
        for roi in roi_coords:
            # Tính toán lại tọa độ ROI dựa trên tỷ lệ với ảnh đã chuẩn hóa
            x1, y1, x2, y2 = roi['x1'], roi['y1'], roi['x2'], roi['y2']

            # Điều chỉnh ROI để phù hợp với kích thước thẻ đã chuẩn hóa
            roi['x1'] = int(x1 * card_width / target_width)
            roi['y1'] = int(y1 * card_height / target_height)
            roi['x2'] = int(x2 * card_width / target_width)
            roi['y2'] = int(y2 * card_height / target_height)

            # Cắt vùng ảnh theo ROI đã chuẩn hóa
            roi_image = normalized_card[roi['y1']:roi['y2'], roi['x1']:roi['x2']]

            # Sử dụng EasyOCR để trích xuất văn bản từ vùng ROI
            result = reader.readtext(roi_image)
            text = " ".join([res[1] for res in result])

            ocr_results[roi['label']] = text.strip()

        return ocr_results, None
    else:
        return None, "Không tìm thấy thẻ trong ảnh!"
