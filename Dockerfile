FROM amazon/dynamodb-local
EXPOSE 8000

CMD [ "-jar DynamoDBLocal.jar -delayTransientStatuses -sharedDb" ]
