kind: Deployment
apiVersion: extensions/v1beta1
metadata:
  name: {APP_NAME}-deployment
  labels:
    app: {APP_NAME}
  namespace: cicd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {APP_NAME}
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: {APP_NAME}
    spec:
      containers:
      - image: {IMAGE_NAME}
        imagePullPolicy: IfNotPresent
        name: {APP_NAME}
        ports:
        - containerPort: 80
          name: http
          protocol: TCP
        resources:
          limits:
            cpu: 2500m
            memory: 1500Mi
          requests:
            cpu: 250m
            memory: 600Mi
      imagePullSecrets:
      - name: xxx
      restartPolicy: Always
