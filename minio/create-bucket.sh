#!/bin/sh

source .env

mc config host add minio http://localhost:9000 $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY;
mc mb minio/$AWS_S3_BUCKET_NAME;
mc anonymous set download minio/$AWS_S3_BUCKET_NAME;

exit 0;
