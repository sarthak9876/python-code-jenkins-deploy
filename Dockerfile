FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install 
COPY app.py .
CMD ["python","app.py"]
