FROM python:3.11-slim
WORKDIR /app
RUN pip insall flask
COPY app.py .
CMD ["python","app.py"]
