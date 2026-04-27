FROM python:3.10-alpine

ENV FLASK_APP=sysinfo

RUN adduser -D sysinfo

WORKDIR /home/sysinfo/

COPY app app
COPY dockerstart.sh dockerstart.sh
COPY pytest.ini pytest.ini
COPY quickrequirements.txt quickrequirements.txt
COPY sysinfo.py sysinfo.py

RUN mkdir -p static/imagini && chmod -R 777 static

RUN apk add --no-cache \
    gcc \
    g++ \
    musl-dev \
    python3-dev \
    pkgconfig \
    freetype-dev \
    libpng-dev

RUN python3 -m venv .venv
RUN .venv/bin/python -m pip install --upgrade pip setuptools wheel
RUN .venv/bin/python -m pip install --prefer-binary -r quickrequirements.txt

USER sysinfo

EXPOSE 5011
ENTRYPOINT ["./dockerstart.sh"]
