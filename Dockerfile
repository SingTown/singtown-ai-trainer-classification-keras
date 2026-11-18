FROM ghcr.io/astral-sh/uv:debian

WORKDIR /app
COPY . /app

RUN cd singtown-ai-trainer-classification-keras && uv sync && uv run cache_weight.py

# TensorFlow reserves nearly all of the GPU's memory on first use by default,
# which starves any other training task sharing the card.
ENV TF_FORCE_GPU_ALLOW_GROWTH=true

CMD ["sh", "run.sh"]