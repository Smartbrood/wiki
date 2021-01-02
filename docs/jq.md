---
title: "JQ"
category: "main"
---

== Links ==
* [https://stedolan.github.io/jq/manual/ JQ Manual]


== Examples ==
<pre>
aws ec2 describe-volumes --filters Name=status,Values=available | jq '.Volumes[] | select(.Tags[]?=={"Key": "Terraform", "Value": "true"}) | .Tags[] | select(.Key=="Name") | .Value'


aws ec2 describe-addresses | jq '.Addresses[] | select(has("AssociationId") | not)'
</pre>