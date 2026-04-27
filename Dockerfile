FROM python:3.10-alpine

ENV FLASK_APP=sysinfo

RUN useradd -m sysinfo
WORKDIR /home/sysinfo/

COPY app app
COPY dockerstart.sh dockerstart.sh
COPY pytest.ini pytest.ini
COPY quickrequirements.txt quickrequirements.txt
COPY sysinfo.py sysinfo.py

RUN mkdir -p static/imagini && chmod -R 777 static

RUN python -m venv .venv
RUN .venv/bin/python -m pip install --upgrade pip setuptools wheel
RUN .venv/bin/python -m pip install --prefer-binary -r quickrequirements.txt

EXPOSE 5011
ENTRYPOINT ["./dockerstart.sh"]
