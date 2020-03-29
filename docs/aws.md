---
title: "AWS Snippets"
category: "main"
---


# CloudWatch Logs Insights (filter)
```
filter @logStream = 'eni-0366fd3d54ac10b97-all' 
| filter dstAddr='10.89.64.133'
```



# awscli
## EBS volumes
```bash
aws ec2 describe-volumes --filters Name=status,Values=available \
  | jq '.Volumes[] | select(.Tags[]?=={"Key": "Terraform", "Value": "true"}) | .Tags[] | select(.Key=="Name") | .Value' \
  | sort | uniq
```

## S3 Get size
```bash
aws s3 ls \
    --summarize \
    --human-readable \
    --recursive s3://files.example.com/ \
    | tail -n 2
Total Objects: 642
Total Size: 838.8 GiB
```

## S3 Copy objects between Amazon S3 buckets
```bash
aws s3 sync s3://SOURCE_BUCKET_NAME s3://NEW_BUCKET_NAME
```

## Misc Examples
```bash
apt install awscli
aws configure
aws ec2 describe-subnets
aws ec2 describe-images \
    --filters "Name=name,Values=*12.04*" \
    --owners 099720109477

aws s3api list-objects \
    --bucket sg.example.com \
    --output json \
    --query "[sum(Contents[].Size), length(Contents[])]"
```
















