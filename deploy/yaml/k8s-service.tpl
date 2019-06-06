kind: Service
apiVersion: v1
metadata:
  name: {APP_NAME}-service
  namespace: cicd
  annotations:
    service.beta.kubernetes.io/alicloud-loadbalancer-address-type: intranet
spec:
  ports:
  - name: {APP_NAME}
    port: 80
    protocol: TCP
    targetPort: {T_PORT}
  selector:
    app: {APP_NAME}
  type: LoadBalancer
