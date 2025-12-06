@echo off

%2

cd %1

mkdir sdm
tar -C sdm -xpf sdm.tar

mkdir ips
tar -C ips -xpf ips.tar

mkdir common
tar -C common -xpf common.tar


@cls

