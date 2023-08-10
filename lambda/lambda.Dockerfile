FROM public.ecr.aws/lambda/python:3.11

COPY requirements.txt ${LAMBDA_TASK_ROOT}

COPY extract_tracks.py ${LAMBDA_TASK_ROOT}

RUN pip install -r requirements.txt

CMD [ "extract_tracks.handle_lambda" ]
