FROM python:3.13-slim
COPY /app
COPY app.py
CMD  ["python","app.py"]
