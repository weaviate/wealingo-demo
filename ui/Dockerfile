FROM fischerscode/flutter:stable

RUN flutter doctor

RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web
COPY . /app/
WORKDIR /app/

RUN flutter build web --release --web-renderer html

FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html

EXPOSE 3000

CMD ["flutter", "run", "-d", "chrome", "--web-port", "3000"]