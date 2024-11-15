import cv2
import numpy as np
import dlib

# Cài đặt dlib và các tham số
detector = dlib.get_frontal_face_detector()

# Biến toàn cục để lưu trữ tọa độ ROI
roi_coords = []
drawing = False
current_roi = {}

# Hàm xử lý sự kiện chuột để chọn ROI
def draw_roi(event, x, y, flags, param):
    global drawing, current_roi, roi_coords

    if event == cv2.EVENT_LBUTTONDOWN:
        # Bắt đầu vẽ
        drawing = True
        current_roi['x1'], current_roi['y1'] = x, y

    elif event == cv2.EVENT_MOUSEMOVE:
        if drawing:
            # Cập nhật tọa độ khi kéo chuột
            current_roi['x2'], current_roi['y2'] = x, y

    elif event == cv2.EVENT_LBUTTONUP:
        # Kết thúc vẽ
        drawing = False
        current_roi['x2'], current_roi['y2'] = x, y
        roi_coords.append(current_roi.copy())
        print(f"ROI được chọn: {current_roi}")  # Hiển thị tọa độ ROI


# Hàm phát hiện thẻ sinh viên
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
        return card_roi, image

    return None, image


# Đọc ảnh đầu vào
image = cv2.imread('img/anh2.jpg')
if image is None:
    print("Không thể đọc ảnh từ file!")
    exit()

# Phát hiện thẻ
card_roi, output_image = detect_card(image)

if card_roi is not None:
    # Hiển thị ảnh và thiết lập sự kiện chuột
    resized_card = cv2.resize(card_roi, (800, 600))  # Resize để dễ kéo ROI
    cv2.namedWindow("Select ROIs")
    cv2.setMouseCallback("Select ROIs", draw_roi)

    while True:
        # Vẽ các ROI đang được kéo
        temp_image = resized_card.copy()
        if 'x1' in current_roi and 'y1' in current_roi:
            x1, y1 = current_roi['x1'], current_roi['y1']
            x2, y2 = current_roi.get('x2', x1), current_roi.get('y2', y1)
            cv2.rectangle(temp_image, (x1, y1), (x2, y2), (0, 0, 255), 2)

        # Hiển thị ảnh
        cv2.imshow("Select ROIs", temp_image)

        # Nhấn phím 'q' để thoát
        key = cv2.waitKey(1) & 0xFF
        if key == ord('q'):
            break

    cv2.destroyAllWindows()

    # Hiển thị các ROI đã chọn
    print("Tọa độ ROI đã chọn:", roi_coords)
else:
    print("Không tìm thấy thẻ trong ảnh!")
