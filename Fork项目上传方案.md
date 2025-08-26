# 🚀 Fork项目并修改子模块的GitHub上传方案

## 📋 当前情况分析

您的项目结构：
```
PPTCopilot/ (主仓库)
├── PPTCopilot-backend/     → hughdazz/PPTCopilotBackend.git
├── PPTCopilot-editor/      → hughdazz/PPTCopilotEditor.git  
└── PPTCopilot-project/     → hughdazz/PPTCopilotProject.git
```

**问题**：子模块指向原作者仓库，您的修改无法推送

## 🎯 解决方案

### 方案一：Fork + 重新关联（推荐）

#### 第1步：在GitHub上Fork所有仓库

1. **访问原仓库并Fork**
   ```
   https://github.com/hughdazz/PPTCopilotBackend   → Fork到你的账户
   https://github.com/hughdazz/PPTCopilotProject   → Fork到你的账户  
   https://github.com/hughdazz/PPTCopilotEditor    → Fork到你的账户
   ```

2. **Fork后得到**
   ```
   https://github.com/yourusername/PPTCopilotBackend
   https://github.com/yourusername/PPTCopilotProject
   https://github.com/yourusername/PPTCopilotEditor
   ```

#### 第2步：推送子模块修改到自己的仓库

```bash
cd PPTCopilot

# 处理backend子模块
cd PPTCopilot-backend
git remote -v  # 查看当前远程仓库
git remote set-url origin git@github.com:yourusername/PPTCopilotBackend.git
git add .
git commit -m "feat: 更新配置以支持本地Ollama模型"
git push origin master

# 处理editor子模块
cd ../PPTCopilot-editor
git remote set-url origin git@github.com:yourusername/PPTCopilotEditor.git
git add .
git commit -m "fix: 修复ESLint错误，优化构建流程"
git push origin master

# 处理project子模块
cd ../PPTCopilot-project  
git remote set-url origin git@github.com:yourusername/PPTCopilotProject.git
git add .
git commit -m "feat: 优化项目管理功能"
git push origin master

# 返回主目录
cd ..
```

#### 第3步：更新主仓库的.gitmodules文件

```bash
# 编辑.gitmodules文件
vim .gitmodules
```

修改为：
```ini
[submodule "PPTCopilot-backend"]
	path = PPTCopilot-backend
	url = git@github.com:yourusername/PPTCopilotBackend.git
[submodule "PPTCopilot-project"]
	path = PPTCopilot-project
	url = git@github.com:yourusername/PPTCopilotProject.git
[submodule "PPTCopilot-editor"]
	path = PPTCopilot-editor
	url = git@github.com:yourusername/PPTCopilotEditor.git
```

#### 第4步：同步子模块URL

```bash
# 同步.gitmodules配置到.git/config
git submodule sync

# 验证更新
git submodule foreach 'git remote -v'
```

#### 第5步：创建主仓库并推送

```bash
# 在GitHub创建主仓库：PPTCopilot

# 设置主仓库远程URL
git remote add origin git@github.com:yourusername/PPTCopilot.git

# 添加所有文件
git add .
git commit -m "🎉 Fork PPTCopilot项目并添加本地Ollama支持

✨ 主要改进:
- 🤖 支持本地Ollama模型（qwen3:4b-instruct）
- 🔧 修复Docker构建问题
- 📝 添加详细使用文档
- 🚀 优化前端构建流程
- 🔒 改进数据库连接配置

🛠️ 技术栈:
- Backend: Go + Beego + MySQL
- Frontend: Vue.js + Element UI
- Editor: Vue.js + Canvas
- AI: Ollama (本地) / OpenAI
- Deploy: Docker Compose"

# 推送到GitHub
git push -u origin master
```

### 方案二：创建全新仓库（适合大幅修改）

如果您的修改很多，可以创建全新的仓库结构：

#### 第1步：移除现有子模块
```bash
# 移除子模块（保留文件）
git submodule deinit PPTCopilot-backend
git submodule deinit PPTCopilot-editor  
git submodule deinit PPTCopilot-project

# 删除.gitmodules
rm .gitmodules

# 提交删除
git add .
git commit -m "remove submodules"
```

#### 第2步：创建独立仓库
```bash
# 为每个子项目创建独立仓库
# 在GitHub上创建：
# - yourusername/PPTCopilot-Backend
# - yourusername/PPTCopilot-Editor  
# - yourusername/PPTCopilot-Project
# - yourusername/PPTCopilot

# 推送每个子项目
cd PPTCopilot-backend
git init
git add .
git commit -m "Initial commit: PPTCopilot Backend"
git remote add origin git@github.com:yourusername/PPTCopilot-Backend.git
git push -u origin master

# 重复editor和project...
```

