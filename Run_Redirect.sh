#!/system/bin/sh
# Cloud Configuration
# 酷安@阿巴酱(Petit Abba)原创，晚风修改
# 所有路径都已验证(√)

[[ -d /data/media/0/Download ]] && path="Download" || path="download"
Version="202104430"

if [[ ! -f ${0%/*}/files/Variable_a.sh ]]; then
	if [[ ! -d ${0%/*}/files/ ]]; then
		mkdir -p ${0%/*}/files/
		echo "PATH=\"$PATH:/system/sbin:/sbin/.magisk/busybox:$(magisk --path)/.magisk/busybox\"" > ${0%/*}/files/Variable_a.sh
		. ${0%/*}/files/Variable_a.sh
		sleep 0.2 ; rm -rf ${0%/*}/files/
	else
		echo "PATH=\"$PATH:/system/sbin:/sbin/.magisk/busybox:$(magisk --path)/.magisk/busybox\"" > ${0%/*}/files/Variable_a.sh
		. ${0%/*}/files/Variable_a.sh
		sleep 0.2 ; rm -rf ${0%/*}/files/Variable_a.sh
	fi
fi

#推送修复TIM文件夹异常问题(202104100000之后删除该推送)
Repairing="/data/media/0/$path/第三方应用下载目录"
if [[ -d $Repairing/TIM ]]; then
	umount $Repairing/TIM >/dev/null 2>&1
	[[ $? == 0 ]] && rm -rf $Repairing/TIM
fi
if [[ -d $Repairing/Tim ]]; then
	umount $Repairing/Tim >/dev/null 2>&1
	[[ $? == 0 ]] && rm -rf $Repairing/Tim
fi

# 杂项
Dung=".tmp
.thumbnails
.trooptmp"
for S in $Dung; do
	[[ -d /data/media/0/tencent/QQfile_recv/$S ]] && rm -rf /data/media/0/tencent/QQfile_recv/$S
	[[ -d /data/media/0/Tencent/TIMfile_recv/$S ]] && rm -rf /data/media/0/Tencent/TIMfile_recv/$S
	[[ -d /data/media/0/Android/data/com.tencent.tim/Tencent/TIMfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.tim/Tencent/TIMfile_recv/$S
	[[ -d /data1media/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv/$S
	[[ -d /data/media/0/Android/data/com.tencent.tim/sdcard/Tencent/TIMfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.tim/sdcard/Tencent/TIMfile_recv/$S
	[[ -d /data/media/0/Android/data/com.tencent.mobileqq/sdcard/tencent/QQfile_recv/$S ]] && rm -rf /data/media/0/Android/data/com.tencent.mobileqq/sdcard/tencent/QQfile_recv/$S
done

Download() {
	local a="/data/media/0/$2"
	local aa="/data/media/0/Android/data/$2"
	local aaa="$2"
	local b="/data/media/0/$path/第三方应用下载目录/$1"
	local c="/storage/emulated/0/$path/第三方应用下载目录/$1"

	PathLink() {
		if [[ "$(ls -A "${L//'?'/' '}")" == "" ]]; then
			echo "空: $L"
			if [[ -d $b ]]; then
				umount $b >/dev/null 2>&1
				sleep 0.1
				rm -rf $b
			fi
		else
			echo "有: $L"
			[[ ! -d "$b" ]] && mkdir -p "$b"
			mount --bind "$L" "$b"
			mount --bind "$L" "$c"
			chcon u:object_r:media_rw_data_file:s0 "$L"
			chmod 0777 "$L"
			chown media_rw:media_rw "$b"
			chown media_rw:media_rw "$c"
		fi
	}

	if [[ -d $a ]]; then
		echo "- $1"
		L="$a"
		PathLink
	elif [[ -d $aa ]]; then
		echo "- $1"
		L="$aa"
		PathLink
	elif [[ -d $aaa ]]; then
		echo "- $1"
		L="$aaa"
		PathLink
	fi
}

Music() {
	local a="/data/media/0/$3"
	local aa="/data/media/0/Android/data/$3"
	local b="/data/media/0/$path/第三方应用下载目录/音乐(Music)/$1/$2"
	local c="/storage/emulated/0/$path/第三方应用下载目录/音乐(Music)/$1/$2"

	MusicLink() {
		if [[ "$(ls -A "${M//'?'/' '}")" == "" ]]; then
			echo "空: $M"
			if [[ -d $b ]]; then
				umount $b >/dev/null 2>&1
				sleep 0.1
				rm -rf $b
			fi
		else
			echo "有: $M"
			[[ ! -d "$b" ]] && mkdir -p "$b"
			mount --bind "$M" "$b"
			mount --bind "$M" "$c"
			chcon u:object_r:media_rw_data_file:s0 "$M"
			chmod 0777 "$M"
			chown media_rw:media_rw "$b"
			chown media_rw:media_rw "$c"
		fi
	}

	if [[ -d $a ]]; then
		echo "- $1"
		M="$a"
		MusicLink
	elif [[ -d $aa ]]; then
		echo "- $1"
		M="$aa"
		MusicLink
	fi
}


# 正常默认下载目录
Download 'QQ' 'Android/data/com.tencent.mobileqq/Tencent/QQfile_recv'
Download 'QQ.' 'Tencent/QQfile_recv'
Download 'QQ极速版' 'tencent/QQfile_recv'
Download 'TIM' 'Android/data/com.tencent.tim/Tencent/TIMfile_recv'
Download 'TIM.' 'Tencent/TIMfile_recv'
Download '微信' 'Android/data/com.tencent.mm/MicroMsg/Download'
Download '酷安' 'Android/data/com.coolapk.market/files/Download'
Download '迅雷' 'Android/data/com.xunlei.downloadprovider/files/ThunderDownload'
Download 'ADM' 'ADM'
Download 'IDM+' 'IDMP'
Download '大白云' '大白·Cloud'
Download '磁力云' 'happy.cloud'
Download '文叔叔' 'Wenshushu/Download'
Download '腾讯微云' '微云保存的文件'
Download '天翼云盘' "ecloud"
Download '阿里云盘' 'AliYunPan'
Download '百度网盘' 'BaiduNetdisk'
Download '曲奇云盘' 'quqi/pan/download'
Download '神奇磁力' 'Android/data/com.magicmagnet/files'
Download '浩克下载' '浩克下载/Download'
Download '闪电下载' 'Android/data/com.flash.download/files/super_download'
Download '便捷下载' 'Pictures/EasyDownload'
Download 'QQ浏览器' 'QQBrowser'
Download 'UC浏览器' 'UCDownloads'
Download 'UC-Turbo' 'UCTurbo/Download'
Download '夸克浏览器' 'quark/download'
Download '夸克浏览器' 'Quark/download'
Download '种子播放器' 'TorrentPlayer'
Download 'NeKogram' 'Android/data/nekox.messenger/files/documents'
Download 'Nekogram.' 'Android/data/tw.nekomimi.nekogram/files/Telegram/Telegram Documents'
Download 'Nekogram-X' 'NekoX'
Download 'TG.' 'Telegram/Telegram Documents'
Download 'TG-X' 'Android/data/org.thunderdog.challegram/files/documents'
Download 'TG--X' 'Android/data/taipei.sean.challegram'
Download 'X浏览器' 'Android/data/com.mmbox.xbrowser/files/downloads'
Download '安卓壁纸' 'Android/data/com.androidesk/files/androidesk'
Download '搞机助手' '/data/data/Han.GJZS/files/Configuration_File'
Download '皮皮虾' 'DCIM/pipixia'

# 存储空间隔离后的应用下载目录
Download 'QQ.' 'com.tencent.mobileqq/sdcard/tencent/QQfile_recv'
Download 'QQ极速版' 'com.tencent.qqlite/sdcard/tencent/QQfile_recv'
Download 'TIM.' 'com.tencent.tim/sdcard/Tencent/TIMfile_recv'
Download 'ADM' 'com.dv.adm/sdcard/ADM'
Download 'IDM+' 'idm.internet.download.manager.plus/sdcard/IDMP'
Download '文叔叔' 'com.wenshushu.app.android/sdcard/Wenshushu/Download'
Download '大白云' 'com.db.cloud/sdcard/大白·Cloud'
Download '磁力云' 'com.ciliyun/sdcard/happy.cloud'
Download '腾讯微云' 'com.qq.qcloud/sdcard/微云保存的文件'
Download '天翼云盘' "com.cn21.ecloud/sdcard/ecloud"
Download '阿里云盘' 'com.alicloud.databox/sdcard/AliYunPan'
Download '百度网盘' 'com.baidu.netdisk/sdcard/BaiduNetdisk'
Download '曲奇云盘' 'com.quqi.quqioffice/sdcard/quqi/pan/download'
Download '浩克下载' 'com.sausage.download/sdcard/浩克下载/Download'
Download '便捷下载' 'com.lcw.easydownload/sdcard/Pictures/EasyDownload'
Download 'QQ浏览器' 'com.tencent.mtt/sdcard/QQBrowser'
Download 'UC浏览器' 'com.UCMobile/sdcard/UCDownloads'
Download 'UC-Turbo' 'com.ucturbo/sdcard/UCTurbo/Download'
Download '夸克浏览器' 'com.quark.browser/sdcard/quark/download'
Download '夸克浏览器' 'com.quark.browser/sdcard/Quark/download'
Download '种子播放器' 'com.iiplayer.sunplayer/sdcard/TorrentPlayer'
Download 'FlyChat' 'org.telegram.flychat/sdcard/Telegram/Telegram Documents'
Download 'TG' 'org.telegram.messenger/sdcard/Telegram/Telegram Documents'

# 音乐类(含存储空间隔离后目录)
Music "网易云音乐" "歌曲" "netease/cloudmusic/Music"
Music "网易云音乐" "歌曲" "com.netease.cloudmusic/sdcard/netease/cloudmusic/Music"
Music "网易云音乐" "MV" "netease/cloudmusic/MV"
Music "网易云音乐" "MV" "com.netease.cloudmusic/sdcard/netease/cloudmusic/MV"
Music "酷狗音乐" "歌曲" "kgmusic/download"
Music "酷狗音乐" "歌曲" "com.kugou.android/sdcard/kgmusic/download"
Music "酷狗音乐" "MV" "kugou/mv"
Music "酷狗音乐" "MV" "com.kugou.android/sdcard/kugou/mv"
Music "咪咕音乐" "歌曲" "12530/download"
Music "咪咕音乐" "歌曲" "cmccwm.mobilemusic/sdcard/12530/download"
Music "酷我音乐" "歌曲" "KuwoMusic/music"
Music "酷我音乐" "歌曲" "cn.kuwo.player/sdcard/KuwoMusic/music"
Music "酷我音乐" "MV" "KuwoMusic/mvDownload"
Music "酷我音乐" "MV" "cn.kuwo.player/sdcard/KuwoMusic/mvDownload"
Music "QQ音乐" "歌曲" "qqmusic/song"
Music "QQ音乐" "歌曲" "com.tencent.qqmusic/sdcard/qqmusic/song"
Music "QQ音乐" "MV" "qqmusic/mv"
Music "QQ音乐" "MV" "com.tencent.qqmusic/sdcard/qqmusic/mv"
Music "DJ多多" "歌曲" "DJDD/Download"
Music "DJ多多" "歌曲" "com.shoujiduoduo.dj/sdcard/DJDD/Download"

wjj="/data/media/0/$path/第三方应用下载目录/*"
for i in `ls -d $wjj`; do
	kwjj=$i
	if [[ "$(ls -A "${kwjj//'?'/' '}")" == "" ]]; then
		if [[ -d $kwjj ]]; then
			umount $kwjj >/dev/null 2>&1
			sleep 0.1
			rm -rf $kwjj
		fi
	fi
done

yywjj="/data/media/0/$path/第三方应用下载目录/音乐(Music)"
if [[ -d $yywjj ]]; then
	for yy in `ls -A $yywjj`; do
		yykwjj="$yywjj/$yy"
		if [[ "$(ls -A "${yykwjj//'?'/' '}")" == "" ]]; then
			if [[ -d $yykwjj ]]; then
				umount $yykwjj >/dev/null 2>&1
				sleep 0.1
				rm -rf $yykwjj
			fi
		fi
	done
fi

sleep 10
