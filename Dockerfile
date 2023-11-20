FROM continuumio/miniconda3:latest

COPY . .

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV SCRIPT_NAME "/vidok"

# install python dependencies
RUN apt-get update && apt-get install libxrender1 libxext6 libarchive-dev -y
RUN bash install.sh
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 10007

# gunicorn
CMD ["gunicorn", "--config", "gunicorn-cfg.py", "run:app"]
