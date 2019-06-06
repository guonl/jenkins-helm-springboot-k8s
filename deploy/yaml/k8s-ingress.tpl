kind: Ingress
apiVersion: extensions/v1beta1
metadata:
  name: {APP_NAME}-ingress
  namespace: cicd
spec:
  rules:
  - host: {APP_NAME}.test.com
    http:
      paths:
      - backend:
          serviceName: {APP_NAME}-service
          servicePort: 80
        path: /
