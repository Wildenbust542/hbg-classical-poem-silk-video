# 《钱塘湖春行》示例设计

> 本文件只保留通用分镜与提示词方法，不包含用户密钥、Cookie、本地路径、完整生成日志或未授权素材。

## 分镜分组

| 景 | 诗句 | 视觉通道 | 主动作 | 静态锚点 |
|---|---|---|---|---|
| 1 | 孤山寺北贾亭西；水面初平云脚低 | 淡墨湖寺 | 前景水纹扩散、芦苇轻摆 | 寺塔、亭台、山体、岸线 |
| 2 | 几处早莺争暖树；谁家新燕啄春泥 | 工笔花鸟 | 莺振翅、燕啄泥 | 树干、主枝、鸟数、画框 |
| 3 | 乱花渐欲迷人眼；浅草才能没马蹄 | 人物鞍马 | 马匹小幅重心变化 | 人物躯干、马体、地平线 |
| 4 | 最爱湖东行不足；绿杨阴里白沙堤 | 青绿山水 | 柳枝风动、马匹小步 | 柳树主干、白堤、湖岸、山体 |

## 运动提示词结构

```text
Create a 10-second image-to-video animation from this exact source painting.
LOCKED CAMERA: no zoom, push, pan, tilt, roll, reframing, parallax or crop change.
Treat the source as a fixed painted plate.

Static anchors: [architecture / trunks / shoreline / body torso / typography zone / red seal].
Animate only: [one dominant anchored action] plus [one or two small ambient actions].
Keep displacement small and physically coherent.
During the final second, settle into a near-still endpoint.

Generate synchronized natural ambience, no speech and no music.
No subject count changes, detached leaves, decorative cloud shapes, anatomy morphing,
new silhouettes, invented text, camera motion, composition reset or style change.
```

## 关键经验

- “云层横穿山体”容易触发建筑和云雾重画；优先让前景水纹和芦苇承担动态。
- “飞鸟落到树枝”涉及长距离位移，容易复制鸟类；优先让鸟围绕原身体中心振翅。
- “整棵柳树摇动”容易生成脱落树叶；只允许附着枝条的小幅振荡。
- 两个画面交叉溶解时，每景最后约一秒应自然收稳。
- 原环境声使用 `acrossfade`；BGM 全片连续，不在场景边界重启。
