# 靜態站：用 nginx 提供 index.html 與 assets/
FROM nginx:alpine

# 把網站檔案複製到 nginx 預設根目錄
COPY . /usr/share/nginx/html

EXPOSE 80
