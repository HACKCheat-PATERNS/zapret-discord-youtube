@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
echo:

set "BIN=%~dp0bin\"

start "zapret: global (v70.6)" /min "%BIN%winws.exe" --wf-raw="tcp.DstPort==80 or tcp.DstPort==443 or tcp.DstPort==2099 or tcp.DstPort==5222 or tcp.DstPort==5223 or tcp.DstPort>=8393 and tcp.DstPort<=8400 or udp.DstPort==443 or udp.DstPort>=50000 and udp.DstPort<=50100" ^
--filter-udp=443 --dpi-desync=fakedsplit --dpi-desync-repeats=3 --dpi-desync-fooling=badseq --dpi-desync-fakedsplit-pattern=0xDEADBEEF --new ^
--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=2 --new ^
--filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --dpi-desync=fakedsplit --dpi-desync-split-pos=5 --dpi-desync-autottl=2 --dpi-desync-fooling=badseq --dpi-desync-repeats=4 --dpi-desync-fakedsplit-pattern=0xDEADBEEF --new ^
--filter-tcp=2099 --dpi-desync=syndata,fakedsplit --dpi-desync-split-pos=1 --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-autottl=1:3-20 --dpi-desync-any-protocol=1 --dpi-desync-fooling=badseq,md5sig --new ^
--filter-tcp=5222 --dpi-desync=syndata,fakedsplit --dpi-desync-split-pos=1 --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-autottl=1:3-20 --dpi-desync-any-protocol=1 --dpi-desync-fooling=badseq,md5sig --new ^
--filter-tcp=5223 --dpi-desync=syndata,fakedsplit --dpi-desync-split-pos=1 --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-autottl=1:3-20 --dpi-desync-any-protocol=1 --dpi-desync-fooling=badseq,md5sig --new ^
--filter-tcp=8393-8400 --dpi-desync=syndata,fakedsplit --dpi-desync-split-pos=1 --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-autottl=1:3-20 --dpi-desync-any-protocol=1 --dpi-desync-fooling=badseq,md5sig --new ^