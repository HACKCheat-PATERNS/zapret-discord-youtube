@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
echo:

set "BIN=%~dp0bin\"

start "zapret: global (v70.6)" /min "%BIN%winws.exe" --debug=1 --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --dpi-desync=fake --dpi-desync-repeats=3 --dpi-desync-fooling=badseq --dpi-desync-cutoff=200 --new ^
--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=2 --dpi-desync-cutoff=200 --new ^
--filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-cutoff=200 --new ^
--filter-tcp=443 --dpi-desync=split --dpi-desync-split-pos=10 --dpi-desync-autottl --dpi-desync-fooling=badseq --dpi-desync-repeats=4 --dpi-desync-cutoff=200 > "%~dp0zapret_log.txt" 2>&1