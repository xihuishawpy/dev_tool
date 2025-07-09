#!/bin/bash

# 定义应用程序相关变量
APP_NAME="streamlit_app"
CMD="streamlit run app.py --server.port 8080"
LOG_FILE="streamlit.log"

# 查找正在运行的进程PID
get_pid() {
    pgrep -f "$CMD"
}

# 启动服务
start() {
    pid=$(get_pid)
    if [ -n "$pid" ]; then
        echo "$APP_NAME is already running with PID: $pid"
        exit 1
    fi

    echo "Starting $APP_NAME..."
    # 使用 nohup 在后台运行，并将日志输出到文件
    nohup $CMD > "$LOG_FILE" 2>&1 &
    
    # 等待一小段时间以确保进程启动
    sleep 2

    pid=$(get_pid)
    if [ -n "$pid" ]; then
        echo "$APP_NAME started successfully with PID: $pid"
        echo "Logs are being written to $LOG_FILE"
    else
        echo "Failed to start $APP_NAME. Check $LOG_FILE for errors."
    fi
}

# 停止服务
stop() {
    pid=$(get_pid)
    if [ -n "$pid" ]; then
        echo "Stopping $APP_NAME (PID: $pid)..."
        # 使用 pkill 优雅地停止进程
        pkill -f "$CMD"
        sleep 2
        echo "$APP_NAME stopped."
    else
        echo "$APP_NAME is not running."
    fi
}

# 重启服务
restart() {
    echo "Restarting $APP_NAME..."
    stop
    start
}

# 查看服务状态
status() {
    pid=$(get_pid)
    if [ -n "$pid" ]; then
        echo "$APP_NAME is running with PID: $pid"
    else
        echo "$APP_NAME is not running."
    fi
}

# 根据传入的参数执行相应操作
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac

exit 0
