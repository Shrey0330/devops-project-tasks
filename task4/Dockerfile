# -------- Stage 1: Builder --------
FROM node:18-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git

RUN git clone https://github.com/mehediislamripon/Shopping-Cart-Application.git .

RUN npm install --only=production

# -------- Stage 2: Runtime --------
FROM node:18-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app /app

RUN chown -R appuser:appgroup /app

USER appuser

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/ || exit 1

CMD ["node", "src/index.js"]