## 🔧 完整执行脚本

我为您准备了自动化脚本：

```bash
#!/bin/bash
# 执行前请确保：
# 1. 已经在GitHub上Fork了所有仓库
# 2. 替换yourusername为你的GitHub用户名

GITHUB_USERNAME="yourusername"  # 替换为你的GitHub用户名

echo "🚀 开始处理子模块..."

# 处理每个子模块
for submodule in PPTCopilot-backend PPTCopilot-editor PPTCopilot-project; do
    echo "📦 处理 $submodule..."
    cd $submodule
    
    # 更新远程URL
    case $submodule in
        "PPTCopilot-backend")
            git remote set-url origin git@github.com:${GITHUB_USERNAME}/PPTCopilotBackend.git
            ;;
        "PPTCopilot-editor") 
            git remote set-url origin git@github.com:${GITHUB_USERNAME}/PPTCopilotEditor.git
            ;;
        "PPTCopilot-project")
            git remote set-url origin git@github.com:${GITHUB_USERNAME}/PPTCopilotProject.git
            ;;
    esac
    
    # 提交并推送修改
    git add .
    git status
    read -p "是否提交 $submodule 的修改？(y/n): " confirm
    if [[ $confirm == [yY] ]]; then
        git commit -m "feat: 更新项目配置和功能优化"
        git push origin master
        echo "✅ $submodule 推送完成"
    fi
    
    cd ..
done

echo "🔧 更新.gitmodules文件..."

# 更新.gitmodules
cat > .gitmodules << EOF
[submodule "PPTCopilot-backend"]
	path = PPTCopilot-backend
	url = git@github.com:${GITHUB_USERNAME}/PPTCopilotBackend.git
[submodule "PPTCopilot-project"]
	path = PPTCopilot-project
	url = git@github.com:${GITHUB_USERNAME}/PPTCopilotProject.git
[submodule "PPTCopilot-editor"]
	path = PPTCopilot-editor
	url = git@github.com:${GITHUB_USERNAME}/PPTCopilotEditor.git
EOF

# 同步配置
git submodule sync

echo "🏠 推送主仓库..."
git add .
git commit -m "🎉 Fork PPTCopilot项目并添加个人定制

✨ Features:
- 🤖 本地Ollama模型支持
- 🔧 Docker配置优化  
- 📝 完整使用文档
- 🚀 构建流程改进

Based on hughdazz/PPTCopilot"

# 推送主仓库
git remote add origin git@github.com:${GITHUB_USERNAME}/PPTCopilot.git
git push -u origin master

echo "🎉 完成！项目已上传到你的GitHub账户"
```

## ✅ 验证步骤

### 1. 验证子模块
```bash
git submodule foreach 'git remote -v'
```

### 2. 测试完整克隆
```bash
# 在新目录测试
cd ~/temp
git clone --recursive git@github.com:yourusername/PPTCopilot.git
cd PPTCopilot
docker-compose up -d
```

### 3. 检查子模块状态
```bash
git submodule status
```

## 📝 注意事项

### ⚠️ 重要提醒
1. **替换用户名**：所有脚本中的`yourusername`都要替换为你的GitHub用户名
2. **SSH密钥**：确保你的SSH密钥已配置到GitHub
3. **Fork仓库**：必须先在GitHub上Fork原仓库才能推送
4. **备份工作**：执行前建议备份当前代码

### 🔒 许可证考虑
- 原项目使用MIT许可证，允许Fork和修改
- 建议在README中注明基于原项目
- 保留原作者的版权声明

### 📊 推荐工作流
1. **开发分支**：在自己的仓库创建`develop`分支进行开发
2. **版本标签**：使用`v1.0-fork`等标签标识你的版本
3. **变更记录**：维护CHANGELOG记录你的修改

## 🎯 执行顺序总结

1. ✅ **Fork原仓库**（在GitHub网页操作）
2. ✅ **推送子模块修改**（命令行操作） 
3. ✅ **更新.gitmodules**（修改配置文件）
4. ✅ **同步子模块配置**（git submodule sync）
5. ✅ **推送主仓库**（上传到GitHub）
6. ✅ **验证完整性**（测试克隆）

---

**准备好开始了吗？** 🚀
