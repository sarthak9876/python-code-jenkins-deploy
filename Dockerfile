FROM python:3.11-slim
WORKDIR /app
COPY requiremets.txt .
RUN pip insall
COPY app.py .
CMD ["python","app.py"]
