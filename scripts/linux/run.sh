#! /bin/bash
tmux kill-server

echo "Starting tmux sessions"
tmux new -s boskierp && tmux send-keys -t boskierp "cd /home/fivem/main/ && bash /home/fivem/artifacts/5375/run.sh +exec server.cfg +set onesync legacy" ENTER
tmux new -s vandsus && tmux send-keys -t vandsus "cd /home/bot/vandsus && node ." ENTER
tmux new -s vandmus && tmux send-keys -t vandmus "cd /home/bot/vandmus && node ." ENTER
tmux new -s radio && tmux send-keys -t radio "cd /home/bot/radio && node radio" ENTER