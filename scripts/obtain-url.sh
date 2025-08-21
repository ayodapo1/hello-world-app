#!/bin/bash
CLUSTER_NAME="hello-world-cluster"
SERVICE_NAME="hello-world-service"

echo "Waiting for service to stabilize..."
sleep 30

TASK_ARN=$(aws ecs list-tasks --cluster $CLUSTER_NAME --service-name $SERVICE_NAME --query 'taskArns[0]' --output text)

if [ -z "$TASK_ARN" ] || [ "$TASK_ARN" == "None" ]; then
    echo "No tasks found for service $SERVICE_NAME"
    exit 1
fi

ENI_ID=$(aws ecs describe-tasks --cluster $CLUSTER_NAME --tasks $TASK_ARN --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value' --output text)

if [ -z "$ENI_ID" ] || [ "$ENI_ID" == "None" ]; then
    echo "No network interface found for task $TASK_ARN"
    exit 1
fi

PUBLIC_IP=$(aws ec2 describe-network-interfaces --network-interface-ids $ENI_ID --query 'NetworkInterfaces[0].Association.PublicIp' --output text)

echo "Application deployed successfully!"
echo "Public IP: $PUBLIC_IP"
echo "URL: http://$PUBLIC_IP"