FROM python:3.10-slim

ENV FLASK_APP=sysinfo

RUN useradd -m sysinfo

WORKDIR /home/sysinfo/

COPY app app
COPY dockerstart.sh dockerstart.sh
COPY pytest.ini pytest.ini
COPY quickrequirements.txt quickrequirements.txt
COPY sysinfo.py sysinfo.py

RUN mkdir -p static/imagini && chmod -R 777 static
RUN chmod +x dockerstart.sh

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    pkg-config \
    python3-dev \
    libfreetype6-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv .venv
RUN .venv/bin/python -m pip install --upgrade pip setuptools wheel
RUN .venv/bin/python -m pip install --prefer-binary -r quickrequirements.txt

USER sysinfo

EXPOSE 5011
ENTRYPOINT ["./dockerstart.sh"]
