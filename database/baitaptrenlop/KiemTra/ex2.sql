USE shopee;

-- Thực hiện kết nối các khóa ngoại giữa các bảng theo các yêu cầu và ERD sau
ALTER TABLE `carts`
ADD CONSTRAINT `fk_carts_user` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE CASCADE,
ADD CONSTRAINT `fk_carts_product` FOREIGN KEY (`productId`) REFERENCES `products`(`productId`) ON DELETE CASCADE;

ALTER TABLE `images`
ADD CONSTRAINT `fk_images_product` FOREIGN KEY (`productId`) REFERENCES `products`(`productId`) ON DELETE CASCADE;

ALTER TABLE `order_details`
ADD CONSTRAINT `fk_order_details_product` FOREIGN KEY (`productId`) REFERENCES `products`(`productId`) ON DELETE CASCADE,
ADD CONSTRAINT `fk_order_details_order` FOREIGN KEY (`orderId`) REFERENCES `orders`(`orderId`) ON DELETE CASCADE;

ALTER TABLE `orders`
ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE CASCADE,
ADD CONSTRAINT `fk_orders_store` FOREIGN KEY (`storeId`) REFERENCES `stores`(`storeId`) ON DELETE CASCADE;

ALTER TABLE `products`
ADD CONSTRAINT `fk_products_store` FOREIGN KEY (`storeId`) REFERENCES `stores`(`storeId`) ON DELETE CASCADE,
ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`categoryId`) REFERENCES `categories`(`categoryId`) ON DELETE CASCADE;

ALTER TABLE `reviews`
ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE CASCADE,
ADD CONSTRAINT `fk_reviews_product` FOREIGN KEY (`productId`) REFERENCES `products`(`productId`) ON DELETE CASCADE;

ALTER TABLE `stores`
ADD CONSTRAINT `fk_stores_user` FOREIGN KEY (`userId`) REFERENCES `users`(`userId`) ON DELETE CASCADE;
