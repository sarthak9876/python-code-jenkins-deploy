FROM python:3.11-slim
WORKDIR /app
CMD ["pip","install","flask"]
COPY app.py .
CMD ["python","app.py"]
