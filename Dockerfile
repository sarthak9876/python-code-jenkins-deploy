FROM python:3.11-slim
WORKDIR /app
RUN pip3 insall flask
COPY app.py .
CMD ["python","app.py"]
