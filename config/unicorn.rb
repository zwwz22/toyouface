#working_directory "/home/zhangw/workspace/toyouface"
#pid "/home/zhangw/workspace/toyouface" + "/tmp/pids/unicorn.pid"
#stderr_path "/home/zhangw/workspace/toyouface" + "/log/unicorn.log"
#stdout_path "/home/zhangw/workspace/toyouface" + "/log/unicorn.log"
#
#listen "/tmp/unicorn.toyouface.sock"
#worker_processes 2
#timeout 30
working_directory "/alidata1/xiyou/apps/toyouface/current"
pid "/alidata1/xiyou/apps/toyouface/current" + "/tmp/pids/unicorn.pid"
stderr_path "/alidata1/xiyou/apps/toyouface/current" + "/log/unicorn.log"
stdout_path "/alidata1/xiyou/apps/toyouface/current" + "/log/unicorn.log"

listen "/tmp/unicorn.toyouface.sock"
worker_processes 2
timeout 30