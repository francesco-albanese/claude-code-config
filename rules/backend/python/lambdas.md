---
paths: ["**/lambda_function.py", "**/handler.py", "**/Dockerfile"]
---

# Python Lambda Packaging

## macOS Build
- Build with Docker using AWS base images
- Use `FROM public.ecr.aws/lambda/python:3.13`
- Package as container image
- Don't bundle boto3 - included in Lambda runtime
