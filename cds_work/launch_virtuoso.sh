#!/bin/bash
export DISPLAY=:0.0
source /home/buet/.bashrc

RUNNING_PID=$(pgrep -u $USER -x virtuoso | head -n 1)
if [ -n "$RUNNING_PID" ]; then
    echo "=========================================================="
    echo "[INFO] Cadence Virtuoso đang chạy sẵn rồi (PID: $RUNNING_PID)!"
    echo "       Bạn chỉ cần chuyển sang cửa sổ VMware Workstation là thấy."
    echo "=========================================================="
    exit 0
fi

cd /home/buet/Desktop/Workspace/cds_work
echo "Khởi động Cadence Virtuoso trên DISPLAY=$DISPLAY..."
nohup virtuoso -log /home/buet/Desktop/Workspace/cds_work/CDS.log >/dev/null 2>&1 &
sleep 2
echo "Đã mở thành công! Hãy chuyển sang cửa sổ VMware Workstation để thao tác."
